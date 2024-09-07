part of 'cli.dart';

/// Stacked CLI
class Stacked {
  /// Run stacked CLI with the given arguments.
  static Future<bool> run(
    List<String> arguments, {
    required Logger logger,
    String cwd = '.',
  }) async {
    final result = await _Cmd.run(
      'stacked',
      arguments,
      workingDirectory: cwd,
      logger: logger,
    );
    return result.exitCode == ExitCode.success.code;
  }

  /// Run 'stacked compile' command.
  static Future<bool> compile({
    required Logger logger,
    String cwd = '.',
  }) async {
    final compileProgress = logger.progress('Running stacked compile');
    try {
      final success = await run(['compile'], logger: logger, cwd: cwd);
      if (success) {
        compileProgress.complete('Stacked compile completed successfully');
      } else {
        compileProgress.fail('Stacked compile failed');
      }
      return success;
    } catch (e) {
      compileProgress.fail('Error running stacked compile: $e');
      return false;
    }
  }

  /// Run 'stacked create' command with given arguments.
  static Future<bool> create(
    List<String> arguments, {
    required Logger logger,
    String cwd = '.',
  }) async {
    final createProgress = logger.progress('Running stacked create');
    try {
      final success =
          await run(['create', ...arguments], logger: logger, cwd: cwd);
      if (success) {
        createProgress.complete('Stacked create completed successfully');
      } else {
        createProgress.fail('Stacked create failed');
      }
      return success;
    } catch (e) {
      createProgress.fail('Error running stacked create: $e');
      return false;
    }
  }

  /// Run 'stacked delete' command with given arguments.
  static Future<bool> delete(
    List<String> arguments, {
    required Logger logger,
    String cwd = '.',
  }) async {
    final deleteProgress = logger.progress('Running stacked delete');
    try {
      final success =
          await run(['delete', ...arguments], logger: logger, cwd: cwd);
      if (success) {
        deleteProgress.complete('Stacked delete completed successfully');
      } else {
        deleteProgress.fail('Stacked delete failed');
      }
      return success;
    } catch (e) {
      deleteProgress.fail('Error running stacked delete: $e');
      return false;
    }
  }

  /// Run 'stacked generate' command.
  static Future<bool> generate({
    required Logger logger,
    String cwd = '.',
  }) async {
    final generateProgress = logger.progress('Running stacked generate');
    try {
      final success = await run(['generate'], logger: logger, cwd: cwd);
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

  /// Run 'stacked update' command.
  static Future<bool> update({
    required Logger logger,
    String cwd = '.',
  }) async {
    final updateProgress = logger.progress('Updating stacked_cli');
    try {
      final success = await run(['update'], logger: logger, cwd: cwd);
      if (success) {
        updateProgress.complete('stacked_cli updated successfully');
      } else {
        updateProgress.fail('Failed to update stacked_cli');
      }
      return success;
    } catch (e) {
      updateProgress.fail('Error updating stacked_cli: $e');
      return false;
    }
  }
}
