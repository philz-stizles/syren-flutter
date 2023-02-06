import 'dart:math';

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

  static String generateRandomPassword() {
    List<String> allalphabets = 'abcdefghijklmnopqrstuvwxyz'.split('');
    List<int> numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    List<String> specialCharacters = ["@", "#", "%", "&", "*"];
    List<String> password = [];
    for (int i = 0; i < 5; i++) {
      password.add(allalphabets[Random().nextInt(allalphabets.length)]);
      password.add(numbers[Random().nextInt(numbers.length)].toString());
      password
          .add(specialCharacters[Random().nextInt(specialCharacters.length)]);
    }
    return password.join();
  }
}
