import 'dart:convert';

const int _kJwtParts = 3;
const int _kPayloadPartIndex = 1;

abstract final class JwtDecoder {
  static DateTime _tokenExpToDate(int exp) {
    return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
  }

  static Map<String, dynamic> _decode(String token) {
    final List<String> tokenSplitted = token.split('.');
    if (tokenSplitted.length != _kJwtParts) {
      throw const FormatException('Invalid token');
    }
    try {
      final String payloadBase64 = tokenSplitted[_kPayloadPartIndex];
      final String payloadNormalized = base64.normalize(payloadBase64);
      final String payloadString = utf8.decode(base64.decode(payloadNormalized));
      return jsonDecode(payloadString);
    } catch (e) {
      throw const FormatException('Invalid payload');
    }
  }

  static bool isExpired(String token) {
    final Map<String, dynamic> decodedToken = _decode(token);
    final int exp = decodedToken['exp'];

    return DateTime.now().isAfter(_tokenExpToDate(exp));
  }
}
