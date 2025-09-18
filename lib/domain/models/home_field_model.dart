class HomeFieldModel {
  final String type;
  final Map<String, dynamic> raw;

  HomeFieldModel({required this.type, required this.raw});

  factory HomeFieldModel.fromJson(Map<String, dynamic> json) {
    return HomeFieldModel(
      type: json['type'],
      raw: json,
    );
  }
}
