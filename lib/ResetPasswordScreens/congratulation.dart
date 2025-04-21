import 'package:flutter/material.dart';
import 'package:sports_mind/constant.dart';

class Congrats extends StatefulWidget {
  const Congrats({super.key});

  @override
  State<Congrats> createState() => _CongratsState();
}

class _CongratsState extends State<Congrats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 161,
                  width: 161,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "assets/images/Group 5.png",
                  )),
              const SizedBox(
                height: 20,
              ),
              const Text('Congratulation',
                  style: TextStyle(
                    color: textcolor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
                    const SizedBox(
                height: 10,
              ),
              const Text(
                'You have successfully changed your ',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              const Text(
                'password',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
