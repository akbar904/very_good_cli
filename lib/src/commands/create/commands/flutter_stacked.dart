import 'package:very_good_cli/src/commands/commands.dart';
import 'package:very_good_cli/src/commands/create/templates/templates.dart';

/// {@template very_good_create_flutter_stacked_command}
/// A [CreateSubCommand] for creating Flutter apps with Stacked architecture.
/// {@endtemplate}
class CreateFlutterStacked extends CreateSubCommand with OrgName {
  /// {@macro very_good_create_flutter_stacked_command}
  CreateFlutterStacked({
    required super.logger,
    required super.generatorFromBundle,
    required super.generatorFromBrick,
  });

  @override
  String get name => 'flutter_stacked';

  @override
  String get description =>
      'Generate a Steve Flutter app using Stacked architecture.';

  @override
  Template get template => VeryGoodFlutterStacked();

  @override
  Map<String, dynamic> getTemplateVars() {
    final vars = super.getTemplateVars();
    // Add any Stacked-specific variables here if needed
    return vars;
  }
}
