class AuthTokenParser {
  static String? extractToken(Map<String, dynamic> payload) {
    if (payload['token'] is String && (payload['token'] as String).isNotEmpty) {
      return payload['token'] as String;
    }

    final data = payload['data'];
    if (data is Map<String, dynamic>) {
      for (final key in ['accessToken', 'token', 'jwt']) {
        final value = data[key];
        if (value is String && value.isNotEmpty) {
          return value;
        }
      }
    }

    return null;
  }
}
