// ignore_for_file: constant_identifier_names

enum ValueType<T> { INT<int>(), DOUBLE<double>(), BOOL<bool>(), STRING<String>(), LIST<List<dynamic>>(), MAP<Map<String, dynamic>>() }

enum ConfigKey<T> {
  initialConfig(ValueType.MAP, 'initial_config');

  final ValueType<T> valueType;
  final String key;

  const ConfigKey(this.valueType, this.key);
}
