import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/contents/question_item.dart';

class QuestionItemView extends StatelessWidget {
  final QuestionItem _item;
  QuestionItemView(this._item, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _item?.id == null
          ? null
          : () {
              Navigator.of(context).pushNamed('/questions?id=${_item.id}');
            },
      child: Container(
        width: double.infinity,
        child: Container(height: 80.0),
      ),
    );
  }
}
