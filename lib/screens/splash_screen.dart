import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../screens/products_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showDog = true; // Toggle between dog and cat images
  Timer? _imageToggleTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Toggle between dog and cat images every 1.5 seconds
    _imageToggleTimer = Timer.periodic(const Duration(milliseconds: 1500), (_) {
      setState(() {
        _showDog = !_showDog;
      });
    });

    // Simulate loading time and navigate to products screen
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        _navigateToProductsScreen();
      }
    });
  }

  void _navigateToProductsScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => const ProductsScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _imageToggleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primary.withOpacity(0.7),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Container
            Container(
              width: 150,
              height: 150,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child:
                      _showDog
                          ? Image.asset(
                            'assets/images/dog.jpg',
                            key: const ValueKey('dog'),
                            width: 130,
                            height: 130,
                            fit: BoxFit.cover,
                          )
                          : Image.asset(
                            'assets/images/cat.jpg',
                            key: const ValueKey('cat'),
                            width: 130,
                            height: 130,
                            fit: BoxFit.cover,
                          ),
                ),
              ),
            ),

            // App Name
            const Text(
              'Fluffyn',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),

            // Slogan
            const Text(
              'Pamper Your Pets with the Best',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 50),

            // Animated loading indicator
            Column(
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _controller.value * 2 * math.pi,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child:
                              _showDog
                                  ? const Text(
                                    '🐕',
                                    style: TextStyle(fontSize: 24),
                                  )
                                  : const Text(
                                    '🐈',
                                    style: TextStyle(fontSize: 24),
                                  ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
