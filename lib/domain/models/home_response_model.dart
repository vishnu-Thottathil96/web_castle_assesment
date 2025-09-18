import 'package:flutter_template/domain/models/home_field_model.dart';

class HomeResponseModel {
  final List<HomeFieldModel> homeFields;

  HomeResponseModel({required this.homeFields});

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) {
    return HomeResponseModel(
      homeFields: (json['data']['home_fields'] as List)
          .map((e) => HomeFieldModel.fromJson(e))
          .toList(),
    );
  }
}
