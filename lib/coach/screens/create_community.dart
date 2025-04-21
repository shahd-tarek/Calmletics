import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sports_mind/coach/screens/community_pop_code.dart';
import 'package:sports_mind/coach/tabbars/tab_bar.dart';

class CreateCommunity extends StatefulWidget {
  const CreateCommunity({super.key});

  @override
  _CreateCommunityState createState() => _CreateCommunityState();
}

class _CreateCommunityState extends State<CreateCommunity> {
  String selectedLevel = 'low'; // Default selected level

  // Function to generate a random 4-digit OTP code
  String generateOtpCode() {
    final random = Random();
    return (1000 + random.nextInt(9000)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 252, 249, 1),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color.fromRGBO(255, 252, 249, 1),
        elevation: 0,
        title: const Text(
          "create community",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 300,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 252, 249, 1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Image.asset(
              'assets/images/Team spirit-cuate 1.png',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.edit, color: Colors.grey),
                          hintText: "Name Your Community",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "choose level",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(78, 78, 78, 1),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTabBar(
                        selectedLevel: selectedLevel,
                        onTabSelected: (tab) {
                          setState(() {
                            selectedLevel = tab;
                          });
                        },
                      ),
                      const SizedBox(height: 80),
                      ElevatedButton(
                        onPressed: () {
                          createCommunityPopDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(106, 149, 122, 1),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          "Next",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void createCommunityPopDialog(BuildContext context) {
    // Generate a random OTP code
    String generatedOtpCode = generateOtpCode();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black, size: 32),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const Text(
                  "Successfully",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Image.asset(
                  "assets/images/Coach 3.png",
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 30),
                Text(
                  "Your OTP Code: $generatedOtpCode", // Display the generated OTP code
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the PopCode screen with the generated OTP code
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PopCode(otpCode: generatedOtpCode),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(106, 149, 122, 1),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}