/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/db/auth.service.dart';
import 'dart:developer';

class AuthNotifier extends ChangeNotifier {
  static final Authentication _authService = Authentication();

  static Future<String?> register({
    required String email,
    required String password,
  }) async {
    try {
      await _authService.register(
        email: email,
        password: password,
      );
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _authService.login(
        email: email,
        password: password,
      );
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
