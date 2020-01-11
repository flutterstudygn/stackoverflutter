import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stackoverflutter/src/bloc/contents_detail_bloc.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/model/user/user_item.dart';

class ContentsDetailPage extends StatefulWidget {
  final ContentsType _contentsType;
  final String passedItemId;
  final ContentsItem passedItem;

  static const String routeNameArticle = '/articles/detail';
  static const String routeNameQuestion = '/questions/detail';

  const ContentsDetailPage(
    this._contentsType, {
    this.passedItemId,
    this.passedItem,
    Key key,
  }) : super(key: key);

  factory ContentsDetailPage.article(String itemId, ContentsItem item) {
    return ContentsDetailPage(ContentsType.ARTICLE,
        passedItemId: itemId, passedItem: item);
  }

  factory ContentsDetailPage.question(String itemId, ContentsItem item) {
    return ContentsDetailPage(ContentsType.QUESTION,
        passedItemId: itemId, passedItem: item);
  }

  @override
  _ContentsDetailPageState createState() => _ContentsDetailPageState();
}

class _ContentsDetailPageState extends State<ContentsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(widget._contentsType == ContentsType.ARTICLE ? 'Article' : widget._contentsType == ContentsType.QUESTION ? 'Questions' : '-'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.account_circle,
                    size: 40,
                  ),
                  Text(
                    'Name',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Column(
                children: <Widget>[Text('2022.5.5')],
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),

          Row(
            children: <Widget>[
              Text(
                'Project',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )
            ],
          ),
          Divider(
            color: Colors.transparent,
            height: 10,
          ),
          Row(
            children: <Widget>[Text('Hi~!@~!@~@@')],
          ),

          Divider(
            color: Colors.transparent,
            height: 30,
          ),

          Row(
            children: <Widget>[
              Text(
                'Problem',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )
            ],
          ),
          Divider(
            color: Colors.transparent,
            height: 10,
          ),
          Row(
            children: <Widget>[Text('Im stuck with..')],
          ),

          Divider(
            color: Colors.transparent,
            height: 50,
          ),
///////////////////////////////////////////////////

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Answers',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '5 answers',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '    ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Recent',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.account_circle,
                    size: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Name2',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '2019.12.17 23:18',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.favorite_border),
                  )
                ],
              ),
            ],
          ),

          Row(
            children: <Widget>[
              Text(
                'Widget build ( SDFSDSDFSF)Widget build ( SDFSDSDFSF)',
                style: TextStyle(fontSize: 15),
              )
            ],
          ),

          Divider(
            color: Colors.transparent,
            height: 10,
          ),
          Divider(
            color: Colors.black38,
            height: 1,
          ),





          Divider(
            color: Colors.transparent,
            height: 50,
          ),
          Text(
            'Your answer',
            style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
          ),
          TextField(
              textAlign: TextAlign.left,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              //controller: _textController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  border: OutlineInputBorder(),
                  hintText: 'Enter contents'),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[


              RaisedButton(
                color: Colors.blueAccent,
                onPressed: () {
                  switch(widget._contentsType) {
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

//    return SingleChildScrollView
//      (
//      child: Provider<ContentsDetailBloc>(
//        create: (ctx) => ContentsDetailBloc(ctx, _contentsType)
//          ..init(passedItemId, passedItem),
//        dispose: (_, bloc) => bloc.dispose(),
//        child: Consumer<ContentsDetailBloc>(
//          builder: (_, bloc, __) {
//            return StreamBuilder<ContentsItem>(
//              stream: bloc.item,
//              builder: (_, snapshot) {
//                ContentsItem item = snapshot.data;
//                return Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    StreamBuilder<UserItem>(
//                      stream: bloc.userInfo,
//                      builder: (_, snapshot) {
//                        return Text(snapshot?.data?.toString() ?? '-');
//                      },
//                    ),
//                    Text(item?.toString() ?? '-'),
//                    StreamBuilder<bool>(
//                      stream: bloc.isLike,
//                      builder: (_, snapshot) {
//                        return InkWell(
//                          onTap: snapshot?.data != null
//                              ? () => bloc.toggleLike(context)
//                              : null,
//                          child: Text('isLike: ${snapshot?.data ?? '-'}'),
//                        );
//                      },
//                    ),
//                  ],
//                );
//              },
//            );
//          },
//        ),
//      ),
//    );
  }
}
