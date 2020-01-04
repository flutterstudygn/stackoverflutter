import 'package:flutter/material.dart';

class CommentEditorView extends StatefulWidget {
  @override
  _CommentEditorViewState createState() => _CommentEditorViewState();
}

class _CommentEditorViewState extends State<CommentEditorView> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Page"),
      ),
      body: _buildTextComposer(),
    );
  }

  _buildTextComposer() {
    return Container(
      padding: EdgeInsets.all(15.0),
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
          TextField(
            textAlign: TextAlign.left,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            //controller: _textController,
            decoration: InputDecoration(
                //contentPadding: EdgeInsets.symmetric(vertical: 20),
                border: OutlineInputBorder(),
                hintText: 'Enter contents'),
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
                onPressed: () {},
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
