part of 'config_code_generator.dart';

class ManagedCodeGenerator extends ConfigCodeGenerator {
  final String routerInitializerName;
  final String moduleName;
  final int generationMode;

  ManagedCodeGenerator(List<DependencyConfig> allDeps,
      {Uri targetFile, String initializerName, this.generationMode, this.moduleName, this.routerInitializerName})
      : super(allDeps, targetFile: targetFile, initializerName: initializerName);

  void removeControllers() => allDeps.removeWhere((element) => element.isController);

  void removOthers() => allDeps.removeWhere((element) => !element.isController);

  @override
  FutureOr<String> generate() async {
    // clear previously registered var names
    registeredVarNames.clear();
    if (generationMode != 0) {
      if (generationMode == 1) {
        removeControllers();
      }
      if (generationMode == 2) {
        removOthers();
      }
    }
    var importsWithPrefixes = _addRequiredPrefixes(allDeps);

    prefixedTypes.addAll(importsWithPrefixes.where((e) => e.prefix != null));
    _generateImports(importsWithPrefixes);

    // sort dependencies alphabetically
    allDeps.sort((a, b) => a.type.name.compareTo(b.type.name));

    // sort dependencies by their register order
    final Set<DependencyConfig> sorted = {};
    _sortByDependents(allDeps.toSet(), sorted);

    final modules = sorted.where((d) => d.isFromModule).map((d) => d.module).toSet();

    final environments = sorted.fold(<String>{}, (prev, elm) => prev..addAll(elm.environments));
    if (environments.isNotEmpty) {
      environments.forEach((env) => _writeln("const _$env = '$env';"));
    }
    final eagerDeps = sorted.where((d) => d.injectableType == InjectableType.singleton).toSet();

    final _lazyDeps = sorted.difference(eagerDeps);

    final controllers = _lazyDeps.where((d) => d.isController).toSet();

    final lazyDeps = _lazyDeps.difference(controllers);

    if (generationMode < 2) {
      _writeln('class $moduleName implements Module {');
      _writeln("@override");
      _writeln("void $initializerName(DependencyContainer container) {");

      _generateDeps(lazyDeps);

      if (eagerDeps.isNotEmpty) {
        _generateDeps(eagerDeps);
      }
      _write('}');
      _write('}');
    }

    if (generationMode != 1) {
      if (controllers.isNotEmpty) {
        _generateRouterConfig(controllers);
      }
    }

    return _buffer.toString();
  }

  void _generateDeps(Iterable<DependencyConfig> deps) =>
      deps.forEach((dep) => _writeln(DaggeritoFactoryGenerator(prefixedTypes).generate(dep)));

  void _generateRouterConfig(Iterable<DependencyConfig> deps) {
    _write('void $routerInitializerName(DependencyContainer container){');
    deps.forEach((dep) => _writeln(ControllerFactoryGenerator(prefixedTypes).generate(dep)));
    _write('}');
  }

  Set<ImportableType> _addRequiredPrefixes(Iterable<DependencyConfig> deps) {
    final importableTypes = deps.fold<List<ImportableType>>([], (a, b) => a..addAll(b.allImportableTypes));
    // add getIt import statement
    importableTypes.add(
      ImportableType(
        name: 'Daggerito',
        import: 'package:daggerito/daggerito.dart',
      ),
    );

    return ImportableTypeResolver.resolvePrefixes(importableTypes.toSet());
  }
}
