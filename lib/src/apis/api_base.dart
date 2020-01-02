import 'package:http/http.dart' as http;

class BaseApi {
  final String _baseUrl;

  BaseApi({String baseUrl})
      : _baseUrl = baseUrl ??
            'https://us-central1-stackoverflutter-78df8.cloudfunctions.net/';

  Future<dynamic> get(String url) {
    return http
        .get('$_baseUrl/$url')
        .then((response) => response.body)
        .catchError((e) => e);
  }
}
