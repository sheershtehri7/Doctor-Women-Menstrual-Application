import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trustingbrains_assignment/Constants/BlackContainer.dart';
import 'package:trustingbrains_assignment/Constants/Colors.dart';
import 'package:trustingbrains_assignment/Screens/OTPVerification.dart';
import 'package:trustingbrains_assignment/Screens/loginbefore.dart';
import 'package:trustingbrains_assignment/Services/LoginService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  void sendOTP() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    String phoneNumber = "+91${phoneController.text.trim()}";

    AuthService().sendOTP(
      phoneNumber: phoneNumber,
      onCodeSent: (String verificationId) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OTPVerificationScreen(
                    verificationId: verificationId, phone: phoneNumber)));
      },
      context: context,
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  Image.asset('assets/logo1.png', height: 150),
                  //  const SizedBox(height: 20),
                  Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromARGB(255, 234, 128, 117),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Please enter your details and get started.',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          spreadRadius: 0,
                          color: AppColors.mainColor,
                        )
                      ],
                    ),
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.call,
                          color: const Color.fromARGB(255, 234, 128, 117),
                        ),
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Phone number is required";
                        } else if (value.length != 10) {
                          return "Enter a valid 10-digit phone number";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const TermsCheckbox(),
                  const SizedBox(height: 20),
                  isLoading
                      ? CircularProgressIndicator()
                      : _buildButton(
                          'Get OTP',
                          const Color.fromARGB(255, 234, 128, 117),
                          Colors.white,
                          sendOTP),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade400,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "or",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade400,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Loginbefore(
                                    IsGoogleSignin: true,
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 3,
                                blurRadius: 2,
                                color: const Color.fromARGB(255, 240, 240, 240))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 1,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              padding: EdgeInsets.all(7),
                              child: Image.asset('assets/google.png')),
                          SizedBox(
                            width: 6,
                          ),
                          Center(
                              child: Text(
                            'Continue with Google',
                            style: GoogleFonts.montserrat(
                                color: const Color.fromARGB(255, 95, 95, 95),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Loginbefore(
                                    IsGoogleSignin: false,
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 3,
                                blurRadius: 2,
                                color: const Color.fromARGB(255, 240, 240, 240))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 1,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              padding: EdgeInsets.all(7),
                              child: Image.asset('assets/apple.png')),
                          SizedBox(
                            width: 6,
                          ),
                          Center(
                              child: Text(
                            'Continue with Apple ID',
                            style: GoogleFonts.montserrat(
                                color: const Color.fromARGB(255, 95, 95, 95),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      String text, Color bgColor, Color textColor, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: bgColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
    );
  }
}

class TermsCheckbox extends StatefulWidget {
  const TermsCheckbox({super.key});

  @override
  _TermsCheckboxState createState() => _TermsCheckboxState();
}

class _TermsCheckboxState extends State<TermsCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16, color: Colors.black),
              children: [
                const TextSpan(text: "I agree with "),
                TextSpan(
                  text: "Terms",
                  style: TextStyle(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
                const TextSpan(text: " and "),
                TextSpan(
                  text: "Privacy",
                  style: TextStyle(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
