import 'dart:convert';

import 'package:crypto/crypto.dart';

abstract final class PasswordEncryption {
  static const String _key =
      'CQM1UyMAKUZ1GDF4IhpKcDIGQQUBAxtyMypAHXwwBwgoIQMBMR9kLx09C1omMzUvfjobfCkgQ3kwEUIiDCw1WwcVCwFWISIrNGsYNzwSeCQOERdNAgUbO3MVDzYiISoINwBCFwMTJUQ3KhsndTALLygcPiI+DwU2CVsfXCgXFy9+GHx4LyEYAiAsUiQLEDlEBzMLPXshGGMvMTpyMh9GPgwDFww5B0hUfQ5wZys2FHc4P0IbAAATQjgFSCd7UDkEKhkyeSkfdAIKLh9DLBAIFH0KcAs1P0t3MXQBfA89IlEHLj0LahsDPiZqSzo4dGAWDhBiAyMQKQdhIyU0LzYELg==';

  static String encrpyt(String password) {
    final String hashKey = _XOR.runMultiple(_key, 10);
    final List<int> encodedHashKey = utf8.encode(hashKey);

    final Hmac hmac = Hmac(sha512, encodedHashKey);

    final List<int> encodedPassword = utf8.encode(password);
    final Digest digest = hmac.convert(encodedPassword);

    return digest.bytes.map((int byte) {
      return byte.toRadixString(16).padLeft(2, '0');
    }).join();
  }
}

abstract final class _XOR {
  static const String _key = 'MiR5aDxm0bILeXs@yG1N';

  static String runMultiple(String s, int count) {
    for (int i = 0; i < count; i++) {
      // ignore: parameter_assignments
      s = _xorWithKey(s, _key);
    }
    return s;
  }

  static String _xorWithKey(String s, String key) {
    final List<int> list = base64.decode(s);
    final List<int> encodedKey = utf8.encode(key);

    for (int i = 0; i < list.length; i++) {
      list[i] ^= encodedKey[i % encodedKey.length];
    }
    return utf8.decode(list);
  }
}
