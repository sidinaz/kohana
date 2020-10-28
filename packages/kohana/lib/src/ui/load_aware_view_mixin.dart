import 'package:flutter/material.dart';
import 'package:kohana/kohana.dart';
import 'package:routex/routex.dart';

mixin LoadAwareBaseViewMixin<T extends BaseViewModel> on BaseView<T> {
  Widget buildWidgetWithActivityIndicator({Widget child}) => Stack(
        children: <Widget>[
          child,
          Observer<bool>(
            stream: model.isWaiting,
            onSuccess: (ctx, isWaiting) => Offstage(
              // offstage: false,
              offstage: !isWaiting,
              child: Center(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          )
        ],
      );
}
