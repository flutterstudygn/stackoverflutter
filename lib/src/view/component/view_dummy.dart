import 'package:flutter/material.dart';

class DummyView extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Color color;

  DummyView({this.width, this.height, this.radius, this.color});
  factory DummyView.size(double width, double height) {
    return DummyView(width: width, height: height);
  }
  factory DummyView.height(double height) {
    return DummyView(width: null, height: height);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: width ?? 0,
        maxHeight: height ?? 0,
        maxWidth: width ?? double.infinity,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 4.0),
        color: color ?? Colors.black26,
      ),
    );
  }
}
