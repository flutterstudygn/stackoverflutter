import 'package:flutter/material.dart';

import '../../../src/model/contents/contents_item.dart';
import '../../../src/view/component/contents/view_markdown.dart';

class ContentsEditPage extends StatefulWidget {
  final ContentsType _contentsType;
  final String passedItemId;
  final ContentsItem passedItem;

  const ContentsEditPage(
    this._contentsType, {
    this.passedItemId,
    this.passedItem,
    Key key,
  }) : super(key: key);

  static const String routeNameArticle = '/articles/edit';
  static const String routeNameQuestion = '/questions/edit';

  factory ContentsEditPage.article() {
    return ContentsEditPage(ContentsType.ARTICLE);
  }

  factory ContentsEditPage.question() {
    return ContentsEditPage(ContentsType.QUESTION);
  }

  @override
  ContentsEditPageState createState() => ContentsEditPageState();
}

class ContentsEditPageState extends State<ContentsEditPage> {
  //final TextEditingController _textController = new TextEditingController();

  List __items;
  double _fontSize = 14;

//  @override
//  void initState(){
//    super.initState();
//    // if you store data on a local database (sqflite), then you could do something like this
//    Model().getItems().then((items){
//      _items = items;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget._contentsType == ContentsType.ARTICLE
              ? 'Article'
              : widget._contentsType == ContentsType.QUESTION
                  ? 'Questions'
                  : '-'),
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
          Text(
            'Title',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ),
          SizedBox(height: 10),
          TextField(
            //controller: _textController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Enter title'),
          ),
          SizedBox(height: 10),
          Text(
            'Contents',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ),
          SizedBox(height: 10),
          Expanded(
            child: MarkdownEditor(
              hintText: 'Enter contents',
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Tags',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ),
          SizedBox(height: 10),
          TextField(
            //controller: _textController,
            decoration:
                InputDecoration(border: OutlineInputBorder(), hintText: 'Tags'),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RaisedButton(
                color: Colors.blueAccent,
                onPressed: () {
                  switch (widget._contentsType) {
                    case ContentsType.ARTICLE:
//                      api.createArticle(item);
                      break;
                    case ContentsType.QUESTION:
//                      api.createQuestion(item);
                      break;
                  }
                },
                textColor: Colors.white,
                child: Text(
                  'SUBMIT',
                  style: TextStyle(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
