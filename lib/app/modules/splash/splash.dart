import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home/view.dart';  // Make sure the Home screen is properly imported

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation setup
    _controller = AnimationController(
      duration: Duration(milliseconds: 1400), // Duration of the animation
      vsync: this,
    );

    _fadeAnimation = Tween(begin: 0.0, end: 1.3).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();

    // Navigate after 1.7 seconds (after animation finishes)
    Future.delayed(Duration(milliseconds: 1700), () {
      Get.offAll(() => Home()); // Navigate to Home page
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // background color of splash screen
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation, // Apply fade animation to the text
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TO DO APP',
                style: GoogleFonts.lato(
                  wordSpacing: 1.2,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // text color
                ),
              ),
            ],
          ),
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
