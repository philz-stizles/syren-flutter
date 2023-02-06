import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syren/models/models.dart';
import 'package:syren/services/user_service.dart';

class AuthProvider extends GetConnect {
  final authBox = GetStorage();

  // Services.
  var userService = Get.put(UserService());

  // Observables.
  final Rxn<UserModel> _userModel = Rxn<UserModel>();
  final Rxn<String?> _token = Rxn<String>();
  final Rxn<DateTime?> _expiryDate = Rxn<DateTime>();
  final Rxn<String?> _userId = Rxn<String>();
  final Rxn<Timer?> _authExpiryTimer = Rxn<Timer>();

  // Data.
  final firebaseBaseUrl = dotenv.get('FIREBASE_BASE_URL');
  final firebaseAPIKey = dotenv.get('FIREBASE_API_KEY');

  UserModel? get user => _userModel.value;

  @override
  void onInit() {
    httpClient.baseUrl = firebaseBaseUrl;
  }

  String? get token {
    if (_expiryDate.value != null &&
        _token.value != null &&
        _expiryDate.value != null &&
        _expiryDate.value!.isAfter(DateTime.now())) {
      return _token.value;
    }

    return null;
  }

  bool get isAuthenticated {
    return token != null;
  }

  String? get userId {
    return _userId.value;
  }

  Future<void> signUp(
      {required UserModel userModel, required String password}) async {
    try {
      // Signup.
      final response = await post('signUp?key=$firebaseAPIKey', {
        'email': userModel.email,
        'password': password,
        'returnSecureToken': true
      });

      final responseBody = response.body as Map<String, dynamic>;
      if (responseBody['error'] != null &&
          responseBody['error']['errors'].length > 0) {
        var error = responseBody['error']['message'];
        var errorMessage = 'Authentication failed';

        if (error.toString().contains('EMAIL_EXISTS')) {
          errorMessage = 'This email address is already in use';
        } else if (error.toString().contains('INVALID_EMAIL')) {
          errorMessage = 'This is not a valid email address';
        } else if (error.toString().contains('WEAK_PASSWORD')) {
          errorMessage = 'This password is too weak';
        } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
          errorMessage = 'User with email address does not exist';
        } else if (error.toString().contains('INVALID_PASSWORD')) {
          errorMessage = 'Invalid password';
        }
        throw HttpException(errorMessage);
      }

      // Create User.
      userModel.id = responseBody['localId'];
      var success = await userService.create(userModel);
      if (success) {}
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }

      rethrow;
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      final response = await post('signInWithPassword?key=$firebaseAPIKey',
          {'email': email, 'password': password, 'returnSecureToken': true});

      final responseBody = json.decode(response.body);
      if (responseBody['error'] != null) {
        throw HttpException(responseBody['error']['message']);
      }

      _token.value = responseBody['idToken'];
      _userId.value = responseBody['localId'];
      _expiryDate.value = DateTime.now()
          .add(Duration(seconds: int.parse(responseBody['expiresIn'])));
      _setAutoLogoutTimer();

      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.value!.toIso8601String(),
      });

      await authBox.write('userData', userData);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }

      rethrow;
    }
  }

  Future<void> logout() async {
    _token.value = null;
    _userId.value = null;
    _expiryDate.value = null;

    if (_authExpiryTimer.value != null) {
      _authExpiryTimer.value!.cancel();
      _authExpiryTimer.value = null;
    }

    await authBox.remove('userData');
  }

  void _setAutoLogoutTimer() async {
    if (_authExpiryTimer.value != null) {
      _authExpiryTimer.value!.cancel();
    }

    final secondsToExpiry =
        _expiryDate.value!.difference(DateTime.now()).inSeconds;
    _authExpiryTimer.value = Timer(Duration(seconds: secondsToExpiry), logout);
  }

  Future<bool> tryAutoLogin() async {
    if (authBox.read('userData') == null) {
      return false;
    }

    final decodedUserData =
        json.decode(authBox.read('userData')) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(decodedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token.value = decodedUserData['token'];
    _userId.value = decodedUserData['userId'];
    _expiryDate.value = expiryDate;
    _setAutoLogoutTimer();

    return true;
  }
}
