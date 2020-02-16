import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownEditor extends StatefulWidget {
  final String hintText;

  const MarkdownEditor({Key key, this.hintText}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MarkdownEditorState();
}

class MarkdownEditorState extends State<MarkdownEditor>
    with SingleTickerProviderStateMixin {
  final TextEditingController textEditingController = TextEditingController();
  final GlobalKey<FormFieldState> _formFieldKey = GlobalKey();

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.black,
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: 'Editor'),
            Tab(text: 'Viewer'),
          ],
          onTap: (_) => setState(() {}),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              TextFormField(
                key: _formFieldKey,
                validator: (text) {
                  String errorMessage;

                  if (text.isEmpty) errorMessage = 'Body is missing.';

                  return errorMessage;
                },
                expands: true,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.top,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: textEditingController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  border: OutlineInputBorder(),
                  hintText: widget.hintText,
                ),
              ),
              DecoratedBox(
                decoration: ShapeDecoration(
                  shape: OutlineInputBorder(),
                ),
                child: Markdown(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  data: textEditingController.text,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool validate() => _formFieldKey.currentState.validate();
}
