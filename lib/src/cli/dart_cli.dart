part of 'cli.dart';

/// Dart CLI
class Dart {
  /// Determine whether dart is installed.
  static Future<bool> installed({
    required Logger logger,
  }) async {
    try {
      await _Cmd.run('dart', ['--version'], logger: logger);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Install dart dependencies (`dart pub get`).
  static Future<bool> pubGet({
    required Logger logger,
    String cwd = '.',
    bool recursive = false,
    Set<String> ignore = const {},
  }) async {
    final initialCwd = cwd;

    final result = await _runCommand(
      cmd: (cwd) async {
        final relativePath = p.relative(cwd, from: initialCwd);
        final path =
            relativePath == '.' ? '.' : '.${p.context.separator}$relativePath';

        final installProgress = logger.progress(
          'Running "dart pub get" in $path',
        );

        try {
          await _verifyGitDependencies(cwd, logger: logger);
        } catch (_) {
          installProgress.fail();
          rethrow;
        }

        try {
          return await _Cmd.run(
            'dart',
            ['pub', 'get'],
            workingDirectory: cwd,
            logger: logger,
          );
        } finally {
          installProgress.complete();
        }
      },
      cwd: cwd,
      recursive: recursive,
      ignore: ignore,
    );
    return result.every((e) => e.exitCode == ExitCode.success.code);
  }

  /// Activate stacked_cli globally.
  static Future<bool> activateStackedCli({
    required Logger logger,
  }) async {
    final activateProgress = logger.progress(
      'Activating stacked_cli globally',
    );

    try {
      final result = await _Cmd.run(
        'dart',
        ['pub', 'global', 'activate', 'stacked_cli'],
        logger: logger,
      );

      if (result.exitCode == ExitCode.success.code) {
        activateProgress.complete('stacked_cli activated successfully');
        return true;
      } else {
        activateProgress.fail('Failed to activate stacked_cli');
        return false;
      }
    } catch (e) {
      activateProgress.fail('Error activating stacked_cli: $e');
      return false;
    }
  }

  /// Apply all fixes (`dart fix --apply`).
  static Future<void> applyFixes({
    required Logger logger,
    String cwd = '.',
    bool recursive = false,
    Set<String> ignore = const {},
  }) async {
    if (!recursive) {
      final pubspec = File(p.join(cwd, 'pubspec.yaml'));
      if (!pubspec.existsSync()) throw PubspecNotFound();

      await _Cmd.run(
        'dart',
        ['fix', '--apply'],
        workingDirectory: cwd,
        logger: logger,
      );
      return;
    }

    final processes = _Cmd.runWhere(
      run: (entity) => _Cmd.run(
        'dart',
        ['fix', '--apply'],
        workingDirectory: entity.parent.path,
        logger: logger,
      ),
      where: (entity) => !ignore.excludes(entity) && _isPubspec(entity),
      cwd: cwd,
    );

    if (processes.isEmpty) throw PubspecNotFound();

    await Future.wait<void>(processes);
  }
}
