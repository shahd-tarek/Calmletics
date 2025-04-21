import 'package:flutter/material.dart';
import 'package:sports_mind/ResetPasswordScreens/email_verify.dart';
import 'package:sports_mind/ResetPasswordScreens/phone_verify.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/widgets/custom_button.dart';

class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  bool isEmailSelected = false;
  bool isPhoneSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: bgcolor,
        elevation: 0,
      ),
      backgroundColor: bgcolor,
      body: Padding(
        padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Forget Password',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color:textcolor),
                ),
                const SizedBox(height: 13),
                const Text(
                  'Please select option to send link reset password',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isEmailSelected = true;
                      isPhoneSelected =
                          false; 
                    });
                  },
                  child: Container(
                    height: 64,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isEmailSelected ? kPrimaryColor : Colors.grey,
                        width: 1.5,
                      ),
                      boxShadow: isEmailSelected
                          ? [
                              BoxShadow(
                                color: kPrimaryColor.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : null,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.email_rounded,
                          color: isEmailSelected ? kPrimaryColor : Colors.grey,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Reset via email',
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                isEmailSelected ? kPrimaryColor : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isPhoneSelected = true;
                      isEmailSelected =
                          false; 
                    });
                  },
                  child: Container(
                    height: 64,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isPhoneSelected ? kPrimaryColor : Colors.grey,
                        width: 1.5,
                      ),
                      boxShadow: isPhoneSelected
                          ? [
                              BoxShadow(
                                color: kPrimaryColor.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : null,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: isPhoneSelected ? kPrimaryColor : Colors.grey,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Reset via Phone',
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                isPhoneSelected ? kPrimaryColor : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                CustomButton(
                  text: "Continue",
                  ontap: () {
                    if (isEmailSelected || isPhoneSelected) {
                      if (isEmailSelected) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EmailVerificationPage(),
                          ),
                        );
                      } else if (isPhoneSelected) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PhoneVerify(),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please choose email or phone number"),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        
      ),
    );
  }
}
