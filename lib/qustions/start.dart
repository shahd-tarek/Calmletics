import 'package:flutter/material.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/qustions/avatar.dart';
import 'package:sports_mind/widgets/custom_button.dart';

class Start extends StatelessWidget {
  const Start({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Excited to begin? Let's start with a few quick questions!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textcolor,
              ), 
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              "Your answers will help us create a better experience",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.green.withOpacity(0.2),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: Image.asset("assets/images/Meditation.png"),
                ),
              ],
            ),
            const SizedBox(height: 50),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  text: "Let’s start ",
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AvatarSelectionPage()));
                  },
                )),
          ],
        ),
      ),
    );
  }
}
