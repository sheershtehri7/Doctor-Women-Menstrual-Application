import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:trustingbrains_assignment/Constants/Colors.dart';
import 'package:trustingbrains_assignment/Screens/homepage.dart';

class Loginbefore extends StatefulWidget {
  bool IsGoogleSignin;
  Loginbefore({super.key, required this.IsGoogleSignin});

  @override
  State<Loginbefore> createState() => _LoginbeforeState();
}

class _LoginbeforeState extends State<Loginbefore> {
  final TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  Future<void> saveUserToFirestore(
      String uid, String phone, String email) async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
    await userDoc.set({
      'phone': '+91$phone',
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> handleAppleSignIn() async {
    String phone = phoneController.text.trim();

    if (phone.isEmpty || phone.length != 10) {
      Fluttertoast.showToast(msg: "Please enter a valid 10-digit phone number");
      return;
    }

    setState(() => isLoading = true);

    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      final email = userCredential.user?.email ?? 'no-email@apple.com';
      final uid = userCredential.user?.uid ?? '';

      await saveUserToFirestore(uid, phone, email);

      Fluttertoast.showToast(msg: "Signed in as $email");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      Fluttertoast.showToast(msg: "Sign-In Failed: $e");
    }

    setState(() => isLoading = false);
  }

  Future<void> handleGoogleSignIn() async {
    String phone = phoneController.text.trim();

    if (phone.isEmpty || phone.length != 10) {
      Fluttertoast.showToast(msg: "Please enter a valid 10-digit phone number");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Create a GoogleSignIn instance
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Force sign out to clear previous account
      await googleSignIn.signOut();

      // Then show account picker again
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        Fluttertoast.showToast(msg: "Google Sign-In cancelled");
        setState(() => isLoading = false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final email = userCredential.user?.email ?? '';
      final uid = userCredential.user?.uid ?? '';

      await saveUserToFirestore(uid, phone, email);

      Fluttertoast.showToast(msg: "Signed in as $email");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      Fluttertoast.showToast(msg: "Sign-In Failed: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 50,
                child: widget.IsGoogleSignin
                    ? Image.asset('assets/google.png')
                    : Image.asset('assets/apple.png')),
            SizedBox(
              height: 60,
            ),
            Text(
              "Enter Phone Number",
              style: GoogleFonts.poppins(
                color: AppColors.secondmainColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "We'll use this to link your account.",
              style: GoogleFonts.montserrat(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              style: GoogleFonts.poppins(),
              decoration: InputDecoration(
                hintText: "Enter phone number",
                hintStyle: GoogleFonts.montserrat(),
                prefixIcon: const Icon(
                  Icons.phone,
                  color: AppColors.secondmainColor,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 30),
            isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.login, color: Colors.white),
                      label: Text(
                        widget.IsGoogleSignin
                            ? "Sign in with Google"
                            : "Sign in with Apple ID",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondmainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: widget.IsGoogleSignin
                          ? handleGoogleSignIn
                          : handleAppleSignIn,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
