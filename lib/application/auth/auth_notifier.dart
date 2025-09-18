import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_template/infrastructure/services/api_services/auth_service.dart';
import '../../domain/failures/api_failures.dart';
import '../../domain/models/auth_models/auth_request.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final String? accessToken;

  AuthState({this.isLoading = false, this.error, this.accessToken});

  AuthState copyWith({bool? isLoading, String? error, String? accessToken}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService authService;

  AuthNotifier({required this.authService}) : super(AuthState());

  Future<void> login() async {
    state = state.copyWith(isLoading: true, error: null);

    final request = AuthRequest(deviceToken: 'test_token', deviceType: 1);

    final Either<ApiFailures, dynamic> result =
        await authService.login(request);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.errorMessage);
      },
      (response) {
        state = state.copyWith(
            isLoading: false, accessToken: response.data.accessToken);
      },
    );
  }
}
