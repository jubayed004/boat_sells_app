import 'package:boat_sells_app/core/custom_assets/assets.gen.dart';
import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _initRouting();
  }

  Future<void> _initRouting() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    if (mounted) {
      await _handleNavigationFlow();
    }
  }

  Future<void> _handleNavigationFlow() async {
    // Since backend integration is not done yet, directly route to loginScreen
    // TODO: Add token validation when backend is ready
    AppRouter.route.goNamed(RoutePath.loginScreen);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo image
                  Assets.images.appLogo.image(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
