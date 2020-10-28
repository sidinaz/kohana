import 'package:kohana_generator/dependency_config.dart';
import 'package:kohana_generator/generator/register_func_generator.dart';
import 'package:kohana_generator/injectable_types.dart';

class ControllerFactoryGenerator extends RegisterFuncGenerator {

  ControllerFactoryGenerator(Set<ImportableType> prefixedTypes):super(prefixedTypes);

  @override
  String generate(DependencyConfig dep) {
    final initializer = generateInitializer(dep, getIt: "container");

    var constructor = initializer;

    // write("container.$funcName$asyncStr<${dep.type.getDisplayName(prefixedTypes)}>(()=> $constructor");
    // write("//container. $funcName ${dep.instanceName} < ${dep.type.getDisplayName(prefixedTypes)} >(()=> $constructor");


    // write(functionStart + "$constructor$extraAs$extraTag);");
    write("$constructor.bindRouter(container());");

    // closeRegisterFunc(dep);
    return buffer.toString();
  }
}
