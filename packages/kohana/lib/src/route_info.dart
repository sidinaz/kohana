import 'package:equatable/equatable.dart';

class RouteInfo with EquatableMixin {
  final String path;
  final Map<String, dynamic> params;

  RouteInfo(this.path, {this.params});

  @override
  List<Object> get props => [path, params];
}
