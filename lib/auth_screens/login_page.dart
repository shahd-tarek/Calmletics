import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_mind/ResetPasswordScreens/forgetpass.dart';
import 'package:sports_mind/coach/coach_avatar.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/http/api.dart';
import 'package:sports_mind/qustions/start.dart';
import 'package:sports_mind/widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  final String? selectedRole;
  const LoginPage({super.key, this.selectedRole});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visiable = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  bool isEmailFocused = false;
  bool isPasswordFocused = false;
  late String selectedRole;
  final Api api = Api();

  @override
  void initState() {
    super.initState();
    selectedRole = widget.selectedRole!;
    emailFocusNode.addListener(() {
      setState(() {
        isEmailFocused = emailFocusNode.hasFocus;
      });
    });

    passwordFocusNode.addListener(() {
      setState(() {
        isPasswordFocused = passwordFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: kPrimaryColor),
      ),
    );
  }

  void hideLoadingDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future<void> handleLogin() async {
    if (!formKey.currentState!.validate()) return;

    showLoadingDialog();

    try {
      final response = await api.loginUser(
        emailController.text.trim(),
        passwordController.text.trim(),
        selectedRole,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', response.token);

      hideLoadingDialog();

      Future.delayed(const Duration(), () {
        Widget nextPage =
            selectedRole == "Coach" ? const CoachAvatar() : const Start();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      });
    } catch (e) {
      hideLoadingDialog();
      showModernDialog("Oops!", "please try again", success: false);
    }
  }

  void showModernDialog(String title, String message, {bool success = true}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(success ? Icons.check_circle : Icons.error,
                color: success ? Colors.green : Colors.red),
            const SizedBox(width: 10),
            Text(title,
                style: TextStyle(
                    color: success ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(message, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/logo.png",
                        width: 50, height: 50),
                    const Text(
                      "Calmletics",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                const Row(
                  children: [
                    Text(
                      "Sign in your account",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: textcolor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 13),
                const Text(
                  "Welcome Back to App! Ready to crush your goals?",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  focusNode: emailFocusNode,
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor)),
                    floatingLabelStyle:
                        const TextStyle(color: Color.fromARGB(255, 9, 90, 51)),
                    labelText: "Email",
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    prefixIcon: Icon(
                      Icons.email_rounded,
                      color: isEmailFocused ? kPrimaryColor : Colors.grey,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                        .hasMatch(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  obscureText: visiable,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    if (value.length < 6) {
                      return "Password is too short";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor)),
                    floatingLabelStyle:
                        const TextStyle(color: Color.fromARGB(255, 2, 46, 25)),
                    prefixIcon: Icon(
                      Icons.lock_rounded,
                      color: isPasswordFocused ? kPrimaryColor : Colors.grey,
                    ),
                    labelText: "Password",
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
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Forget()),
                        );
                      },
                      child: const Text(
                        "Forget Password?",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 100),
                CustomButton(
                  text: "Sign in",
                  ontap: handleLogin,
                ),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage("assets/images/Ellipse 2.png")),
                    SizedBox(width: 10),
                    Image(image: AssetImage("assets/images/Ellipse 3.png")),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't Have an account",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 107, 106, 106),
                      ),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor: kPrimaryColor,
                          decorationThickness: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
