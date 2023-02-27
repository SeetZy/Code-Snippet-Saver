/*
  * Utility imports
 */
import 'package:dio/dio.dart';

class AuthService {
  Dio dio = Dio();

  // Signs in the user via http request to the backend
  signIn(email, password) async {
    try {
      return await dio.post(
        'https://shielded-river-62504.herokuapp.com/signin',
        data: {"email": email, "password": password},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
    } on DioError {
      rethrow;
    }
  }

  // Signs up the user via http request to the backend
  signUp(email, password) async {
    try {
      return await dio.post(
        'https://shielded-river-62504.herokuapp.com/signup',
        data: {"email": email, "password": password},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
    } on DioError {
      rethrow;
    }
  }
}
