import 'package:flutter/material.dart';

@immutable
final class ProjectColors {
  static ProjectColors? _instance;
  static ProjectColors get instance {
    _instance ??= ProjectColors._init();
    return _instance!;
  }

  ProjectColors._init();
  // Core
  final Color white = Colors.white;
  final Color black = Colors.black;
  final Color red = Colors.red;
  final Color blue = Colors.blue;
  // Bottom Nav Bar
  final Color bottomNavigationBarColor = Colors.grey.shade800;
  // Chat Detail View
  final Color chatDetailOtherMessageColor = Colors.grey[800]!;
  final Color chatDetailMainMessageColor = Colors.green[800]!;
}
