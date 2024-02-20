import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

@immutable
final class ProjectPadding extends EdgeInsets {
  final BuildContext context;

  ProjectPadding.allNormalDynamic(this.context)
      : super.only(
          top: context.sized.dynamicHeight(0.02),
          bottom: context.sized.dynamicHeight(0.02),
          left: context.sized.dynamicWidth(0.04),
          right: context.sized.dynamicWidth(0.04),
        );

  ProjectPadding.allNormal(this.context) : super.all(context.sized.normalValue);
}
