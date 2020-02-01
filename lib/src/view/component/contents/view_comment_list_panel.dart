import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stackoverflutter/src/bloc/comment_list_bloc.dart';
import 'package:stackoverflutter/src/bloc/session_bloc.dart';
import 'package:stackoverflutter/src/model/comments/comment_item.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';
import 'package:stackoverflutter/src/view/component/contents/view_comment_list.dart';
import 'package:stackoverflutter/src/view/component/view_panel_header.dart';

class CommentListPanel extends StatelessWidget {
  final ContentsType _contentsType;
  final String _contentsId;
  CommentListPanel(this._contentsType, this._contentsId);

  @override
  Widget build(BuildContext context) {
    return Provider<CommentListBloc>(
      create: (_) => CommentListBloc(_contentsType, _contentsId),
      dispose: (_, bloc) => bloc.dispose,
      child: Consumer<CommentListBloc>(
        builder: (ctx, bloc, __) {
          return Column(
            children: <Widget>[
              _buildListHeader(ctx, bloc),
              CommentListView(bloc),
              SizedBox(height: 30),
              Row(
                children: <Widget>[
                  Text(
                    'Your ${_contentsType == ContentsType.QUESTION ? 'answer' : 'comment'}',
                    style: Theme.of(context).textTheme.body2,
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              CommentEditor(_contentsId, _contentsType),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListHeader(BuildContext context, CommentListBloc bloc) {
    String title = '';
    switch (_contentsType) {
      case ContentsType.ARTICLE:
        title = 'Comments';
        break;
      case ContentsType.QUESTION:
        title = 'Answers';
        break;
    }
    return PanelHeaderView(
      title: title,
      sideWidget: Row(
        children: <Widget>[
          StreamBuilder<int>(
            stream: bloc.totalCount,
            builder: (_, snapshot) {
              if (snapshot.data != null && snapshot.data > 0) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text('${snapshot.data} $title'),
                );
              }
              return Container();
            },
          ),
//          _buildOrderBy(context, bloc),
        ],
      ),
    );
  }

  Widget _buildOrderBy(
    BuildContext context,
    CommentListBloc bloc,
  ) {
    return Container(
      width: 140,
      child: StreamBuilder<CommentsOrderBy>(
          stream: bloc.orderByStream,
          builder: (context, snapshot) {
            return DropdownButtonFormField(
              value: snapshot.data ?? bloc.orderBy,
              onChanged: (value) {
                bloc.orderBy = value;
              },
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
              items: List.generate(CommentsOrderBy.values.length, (idx) {
                return _buildOrderByMenu(
                  context,
                  CommentsOrderBy.values[idx],
                );
              }),
            );
          }),
    );
  }

  DropdownMenuItem _buildOrderByMenu(
    BuildContext context,
    CommentsOrderBy orderBy,
  ) {
    return DropdownMenuItem(
      value: orderBy,
      child: Text(
        CommentsOrderByHelper.display(orderBy),
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}

class CommentEditor extends StatefulWidget {
  final String _contentsId;
  final ContentsType _contentsType;

  CommentEditor(this._contentsId, this._contentsType);

  @override
  _CommentEditorState createState() => _CommentEditorState();
}

class _CommentEditorState extends State<CommentEditor> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CommentEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    bool _isSignedIn = Provider.of<SessionBloc>(context, listen: false)
            .currentUser
            ?.userId
            ?.isNotEmpty ==
        true;
    return Column(
      children: <Widget>[
        TextField(
          textAlign: TextAlign.left,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: _textController,
          enabled: _isSignedIn,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 8.0,
            ),
            border: OutlineInputBorder(),
            hintText: _isSignedIn ? 'Enter contents' : 'Please sign in first.',
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            RaisedButton(
              color: Colors.blueAccent,
              textColor: Colors.white,
              child: Text(
                'SUBMIT',
                style: TextStyle(),
              ),
              onPressed: _isSignedIn && _textController.text?.isNotEmpty == true
                  ? () {
                      String comment = _textController.text;
                      String userId =
                          Provider.of<SessionBloc>(context, listen: false)
                              .currentUser
                              ?.userId;
                      CommentItem commentItem = CommentItem.create(userId,
                          widget._contentsId, widget._contentsType, comment);
                      Provider.of<CommentListBloc>(context, listen: false)
                          .writeComment(commentItem)
                          .then((result) {
                        if (result != null) {
                          _textController.clear();
                        }
                      });
                    }
                  : null,
            ),
          ],
        ),
      ],
    );
  }
}
