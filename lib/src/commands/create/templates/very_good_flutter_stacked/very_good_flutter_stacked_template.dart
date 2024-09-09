import 'package:mason/mason.dart';
import 'package:universal_io/io.dart';
import 'package:very_good_cli/src/commands/create/templates/post_generate_actions.dart';
import 'package:very_good_cli/src/commands/create/templates/template.dart';
import 'package:very_good_cli/src/commands/create/templates/very_good_flutter_stacked/very_good_flutter_stacked_bundle.dart';
import 'package:very_good_cli/src/logger_extension.dart';

/// {@template very_good_flutter_stacked}
/// A Very Good Flutter project template using Stacked state management.
/// {@endtemplate}
class VeryGoodFlutterStacked extends Template {
  /// {@macro very_good_flutter_stacked}
  VeryGoodFlutterStacked()
      : super(
          name: 'flutter_stacked',
          bundle: veryGoodFlutterStackedBundle,
          help: 'Creates a Very Good Flutter app using Stacked.',
        );

  @override
  Future<void> onGenerateComplete(Logger logger, Directory outputDir) async {
    if (await installFlutterPackages(logger, outputDir)) {
      if (await activateStackedCli(logger)) {
        await runStackedGenerate(logger, outputDir);
      }
      await applyDartFixes(logger, outputDir);
    }
    _logSummary(logger);
  }

  void _logSummary(Logger logger) {
    logger
      ..info('\n')
      ..created('Generate a Steve Flutter application with Stacked 🚀')
      ..info('\n');
  }
}
