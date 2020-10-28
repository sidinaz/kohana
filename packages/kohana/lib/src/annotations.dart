import 'package:flutter/material.dart';
import 'package:kohana_annotations/kohana_annotations.dart';

class Screen extends View{
  const Screen({Type as,
    String tag,
    List<String> env}):super(as: as ?? Widget, tag: tag, env: env);
}

const screen = Screen();
