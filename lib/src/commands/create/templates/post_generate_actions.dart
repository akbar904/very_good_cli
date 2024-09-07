import 'package:mason/mason.dart';
import 'package:universal_io/io.dart';
import 'package:very_good_cli/src/cli/cli.dart';

/// Runs `dart pub get` in the [outputDir].
///
/// Completes with `true` is the execution was successful, `false` otherwise.
Future<bool> installDartPackages(
  Logger logger,
  Directory outputDir, {
  bool recursive = false,
}) async {
  final isDartInstalled = await Dart.installed(logger: logger);
  if (isDartInstalled) {
    return Dart.pubGet(
      cwd: outputDir.path,
      recursive: recursive,
      logger: logger,
    );
  }
  return false;
}

/// Activates stacked_cli globally.
///
/// Completes with `true` if the activation was successful, `false` otherwise.
Future<bool> activateStackedCli(Logger logger) async {
  final activateProgress = logger.progress('Activating stacked_cli globally');
  try {
    final success = await Dart.activateStackedCli(logger: logger);
    if (success) {
      activateProgress.complete('stacked_cli activated successfully');
    } else {
      activateProgress.fail('Failed to activate stacked_cli');
    }
    return success;
  } catch (e) {
    activateProgress.fail('Error activating stacked_cli: $e');
    return false;
  }
}

/// Runs `stacked generate` in the [outputDir].
///
/// Completes with `true` if the execution was successful, `false` otherwise.
Future<bool> runStackedGenerate(
  Logger logger,
  Directory outputDir,
) async {
  final generateProgress = logger.progress(
    'Running stacked generate in ${outputDir.path}',
  );
  try {
    final success = await Stacked.generate(
      logger: logger,
      cwd: outputDir.path,
    );
    if (success) {
      generateProgress.complete('Stacked generate completed successfully');
    } else {
      generateProgress.fail('Stacked generate failed');
    }
    return success;
  } catch (e) {
    generateProgress.fail('Error running stacked generate: $e');
    return false;
  }
}

/// Runs `flutter pub get` in the [outputDir].
///
/// Completes with `true` is the execution was successful, `false` otherwise.
Future<bool> installFlutterPackages(
  Logger logger,
  Directory outputDir, {
  bool recursive = false,
}) async {
  final isFlutterInstalled = await Flutter.installed(logger: logger);
  if (isFlutterInstalled) {
    return Flutter.pubGet(
      cwd: outputDir.path,
      recursive: recursive,
      logger: logger,
    );
  }
  return false;
}

/// Runs `flutter pub run flutter_launcher_icons` in the [outputDir].
///
/// Completes with `true` if the execution was successful, `false` otherwise.
Future<bool> generateFlutterLauncherIcons(
  Logger logger,
  Directory outputDir,
) async {
  final isFlutterInstalled = await Flutter.installed(logger: logger);
  if (isFlutterInstalled) {
    final generateIconsProgress = logger.progress(
      'Generating Flutter launcher icons in ${outputDir.path}',
    );
    try {
      final result = await Process.run(
        'flutter',
        ['pub', 'run', 'flutter_launcher_icons'],
        workingDirectory: outputDir.path,
      );
      if (result.exitCode == 0) {
        generateIconsProgress
            .complete('Flutter launcher icons generated successfully.');
        return true;
      } else {
        generateIconsProgress
            .fail('Failed to generate Flutter launcher icons.');
        logger.err(result.stderr as String);
        return false;
      }
    } catch (e) {
      generateIconsProgress.fail('Error generating Flutter launcher icons: $e');
      return false;
    }
  }
  return false;
}

/// Runs `dart fix --apply` in the [outputDir].
Future<void> applyDartFixes(
  Logger logger,
  Directory outputDir, {
  bool recursive = false,
}) async {
  final isDartInstalled = await Dart.installed(logger: logger);
  if (isDartInstalled) {
    final applyFixesProgress = logger.progress(
      'Running "dart fix --apply" in ${outputDir.path}',
    );
    await Dart.applyFixes(
      cwd: outputDir.path,
      recursive: recursive,
      logger: logger,
    );
    applyFixesProgress.complete();
  }
}
