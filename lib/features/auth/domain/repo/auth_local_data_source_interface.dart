abstract interface class AuthLocalDataSourceInterface {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
}
