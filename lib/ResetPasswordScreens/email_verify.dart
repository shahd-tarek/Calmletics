import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sports_mind/ResetPasswordScreens/otp_email.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/widgets/custom_button.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  final FocusNode emailFocusNode = FocusNode();

  @override
  void dispose() {
    emailFocusNode.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _checkEmailAndNavigate() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/sendCode'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['message'] == "Code sent successfully to your email.") {
          // Navigate to OTP page with email
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpEmail(email: email), // Pass email here
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(data['message'] ?? 'Unexpected error occurred')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Error verifying email. Please try again later.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              "Continue with email",
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: textcolor),
            ),
            const SizedBox(height: 13),
            const Text(
              "Enter your email, we will send a vertification code\n to email",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              focusNode: emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
                floatingLabelStyle: const TextStyle(
                  color: kPrimaryColor,
                ),
                labelText: "email",
                labelStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                prefixIcon: Icon(
                  Icons.email_rounded,
                  color: emailFocusNode.hasFocus ? kPrimaryColor : Colors.grey,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "email can't be null";
                }
                if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                    .hasMatch(value)) {
                  return "Please enter a valid email";
                }
                return null;
              },
              onTap: () => setState(() {}),
            ),
            const SizedBox(height: 100),
            _isLoading
                ? const CircularProgressIndicator()
                : CustomButton(
                    text: "Send",
                    ontap: _checkEmailAndNavigate,
                  ),
          ],
        ),
      ),
    );
  }
}



/*import 'package:flutter/material.dart';
import 'package:sports_mind/ResetPasswordScreens/otp_email.dart';
import 'package:sports_mind/constanse.dart';
import 'package:sports_mind/widgets/custom_button.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({super.key});

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode emailFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();
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
                  "Continue with email",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: textcolor
                  ),
                ),
                const SizedBox(height: 13),
                const Text(
                  "Enter your email,we will send a vertification code",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const Text(
                  'to email',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  focusNode: emailFocusNode,
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    floatingLabelStyle: const TextStyle(
                      color: kPrimaryColor,
                    ),
                    labelText: "email",
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    prefixIcon: Icon(
                      Icons.email_rounded,
                      color: emailFocusNode.hasFocus
                          ? kPrimaryColor
                          : Colors.grey,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "email can't be null";
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                        .hasMatch(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                  onTap: () => setState(() {}),
                ),
                const SizedBox(height: 50),
                CustomButton(
                  text: "Send",
                  ontap: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmailVerificationPage(),
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
}*/
