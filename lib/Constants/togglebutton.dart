import 'package:flutter/material.dart';

class ExpertModeToggle extends StatefulWidget {
  @override
  _ExpertModeToggleState createState() => _ExpertModeToggleState();
}

class _ExpertModeToggleState extends State<ExpertModeToggle> {
  bool isExpertModeOn = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpertModeOn = !isExpertModeOn;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isExpertModeOn ? Colors.green : Colors.red,
        ),
        child: Stack(
          children: [
            Align(
              alignment:
                  isExpertModeOn ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                isExpertModeOn ? "Expert Mode On" : "Expert Mode Off",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
