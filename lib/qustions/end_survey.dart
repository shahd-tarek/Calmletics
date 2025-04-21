import 'package:flutter/material.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/views/main_screen.dart';
import 'package:sports_mind/widgets/custom_button.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(

      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 18),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Congratulations!",
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: textcolor),
            ),

            const SizedBox(height: 20),
            SizedBox(
              height: 120,
              child: Image.asset('assets/images/Step One.png'),
            ),

            const SizedBox(height: 20),

           
            const Text(
              "You've taken the first step toward managing your anxiety",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 35),

            SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: "Continue",
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
 