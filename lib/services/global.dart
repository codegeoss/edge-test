class TestValues {
  TestValues({
    required this.urlScheme,
    required this.baseDomain,
  });

  final String urlScheme;
  final String baseDomain;

  String get baseUrl => '$urlScheme://$baseDomain/api/v1';
}

class TestConfig {
  factory TestConfig({required TestValues values}) {
    return _instance ??= TestConfig._internal(values);
  }

  TestConfig._internal(this.values);

  final TestValues values;
  static TestConfig? _instance;

  static TestConfig? get instance => _instance;
}
