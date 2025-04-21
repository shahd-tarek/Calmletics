import 'package:flutter/material.dart';
import 'package:sports_mind/ResetPasswordScreens/congratulation.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/widgets/custom_button.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  bool visiable = true;
  bool pvisiable = true;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

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
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textcolor
                  ),
                ),
                const SizedBox(height: 13),
                const Text(
                  " Your password must be at least 8 characters long and include",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const Text(
                  ' a combination of letters numbers',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 20),

                // كلمة السر
                TextFormField(
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  obscureText: visiable,
                  validator: (value) {
                    if (value!.length < 8) {
                      return "password is too short";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor, width: 2),
                    ),
                    floatingLabelStyle: const TextStyle(
                      color: kPrimaryColor,
                    ),
                    prefixIcon: Icon(
                      Icons.lock_rounded,
                      color: passwordFocusNode.hasFocus
                          ? kPrimaryColor
                          : Colors.grey,
                    ),
                    labelText: "password",
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          visiable = !visiable;
                        });
                      },
                      icon: Icon(
                        visiable ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  onTap: () => setState(() {}),
                ),
                const SizedBox(height: 20),

                // تأكيد كلمة السر
                TextFormField(
                  controller: confirmPasswordController,
                  focusNode: confirmPasswordFocusNode,
                  obscureText: pvisiable,
                  validator: (value) {
                    if (value != passwordController.text) {
                      return "Password does not match";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor, width: 2),
                    ),
                    floatingLabelStyle: const TextStyle(
                      color: kPrimaryColor,
                    ),
                    prefixIcon: Icon(
                      Icons.lock_rounded,
                      color: confirmPasswordFocusNode.hasFocus
                          ? kPrimaryColor
                          : Colors.grey,
                    ),
                    labelText: "Confirm Password",
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          pvisiable = !pvisiable;
                        });
                      },
                      icon: Icon(
                        pvisiable ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  onTap: () => setState(() {}),
                ),
                const SizedBox(height: 50),

                CustomButton(
                  text: "Submit",
                  ontap: () {
                    if (formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "The password has been changed successfully"),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Congrats(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
