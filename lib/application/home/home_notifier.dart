import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/domain/models/home_field_model.dart';
import 'package:flutter_template/infrastructure/services/api_services/home_service.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  final HomeService homeService;

  HomeNotifier({required this.homeService}) : super(HomeState());

  Future<void> fetchHome() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await homeService.fetchHomeData();

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.errorMessage);
      },
      (response) {
        state =
            state.copyWith(isLoading: false, homeFields: response.homeFields);
      },
    );
  }
}

class HomeState {
  final bool isLoading;
  final String? error;
  final List<HomeFieldModel> homeFields;

  HomeState({
    this.isLoading = false,
    this.error,
    this.homeFields = const [],
  });

  HomeState copyWith({
    bool? isLoading,
    String? error,
    List<HomeFieldModel>? homeFields,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      homeFields: homeFields ?? this.homeFields,
    );
  }
}
