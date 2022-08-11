import 'dart:ui';

class IconModel {
  String path;
  int id;
  Color color;
  bool selected = false;
  IconModel(
      {required this.id,
      required this.path,
      required this.color,
      required this.selected});
}
