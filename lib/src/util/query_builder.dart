/// 전체 경로중 query부를 관리하는 클래스.
class QueryBuilder {
  /// 문자열 query를 key, value 쌍으로 변환하여 Map으로 반환.
  static Map<String, String> decode(String query) {
    Map<String, String> parsed = {};

    List<String> arguments = query.split('&');

    arguments.forEach((argument) {
      List<String> pair = argument.split('=');
      parsed[pair.first] = pair.last;
    });

    return parsed;
  }

  /// Map 형태의 Query 객체를 문자열으로 변환.
  static String encode(Map<String, String> object) {
    String raw = object.toString();
    return '?' +
        raw
            .substring(1, raw.length - 1)
            .replaceAll(' ', '')
            .replaceAll(',', '&')
            .replaceAll(':', '=');
  }
}
