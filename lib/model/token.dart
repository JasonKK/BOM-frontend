import 'package:flutter_riverpod/flutter_riverpod.dart';

class Token {
  Token({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;

  factory Token.fromJson(Map json) {
    return Token(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map toMap() {
    var map = new Map();
    map['accessToken'] = accessToken;
    map['refreshToken'] = refreshToken;

    return map;
  }
}

final tokenStateProvider = StateProvider<String>((ref) {
  return '';
});
