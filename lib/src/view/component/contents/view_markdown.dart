import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MarkdownView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      //controller: _textController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20),
          border: OutlineInputBorder(),
          hintText: 'Enter contents'),
    );
  }
}
