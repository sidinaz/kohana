import 'package:kohana_generator/dependency_config.dart';
import 'package:kohana_generator/generator/register_func_generator.dart';
import 'package:kohana_generator/injectable_types.dart';

class DaggeritoFactoryGenerator extends RegisterFuncGenerator {
  final isLazySingleton;
  final String funcName;

  DaggeritoFactoryGenerator(Set<ImportableType> prefixedTypes, {this.isLazySingleton = false})
      : funcName = isLazySingleton ? 'lazySingleton' : 'factory',
        super(prefixedTypes);

  @override
  String generate(DependencyConfig dep) {
    final initializer = generateInitializer(dep, getIt: dep.injectableType == InjectableType.singleton ? "container": "\$");

    var constructor = initializer;
    String as = dep.as ?? (dep.isView ? "Widget" : null);

    String functionStart;
    switch (dep.injectableType) {
      case InjectableType.singleton:
        functionStart = "container.registerInstance(";
        break;
      case InjectableType.lazySingleton:
        functionStart = "container.registerSingleton((\$) => ";
        break;
      default:
        functionStart = "container.register((\$) => ";
    }

    final typeName = dep.typeImpl.getDisplayName(prefixedTypes);

    // write("container.$funcName$asyncStr<${dep.type.getDisplayName(prefixedTypes)}>(()=> $constructor");
    // write("//container. $funcName ${dep.instanceName} < ${dep.type.getDisplayName(prefixedTypes)} >(()=> $constructor");
    String tag = dep.tag ?? dep.instanceName;
    String extraTag = tag != null ? ', tag: "$tag"' : "";
    String extraAs = as != null ? ', as: $as' : "";
    if(extraTag.isEmpty && dep.isView){
      extraTag = ', tag: "$typeName"';
    }
    write(functionStart + "$constructor$extraAs$extraTag);");

    // closeRegisterFunc(dep);
    return buffer.toString();
  }
}
