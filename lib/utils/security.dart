import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Security {
  static final key = Key.fromUtf8(dotenv.get('ENCRYPTION_KEY'));

  static final iv = IV.fromLength(
      dotenv.get('IV_LENGTH') is int ? dotenv.get('IV_LENGTH') as int : 16);
  static final encrypter = Encrypter(AES(key));

  static String encrypt(String value) {
    return encrypter.encrypt(value, iv: iv).base64;
  }

  static String decrypt(String? value) {
    return encrypter.decrypt64(value!, iv: iv);
  }
}
