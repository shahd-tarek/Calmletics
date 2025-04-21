import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/views/onboarding_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoPositionAnimation;
  late Animation<double> _nameOpacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Logo moves to the left from center
    _logoPositionAnimation = Tween<double>(begin: 0.0, end: -100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // App name fades in
    _nameOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0, curve: Curves.easeIn)),
    );

    _controller.forward();

    // Navigate to the next screen after animation completes
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor, 
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return SizedBox(
              width: 700,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Logo starts in the center and moves left
                  Transform.translate(
                    offset: Offset(_logoPositionAnimation.value, 0),
                    child: Image.asset(
                      'assets/images/logo.png', 
                      width: 80,
                      height: 80,
                    ),
                  ),
                   Opacity(
                  opacity: _nameOpacityAnimation.value,
                  child: const Padding(
                   padding: EdgeInsets.only(left: 70),
                    child: Text(
                      "Calmletics",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor, 
                      ),
                    ),
                 ),
                ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}



