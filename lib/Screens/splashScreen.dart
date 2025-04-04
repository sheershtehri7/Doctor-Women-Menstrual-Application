import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trustingbrains_assignment/Screens/LoginPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation setup
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..forward();
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // Navigate to the next screen after 4 seconds
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 248, 240, 227), // Teal
              Color.fromARGB(255, 248, 240, 226), // Light Teal
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Image.asset(
                      'assets/logo.png',
                      // Adjust width as needed
                      // fit: BoxFit.cover,
                    ),
                    Container(
                      height: 20,
                      child: Image.asset(
                        'assets/tg.png',
                        // Adjust width as needed
                        // fit: BoxFit.cover,
                      ),
                    ),

                    // SizedBox(height: 10),
                    // RichText(
                    //   text: TextSpan(
                    //     children: [
                    //       TextSpan(
                    //         text: 'Pucho ',
                    //         style: GoogleFonts.montserrat(
                    //           fontSize: 18,
                    //           fontWeight: FontWeight.bold,
                    //           color: Color(0xFF012A4A), // Dark Blue
                    //         ),
                    //       ),
                    //       TextSpan(
                    //         text: 'Xpert Se',
                    //         style: GoogleFonts.montserrat(
                    //           fontSize: 18,
                    //           fontWeight: FontWeight.bold,
                    //           color: Color(0xFF18A999), // Teal from the logo
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
