import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/infrastructure/services/api_services/auth_service.dart';
import 'auth_notifier.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = AuthService();
  return AuthNotifier(authService: authService);
});
