import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sports_mind/community/coachCommunity/coach_community.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/widgets/custom_button.dart';

void showCommunityDialog(BuildContext context) {
  List<TextEditingController> textControllers =
      List.generate(4, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Let’s Get You Connected!",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textcolor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  "To join the conversation and connect with amazing players and coaches, enter your invite code below. Let’s get started!",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                      4,
                      (index) => _buildOTPBox(
                          index, textControllers, focusNodes, context)),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Don’t have a code? No worries! Contact us or your coach to get one and start your journey.",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: "Join Now",
                    ontap: () {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const coachCommunity()),
                          );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildOTPBox(int index, List<TextEditingController> textControllers,
    List<FocusNode> focusNodes, BuildContext context) {
  return SizedBox(
    width: 60,
    child: TextField(
      controller: textControllers[index],
      focusNode: focusNodes[index],
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      maxLength: 1,
      decoration: const InputDecoration(
        counterText: "",
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor, width: 2),
        ),
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          if (index < 3) {
            FocusScope.of(context).requestFocus(focusNodes[index + 1]);
          } else {
            focusNodes[index].unfocus();
          }
        } else if (value.isEmpty && index > 0) {
          FocusScope.of(context).requestFocus(focusNodes[index - 1]);
        }
      },
    ),
  );
}
