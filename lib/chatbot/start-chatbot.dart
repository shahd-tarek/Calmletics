import 'package:flutter/material.dart';
import 'package:sports_mind/widgets/custom_button.dart';

class StartChatbot extends StatelessWidget {
  const StartChatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => {
            Navigator.of(context).pop(),
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/backgrouq chat.png",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Best Personal\n AI Assistant",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/images/robot.png",
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text("How can i help you ?",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: 50,
                ),
                CustomButton(
                  text: "Start a new chat",
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
