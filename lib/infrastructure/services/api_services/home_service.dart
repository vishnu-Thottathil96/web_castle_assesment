import 'dart:convert';
import 'dart:developer';
import 'package:flutter_template/core/config/api_config/api_config.dart';
import 'package:flutter_template/core/config/api_config/api_endpoints.dart';
import 'package:flutter_template/domain/models/home_response_model.dart';
import 'package:flutter_template/domain/failures/api_failures.dart';
import 'package:flutter_template/infrastructure/services/secure_storage_services/secure_storage_service.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class HomeService {
  static const String homeUrl = '${ApiConfig.baseUrl}${ApiEndpoints.home}';
  final SecureStorageService _secureStorage = SecureStorageService();

  Future<Either<ApiFailures, HomeResponseModel>> fetchHomeData() async {
    try {
      // Get token from secure storage
      final token = await _secureStorage.getToken();
      if (token == null || token.isEmpty) {
        return left(
            ApiFailures.clientFailure(errorMessage: 'No access token found'));
      }
      log(token);
      final response = await http.get(
        Uri.parse(homeUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final homeResponse = HomeResponseModel.fromJson(json);
        return right(homeResponse);
      } else {
        return left(ApiFailures.clientFailure(
            errorMessage:
                'Home API failed with status ${response.statusCode}'));
      }
    } catch (e) {
      log('Home API error: $e');
      return left(ApiFailures.clientFailure(errorMessage: e.toString()));
    }
  }
}
