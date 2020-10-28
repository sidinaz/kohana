library kohana_annotations;

class ManagedInit {
  final List<String> generateForDir;

  final bool preferRelativeImports;

  final String initializerName;

  final String routerInitializerName;

  final String moduleName;

  final int generationMode;

  const ManagedInit({
    this.generateForDir = const ['lib'],
    this.preferRelativeImports = false,
    this.initializerName = 'register',
    this.routerInitializerName = 'configRouter',
    this.moduleName = 'GeneratedModule',
    this.generationMode = 0,
  })  : assert(generateForDir != null),
        assert(initializerName != null),
        assert(routerInitializerName != null),
        assert(preferRelativeImports != null),
        assert(generationMode != null);
}

class Managed {
  final Type as;
  final String tag;
  final List<String> env;

  const Managed({this.as, this.env, this.tag});
}

class View extends Managed {
  const View({Type as, String tag, List<String> env}) : super(as: as, tag: tag, env: env);
}

class Controller extends Managed {
  const Controller({Type as, String tag, List<String> env}) : super(as: as, tag: tag, env: env);
}

class Singleton extends Managed {
  final bool signalsReady;

  final List<Type> dependsOn;

  const Singleton({
    this.signalsReady,
    this.dependsOn,
    Type as,
    List<String> env,
  }) : super(as: as, env: env);
}

class LazySingleton extends Managed {
  const LazySingleton({
    Type as,
    List<String> env,
  }) : super(as: as, env: env);
}

class Named {
  final String name;

  const Named(this.name) : type = null;

  final Type type;

  const Named.from(this.type) : name = null;
}

class FactoryMethod {
  const FactoryMethod._();
}

class FactoryParam {
  const FactoryParam._();
}

class Module {
  const Module._();
}

const managedInit = ManagedInit();
const managed = Managed();
const singleton = Singleton();
const lazySingleton = LazySingleton();
const controller = Controller();
const named = Named('');
