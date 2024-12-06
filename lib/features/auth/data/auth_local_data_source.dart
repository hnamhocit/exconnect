import 'package:flutter_learning/features/auth/data/constants.dart';
import 'package:flutter_learning/features/auth/dtos/tokens_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  AuthLocalDataSource({required this.sf});

  final SharedPreferences sf;

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await sf.setString(AuthDataConstants.accessToken, accessToken);
    await sf.setString(AuthDataConstants.refreshToken, refreshToken);
  }

  TokensDto? getTokens() {
    final accessToken = sf.getString(AuthDataConstants.accessToken);
    final refreshToken = sf.getString(AuthDataConstants.refreshToken);

    if (accessToken != null && refreshToken != null) {
      return TokensDto(accessToken: accessToken, refreshToken: refreshToken);
    }

    return null;
  }

  Future<void> deleteTokens() async {
    await sf.remove(AuthDataConstants.accessToken);
    await sf.remove(AuthDataConstants.refreshToken);
  }
}
