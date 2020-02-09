class ContentsQueryItem {
  ContentsQueryItem({String uid, String keyword}) {
    setUId(uid);
    setSearchKeyword(keyword);
  }

  final Map<String, dynamic> _queryMap = Map();

  Map<String, dynamic> get queryMap =>
      _queryMap..removeWhere((k, v) => v == null);

  String get queryStr {
    Map<String, dynamic> map = queryMap;
    if (map.isEmpty) return '';
    String queryStr = '';
    map.forEach((k, v) {
      if (queryStr.isEmpty) {
        queryStr += '?';
      } else {
        queryStr += '&';
      }
      queryStr += '$k=${v.toString()}';
    });
    return queryStr;
  }

  void clear() {
    _queryMap.clear();
  }

  void setUId(String uid) {
    _queryMap['uid'] = uid;
  }

  String get uid => _queryMap['uid'];

  void setSearchKeyword(String keyword) {
    _queryMap['search'] = keyword;
  }
}
