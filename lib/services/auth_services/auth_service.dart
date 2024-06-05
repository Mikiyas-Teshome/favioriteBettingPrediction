// auth_service.dart
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:faviorite_app/constants/url_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  AuthService(this._dio, this._secureStorage);

  Future<void> storeUserData(Map<String, dynamic> userData) async {
    await _secureStorage.write(key: 'userData', value: json.encode(userData));
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final userDataString = await _secureStorage.read(key: 'userData');
    if (userDataString != null) {
      return json.decode(userDataString);
    } else {
      return null;
    }
  }

  Future<void> deleteUserData() async {
    await _secureStorage.delete(key: 'userData');
  }

  Future<void> storeToken(String token) async {
    await _secureStorage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: 'token');
  }

  Future<void> login(String username, String password) async {
    try {
      final response = await _dio.post(
        localLoginUrl,
        data: {
          'email': username,
          'password': password,
        },
      );

      final token = response.data['token'];
      final userData = response.data['user'];

      await storeToken(token);
      await storeUserData(userData);
    } on DioException catch (e) {
      print("apiError: " + e.message.toString());
      throw ApiException.fromDioError(e);
    } catch (e) {
      print("apiError: " + e.toString());
      throw ApiException('Unexpected error occurred');
    }
  }

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        localSignUpUrl,
        data: {
          'name': '$firstName $lastName',
          'email': email,
          'password': password,
        },
      );
      // Handle successful sign-up response
    } on DioException catch (e) {
      // Handle Dio errors (e.g., network issues)
      throw ApiException.fromDioError(e);
    } catch (e) {
      // Handle other errors
      throw ApiException('Unexpected error occurred');
    }
  }

  Future<void> emailResend({
    required String email,
  }) async {
    try {
      final response = await _dio.post(
        resendEmailUrl,
        data: {
          'email': email,
        },
      );
      // Handle successful sign-up response
    } on DioException catch (e) {
      // Handle Dio errors (e.g., network issues)
      throw ApiException.fromDioError(e);
    } catch (e) {
      // Handle other errors
      throw ApiException('Unexpected error occurred');
    }
  }

  Future<void> otpVerify({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _dio.post(
        verifyOtplUrl,
        data: {
          'email': email,
          'otp': otp,
        },
      );
      // Handle successful sign-up response
    } on DioException catch (e) {
      // Handle Dio errors (e.g., network issues)
      throw ApiException.fromDioError(e);
    } catch (e) {
      // Handle other errors
      throw ApiException('Unexpected error occurred');
    }
  }

  Future<void> resetPassOtpVerify({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _dio.post(
        verifyResetPassOtpUrl,
        data: {
          'email': email,
          'otp': otp,
        },
      );
      final token = response.data['data'];

      await storeToken(token);
      // Handle successful sign-up response
    } on DioException catch (e) {
      // Handle Dio errors (e.g., network issues)
      throw ApiException.fromDioError(e);
    } catch (e) {
      // Handle other errors
      throw ApiException('Unexpected error occurred');
    }
  }

  Future<void> resetPassword({
    required String email,
    required String password,
    required String tocken,
  }) async {
    try {
      final response = await _dio.post(
        resetPassUrl,
        data: {
          'email': email,
          'password': password,
          'token': tocken,
        },
      );
      // print("this is the ress: " + response!.toString());
      // Handle successful sign-up response
    } on DioException catch (e) {
      // Handle Dio errors (e.g., network issues)
      throw ApiException.fromDioError(e);
    } catch (e) {
      // Handle other errors
      throw ApiException('Unexpected error occurred');
    }
  }

  Future<void> verifyGoogleSignIn({
    required String idToken,
  }) async {
    try {
      final response = await _dio.post(
        signInWithGoogleUrl,
        data: {
          'idToken': idToken,
        },
      );
      final token = response.data['token'];
      final userData = response.data['user'];

      await storeToken(token);
      await storeUserData(userData);
      // Handle successful sign-up response
    } on DioException catch (e) {
      // Handle Dio errors (e.g., network issues)
      throw ApiException.fromDioError(e);
    } catch (e) {
      // Handle other errors
      throw ApiException('Unexpected error occurred');
    }
  }

  Future<void> passResetEmailSend({
    required String email,
  }) async {
    try {
      final response = await _dio.post(
        forgetPassUrl,
        data: {
          'email': email,
        },
      );

      // Handle successful sign-up response
    } on DioException catch (e) {
      // Handle Dio errors (e.g., network issues)
      throw ApiException.fromDioError(e);
    } catch (e) {
      // Handle other errors

      throw ApiException('Unexpected error occurred' + e.toString());
    }
  }
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  factory ApiException.fromDioError(DioException e) {
    if (e.response != null) {
      final responseData = e.response!.data;
      final errorMessage = responseData['message'] ?? 'An error occurred';
      print("this is the errorrr: " + errorMessage);
      return ApiException(errorMessage.toString());
    } else {
      print("this is the exception");

      return ApiException('Unexpected error occurred');
    }
  }
}
