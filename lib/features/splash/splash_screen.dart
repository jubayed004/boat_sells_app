import 'dart:math';

import 'package:boat_sells_app/core/custom_assets/assets.gen.dart';
import 'package:boat_sells_app/core/di/injection.dart';
import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/core/service/datasource/local/local_service.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Wave animation
  late AnimationController _waveController;
  // Boat horizontal drift + bob
  late AnimationController _boatController;
  late Animation<double> _boatX;
  late Animation<double> _boatY;
  // Logo fade-in
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  // Tagline slide-up
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  final LocalService localService = sl();
  @override
  void initState() {
    super.initState();

    // Continuous wave
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // Boat: gentle bob (Y) + slight drift (X)
    _boatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _boatY = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(parent: _boatController, curve: Curves.easeInOut),
    );
    _boatX = Tween<double>(begin: -4, end: 4).animate(
      CurvedAnimation(parent: _boatController, curve: Curves.easeInOut),
    );

    // Fade in logo
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // Slide up tagline
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.6),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _slideController.forward();
    });

    _initRouting();
  }

  Future<void> checkLoginStatus() async {
    final token = await localService.getToken();
    if (token.isNotEmpty && !JwtDecoder.isExpired(token)) {
      AppRouter.route.goNamed(RoutePath.navigationPage);
    } else {
      AppRouter.route.goNamed(RoutePath.loginScreen);
    }
  }

  Future<void> _initRouting() async {
    await Future.delayed(const Duration(milliseconds: 3500));
    if (mounted) {
      await checkLoginStatus();
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    _boatController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // ── Sky gradient background ──────────────────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0A1628), // deep navy
                  Color(0xFF1A3A5C), // mid ocean blue
                  Color(0xFF1E6091), // horizon blue
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
          ),

          // ── Stars (static dots in sky) ───────────────────────────
          ..._buildStars(size),

          // ── Animated ocean waves ─────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _waveController,
              builder: (context, _) {
                return CustomPaint(
                  size: Size(size.width, size.height * 0.45),
                  painter: _OceanWavePainter(_waveController.value),
                );
              },
            ),
          ),

          // ── Boat + logo area ─────────────────────────────────────
          Positioned(
            bottom: size.height * 0.30,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _boatController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_boatX.value, _boatY.value),
                  child: Transform.rotate(
                    angle: _boatX.value * 0.006, // subtle tilt
                    child: child,
                  ),
                );
              },
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // App logo / boat icon
                    Assets.images.appLogo.image(
                      width: 130,
                      height: 130,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── App name & tagline ───────────────────────────────────
          Positioned(
            bottom: size.height * 0.10,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    const Text(
                      'BoatSells',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 2.5,
                        shadows: [
                          Shadow(
                            color: Color(0x661E6091),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Find • Buy • Sell Boats',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withAlpha(180),
                        letterSpacing: 1.8,
                      ),
                    ),
                    const SizedBox(height: 28),
                    // Animated dots loader
                    _WaveDotsLoader(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStars(Size size) {
    final rng = Random(42);
    return List.generate(40, (i) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height * 0.55;
      final r = rng.nextDouble() * 1.5 + 0.5;
      return Positioned(
        left: x,
        top: y,
        child: Container(
          width: r * 2,
          height: r * 2,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha((rng.nextDouble() * 155 + 100).toInt()),
            shape: BoxShape.circle,
          ),
        ),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Ocean Wave Painter
// ─────────────────────────────────────────────────────────────────────────────
class _OceanWavePainter extends CustomPainter {
  final double progress; // 0.0 → 1.0
  _OceanWavePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    _drawWave(
      canvas,
      size,
      color: const Color(0xCC0D5C8A),
      amplitude: 18,
      frequency: 1.4,
      phaseShift: progress * 2 * pi,
      yOffset: 0.18,
    );
    _drawWave(
      canvas,
      size,
      color: const Color(0xDD0A4A75),
      amplitude: 22,
      frequency: 1.1,
      phaseShift: progress * 2 * pi + 1.2,
      yOffset: 0.10,
    );
    _drawWave(
      canvas,
      size,
      color: const Color(0xFF082F50),
      amplitude: 14,
      frequency: 1.7,
      phaseShift: progress * 2 * pi + 2.5,
      yOffset: 0.04,
    );
  }

  void _drawWave(
    Canvas canvas,
    Size size, {
    required Color color,
    required double amplitude,
    required double frequency,
    required double phaseShift,
    required double yOffset,
  }) {
    final paint = Paint()..color = color;
    final path = Path();
    final baseY = size.height * yOffset;

    path.moveTo(0, baseY);
    for (double x = 0; x <= size.width; x++) {
      final y =
          baseY + amplitude * sin((x / size.width * 2 * pi * frequency) + phaseShift);
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_OceanWavePainter old) => old.progress != progress;
}

// ─────────────────────────────────────────────────────────────────────────────
// Animated wave dots loader
// ─────────────────────────────────────────────────────────────────────────────
class _WaveDotsLoader extends StatefulWidget {
  @override
  State<_WaveDotsLoader> createState() => _WaveDotsLoaderState();
}

class _WaveDotsLoaderState extends State<_WaveDotsLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (i) {
            final offset =
                sin((_ctrl.value * 2 * pi) - (i * pi / 3)) * 5;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Transform.translate(
                offset: Offset(0, offset),
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(200),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
