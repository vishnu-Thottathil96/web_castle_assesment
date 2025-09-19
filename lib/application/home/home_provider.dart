import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/infrastructure/services/api_services/home_service.dart';
import 'home_notifier.dart';

final homeNotifierProvider =
    StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(homeService: HomeService());
});
