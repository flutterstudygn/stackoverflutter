import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:stackoverflutter/src/model/contents/contents_item.dart';

class MinimizedContentsList extends StatelessWidget {
  final Widget Function(ContentsItem) _itemBuilder;
  final String _collectionName;
  final Widget separator;
  final int maxCount;

  MinimizedContentsList(
    this._itemBuilder,
    this._collectionName, {
    this.separator = const Divider(
      height: 0,
      thickness: 1,
    ),
    this.maxCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    final Stream<List<ContentsItem>> contentStream = firestore()
        .collection(_collectionName)
        .orderBy('createTime', 'desc')
        .limit(maxCount)
        .onSnapshot
        .map(
          (snapshots) => List.generate(
            snapshots.size,
            (i) => ContentsItem.fromJson(snapshots.docs[i].data())
              ..id = snapshots.docs[i].id,
          ),
        );

    return StreamBuilder<List<ContentsItem>>(
      stream: contentStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Error',
            style: Theme.of(context).textTheme.subhead,
          );
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                'No Result',
                style: Theme.of(context).textTheme.display1,
              ),
            );
          }

          List<ContentsItem> items = snapshot.data;

          List<Widget> children = List.generate(
            items.length,
            (i) => _itemBuilder(items[i]),
          );

          for (int i = 1; i < children.length; i += 2) {
            children.insert(i, separator);
          }

          return Column(children: children);
        }

        return Padding(
          padding: EdgeInsets.all(18),
          child: LinearProgressIndicator(),
        );
      },
    );
  }
}
