import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_template/core/config/api_config/api_config.dart';
import 'package:flutter_template/core/config/api_config/api_endpoints.dart';
import 'package:flutter_template/core/constants/app_strings/api_exception_strings.dart';
import 'package:flutter_template/domain/failures/api_failures.dart';
import 'package:flutter_template/domain/models/auth_models/auth_request.dart';
import 'package:flutter_template/domain/models/auth_models/auth_response.dart';
import 'package:flutter_template/infrastructure/services/api_services/api_response_handler.dart';
import 'package:flutter_template/infrastructure/services/secure_storage_services/secure_storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

class AuthService {
  static const String loginUrl = '${ApiConfig.baseUrl}${ApiEndpoints.login}';
  final SecureStorageService _secureStorage = SecureStorageService();

  /// Call login API
  Future<Either<ApiFailures, AuthResponse>> login(AuthRequest request) async {
    try {
      final response = await http
          .post(
            Uri.parse(loginUrl),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(request.toJson()),
          )
          .timeout(const Duration(seconds: 30));
      final result = await apiResponseHandler<AuthResponse>(
        response,
        (json) {
          log(response.body);
          return AuthResponse.fromJson(json);
        },
      );

      // Save token if the response was successful
      result.fold(
        (failure) => null,
        (authResponse) async {
          final token = authResponse.data.accessToken;
          if (token.isNotEmpty) {
            await _secureStorage.saveToken(token);
          }
        },
      );

      return result;

      // return await apiResponseHandler<AuthResponse>(
      //   response,
      //   (json) {
      //     log(response.body);

      //     return AuthResponse.fromJson(json);
      //   },
      // );
    } on http.ClientException catch (e) {
      log('ClientException login: $e');
      return left(ApiFailures.clientFailure(
          errorMessage: ApiExceptionStrings.clientException));
    } on TimeoutException catch (e) {
      log('TimeoutException login: $e');
      return left(ApiFailures.clientFailure(
          errorMessage: ApiExceptionStrings.timeOutException));
    } catch (e) {
      log('Unexpected error login: $e');
      return left(ApiFailures.clientFailure(
          errorMessage: ApiExceptionStrings.unknownException));
    }
  }
}
