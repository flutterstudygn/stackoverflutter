class QueryBuilder {
  static Map<String, String> decode(String query) {
    Map<String, String> parsed = {};

    List<String> arguments = query.split('&');

    arguments.forEach((argument) {
      List<String> pair = argument.split('=');
      parsed[pair.first] = pair.last;
    });

    return parsed;
  }

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
