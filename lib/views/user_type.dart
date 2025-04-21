import 'package:flutter/material.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/auth_screens/signup_page.dart';
import 'package:sports_mind/widgets/custom_button.dart';

class UserType extends StatefulWidget {
  const UserType({super.key});

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  String selectedRole = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Text(
              "I am a",
              style: TextStyle(
                  color: Color(0xff3B3B3B),
                  fontSize: 32,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedRole = 'Coach';
                });
              },
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 95,
                    backgroundColor: selectedRole == 'Coach'
                        ? Colors.green[100]
                        : Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          border: Border.all(
                              color: selectedRole == 'Coach'
                                  ? kPrimaryColor
                                  : Colors.grey,
                              width: 2)),
                      child: const CircleAvatar(
                        radius: 90,
                        backgroundImage: AssetImage('assets/images/Coach 1.jpg'),
                      ),
                    ),
                  ),
                  if (selectedRole == 'Coach')
                    const Positioned(
                      top: 12,
                      left: 140,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: kPrimaryColor,
                        child: Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Coach",
              style: TextStyle(
                  color: Color(0xff3B3B3B),
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedRole = 'Player';
                });
              },
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 98,
                    backgroundColor: selectedRole == 'Player'
                        ? Colors.green[100]
                        : Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          border: Border.all(
                              color: selectedRole == 'Player'
                                  ? kPrimaryColor
                                  : Colors.grey,
                              width: 2)),
                      child: const CircleAvatar(
                        radius: 90,
                        backgroundImage: AssetImage('assets/images/Coach 2.jpg'),
                      ),
                    ),
                  ),
                  if (selectedRole == 'Player')
                    const Positioned(
                       top: 12,
                      left: 140,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: kPrimaryColor,
                        child: Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Player",
              style: TextStyle(
                  color: Color(0xff3B3B3B),
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 70),
            CustomButton(
              text: "Next",
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Signup(userRole: selectedRole),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
