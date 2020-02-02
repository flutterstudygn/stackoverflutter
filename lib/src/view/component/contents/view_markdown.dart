import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MarkdownView extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  MarkdownView({@required this.controller, this.hintText})
      : assert(controller != null);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        border: OutlineInputBorder(),
        hintText: hintText ?? 'Enter contents',
      ),
    );
  }
}
