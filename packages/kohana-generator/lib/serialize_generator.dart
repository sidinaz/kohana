import 'package:build/build.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:json_annotation/json_annotation.dart';

class SerializeGenerator extends GeneratorForAnnotation<JsonSerializable> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    var buffer = StringBuffer();

    // buffer.writeln('// ${annotation.read('nullable')?.boolValue}');
    // extension $OrderSerializer on Order {
    //   static Order fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
    //   Map<String, dynamic> toJson() => _$OrderToJson(this);
    // }
    final className = element.displayName;

    buffer.writeln('extension \$${className}Serializer on ${className} {');

    buffer.writeln(
        'static ${className} fromJson(Map<String, dynamic> json) => _\$${className}FromJson(json);');
    buffer.writeln(
        'Map<String, dynamic> toJson() => _\$${className}ToJson(this);');

    buffer.writeln('}');

    return buffer.toString();
  }
}
