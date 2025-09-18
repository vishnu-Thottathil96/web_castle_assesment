import 'package:flutter/material.dart';
import 'package:flutter_template/core/config/routes_onfig/app_screens.dart';
import 'package:flutter_template/core/constants/app_colors/app_colors.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait 3 seconds and navigate to HomePage
    Timer(const Duration(seconds: 3), () {
      context.go(AppScreens.home.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: SizedBox(width: double.infinity, child: Text('splash')),
      ),
    );
  }
}
