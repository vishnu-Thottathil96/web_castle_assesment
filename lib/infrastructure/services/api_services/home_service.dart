import 'dart:convert';
import 'dart:developer';
import 'package:flutter_template/core/config/api_config/api_config.dart';
import 'package:flutter_template/core/config/api_config/api_endpoints.dart';
import 'package:flutter_template/domain/models/home_response_model.dart';
import 'package:flutter_template/domain/failures/api_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class HomeService {
  static const String homeUrl = '${ApiConfig.baseUrl}${ApiEndpoints.home}';

  Future<Either<ApiFailures, HomeResponseModel>> fetchHomeData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://s419.previewbay.com/fragrance-b2b-backend/api/v1/home'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer 3308|nKPMh91oEF1iomwWHzemsYBrPzKbgN93WtMDDvrf',
        },
      );

      if (response.statusCode == 200) {
        log(response.body);
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
