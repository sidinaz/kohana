// holds extracted data from annotation & element
// to be used later when generating the register function

import 'package:collection/collection.dart' show ListEquality;

class DependencyConfig {
  ImportableType type;
  ImportableType typeImpl;
  List<InjectedDependency> dependencies;
  int injectableType;
  String instanceName;
  bool signalsReady;
  List<String> environments;
  String initializerName;
  String tag;
  String as;
  String constructorName;
  bool isAsync;
  List<String> dependsOn;
  bool preResolve;
  bool isAbstract = false;
  bool isModuleMethod = false;
  bool isView = false;
  bool isController = false;
  ImportableType module;

  DependencyConfig({
    this.type,
    this.dependencies,
    this.injectableType,
    this.instanceName,
    this.signalsReady,
    this.typeImpl,
    this.environments,
    this.initializerName,
    this.tag,
    this.constructorName = '',
    this.isAsync = false,
    this.dependsOn,
    this.preResolve = false,
    this.isAbstract = false,
    this.isModuleMethod,
    this.module,
  }) {
    environments ??= [];
    dependencies ??= [];
    dependsOn ??= [];
  }

  Set<ImportableType> get allImportableTypes {
    var importableTypes = <ImportableType>{};
    if (type.fold != null) {
      importableTypes.addAll(type.fold);
    }
    if (typeImpl != null) {
      importableTypes.addAll(typeImpl.fold);
    }
    if (module != null) {
      importableTypes.addAll(module.fold);
    }
    if (dependencies?.isNotEmpty == true) {
      dependencies.forEach((dep) => importableTypes.addAll(dep.type.fold));
    }
    return importableTypes;
  }

  DependencyConfig.fromJson(Map<String, dynamic> json) {
    if (json['type'] != null) {
      type = ImportableType.fromJson(json['type']);
    }

    if (json['typeImpl'] != null) {
      typeImpl = ImportableType.fromJson(json['typeImpl']);
    }

    if (json['module'] != null) {
      module = ImportableType.fromJson(json['module']);
    }

    tag = json['tag'];
    as = json['as'];
    instanceName = json['instanceName'];
    signalsReady = json['signalsReady'];
    initializerName = json['initializerName'] ?? '';
    constructorName = json['constructorName'] ?? '';
    isAsync = json['isAsync'] ?? false;
    preResolve = json['preResolve'] ?? preResolve;

    dependsOn = json['dependsOn']?.cast<String>() ?? [];
    if (json['dependencies'] != null) {
      dependencies = [];
      json['dependencies'].forEach((v) {
        dependencies.add(InjectedDependency.fromJson(v));
      });
    }

    injectableType = json['injectableType'];
    environments = json['environments']?.cast<String>() ?? [];
    isAbstract = json['isAbstract'] ?? false;
    isModuleMethod = json['isModuleMethod'] ?? false;
    isView = json['isView'] ?? false;
    isController = json['isController'] ?? false;
  }

  bool get isFromModule => module != null;

  bool get registerAsInstance => isAsync && preResolve;

  Map<String, dynamic> toJson() => {
        if (type != null) 'type': type.toJson(),
        if (typeImpl != null) 'typeImpl': typeImpl.toJson(),
        if (module != null) 'module': module.toJson(),
        "isAsync": isAsync,
        "preResolve": preResolve,
        "injectableType": injectableType,
        "dependsOn": dependsOn,
        "environments": environments,
        "dependencies": dependencies.map((v) => v.toJson()).toList(),
        if (tag != null) "tag": tag,
        if (as != null) "as": as,
        if (instanceName != null) "instanceName": instanceName,
        if (signalsReady != null) "signalsReady": signalsReady,
        if (initializerName != null) "initializerName": initializerName,
        if (constructorName != null) "constructorName": constructorName,
        if (isAbstract != null) 'isAbstract': isAbstract,
        if (isModuleMethod != null) 'isModuleMethod': isModuleMethod,
        if (isView != null) 'isView': isView,
        if (isController != null) 'isController': isController,
      };
}

class InjectedDependency {
  ImportableType type;
  String name;
  String paramName;
  bool isFactoryParam;
  bool isPositional;

  InjectedDependency({
    this.type,
    this.name,
    this.paramName,
    this.isFactoryParam,
    this.isPositional,
  });

  InjectedDependency.fromJson(Map<String, dynamic> json) {
    name = json['name'];

    if (json['type'] != null) {
      type = ImportableType.fromJson(json['type']);
    }
    paramName = json['paramName'];
    isFactoryParam = json['isFactoryParam'];
    isPositional = json['isPositional'];
  }

  Map<String, dynamic> toJson() => {
        "isFactoryParam": isFactoryParam,
        "isPositional": isPositional,
        if (type != null) 'type': type.toJson(),
        if (name != null) "name": name,
        if (paramName != null) "paramName": paramName,
      };
}

class ImportableType {
  String import;
  String name;
  List<ImportableType> typeArguments;
  String prefix;

  ImportableType({this.name, this.import, this.typeArguments, this.prefix});

  List<ImportableType> get fold {
    final list = [this];
    typeArguments?.forEach((iType) {
      list.addAll(iType.fold);
    });
    return list;
  }

  String get identity => "$import#$name";

  String fullName({bool includeTypeArgs = true, bool includePrefix = true}) {
    var namePrefix = includePrefix && prefix != null ? '$prefix.' : '';
    var typeArgs = includeTypeArgs && (typeArguments?.isNotEmpty == true)
        ? "<${typeArguments.map((e) => e.fullName(
              includePrefix: includePrefix,
              includeTypeArgs: includePrefix,
            )).join(',')}>"
        : '';
    return "$namePrefix$name$typeArgs";
  }

  String getDisplayName(Set<ImportableType> prefixedTypes, {bool includeTypeArgs = true}) {
    return prefixedTypes?.lookup(this)?.fullName(includeTypeArgs: includeTypeArgs) ?? fullName(includeTypeArgs: includeTypeArgs);
  }

  String get importName => "'$import' ${prefix != null ? 'as $prefix' : ''}";

  ImportableType copyWith({String import, String prefix}) {
    return ImportableType(
      import: import ?? this.import,
      prefix: prefix ?? this.prefix,
      name: this.name,
      typeArguments: this.typeArguments,
    );
  }

  ImportableType.fromJson(Map<String, dynamic> json) {
    import = json['import'];
    name = json['name'];
    if (json['typeArguments'] != null) {
      typeArguments = [];
      json['typeArguments'].forEach((v) {
        typeArguments.add(ImportableType.fromJson(v));
      });
    }
  }

  @override
  String toString() => fullName(includePrefix: false);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ImportableType &&
              runtimeType == other.runtimeType &&
              identity == other.identity &&
              ListEquality().equals(typeArguments, other.typeArguments);

  @override
  int get hashCode =>
      import.hashCode ^ name.hashCode ^ ListEquality().hash(typeArguments);

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "import": import,
        if (typeArguments?.isNotEmpty == true)
          "typeArguments": typeArguments.map((v) => v.toJson()).toList(),
      };
}
