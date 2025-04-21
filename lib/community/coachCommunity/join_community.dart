import 'package:flutter/material.dart';
import 'package:sports_mind/community/coachCommunity/community-pop-code.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/widgets/custom_button.dart';

class JoinCommunity extends StatelessWidget {
  const JoinCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Sad Face 1.png',
                  height: 388,
                  width: 500,
                ),
                const SizedBox(height: 24),
                const Text(
                  "You're Not Part of the Community Yet!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textcolor,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Join our community to connect with players and coaches, share insights, ask questions, and get inspired. Together, we build confidence and overcome challenges!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(121, 35, 35, 37),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      text: "Join the Community",
                      ontap: () {
                        showCommunityDialog(context);
                      },
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
