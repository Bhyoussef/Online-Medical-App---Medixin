import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/app_logo.dart';
import 'onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isBlue = false;

  @override
  void initState() {
    super.initState();
    _playSplash();
  }

  Future<void> _playSplash() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() => _isBlue = true);

    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const OnboardingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isBlue ? AppColors.primaryBlue : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            AppLogo(isBlueBackground: _isBlue),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 36),
              child: SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _isBlue ? Colors.white : AppColors.primaryBlue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
