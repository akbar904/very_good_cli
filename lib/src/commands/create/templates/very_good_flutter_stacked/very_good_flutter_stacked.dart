import 'package:mason/mason.dart';
import 'package:universal_io/io.dart';
import 'package:very_good_cli/src/commands/create/templates/template.dart';

/// {@template very_good_flutter_stacked}
/// A Very Good Flutter project template using Stacked state management.
/// {@endtemplate}
class VeryGoodFlutterStacked extends Template {
  /// {@macro very_good_flutter_stacked}
  const VeryGoodFlutterStacked()
      : super(
          name: 'flutter_stacked',
          bundle: flutterStackedBundle,
          help:
              'Creates a Very Good Flutter app using Stacked state management.',
        );

  /// The [MasonBundle] for this template.
  static final flutterStackedBundle = MasonBundle.fromJson(_bundleJson);

  @override
  Future<void> onGenerateComplete(Logger logger, Directory outputDir) async {
    // Add any post-generation steps here
  }
}

// TODO: Replace this with your actual bundle JSON
const _bundleJson = <String, dynamic>{
  // Your bundle JSON goes here
};
