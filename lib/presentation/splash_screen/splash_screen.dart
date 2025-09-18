import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/config/routes_onfig/app_screens.dart';
import 'package:flutter_template/core/constants/app_colors/app_colors.dart';
import 'package:flutter_template/core/util/responsive_util.dart';
import 'package:go_router/go_router.dart';
import '../../application/auth/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay provider modification until after first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _performLogin();
    });
  }

  Future<void> _performLogin() async {
    final authNotifier = ref.read(authNotifierProvider.notifier);
    await authNotifier.login();

    final authState = ref.read(authNotifierProvider);
    if (authState.error == null) {
      // Navigate only if login succeeds
      if (mounted) context.go(AppScreens.home.path);
    }
    // else: show retry button (handled in build)
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Padding(
          padding: ResponsiveHelper.scalePadding(context, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (authState.isLoading) ...[
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(
                  'Loading...',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                  ),
                ),
              ] else if (authState.error != null) ...[
                Center(
                  child: Text(
                    'Error: ${authState.error}',
                    style: const TextStyle(color: AppColors.error),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _performLogin,
                  child: const Text('Retry'),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
