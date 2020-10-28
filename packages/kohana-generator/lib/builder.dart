import 'package:build/build.dart';
import 'package:kohana_generator/serialize_generator.dart';
import 'package:source_gen/source_gen.dart';

import 'managed_config_generator.dart';
import 'kohana_generator.dart';

Builder managedBuilder(BuilderOptions options) => LibraryBuilder(
    ManagedGenerator(options.config),
    formatOutput: (generated) => generated.replaceAll(RegExp(r'//.*|\s'), ''),
    generatedExtension: '.managed.json',
  );

Builder managedConfigBuilder(BuilderOptions options) => LibraryBuilder(
    ManagedConfigGenerator(),
    generatedExtension: '.managed.dart',
  );

Builder serializeGeneratorBuilder(BuilderOptions options) =>
    SharedPartBuilder([SerializeGenerator()], 'serialize');
