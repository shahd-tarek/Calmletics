import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/views/user_type.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  bool isLastPage = false;
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                currentPageIndex = index;
                isLastPage = index == 2;
              });
            },
            children: [
              buildPage(
                image: "assets/images/Meditation1.png",
                title: "Welcome to\nCalmletics!",
                subtitle:
                    "We’re here to help you stay calm, confident, and in control.",
              ),
              buildPage(
                image: "assets/images/Meditation2.png",
                title: "Stay Calm, Play\nConfidently",
                subtitle:
                    "Feeling stressed before a big game? Don’t worry. We’ve personalized programs to help you stay calm.",
              ),
              buildPage(
                image: "assets/images/Meditation3.png",
                title: "Let’s get\nstarted!",
                subtitle:
                    "Let’s do this together. Tap below and start feeling unstoppable!",
              ),
            ],
          ),
          if (currentPageIndex < 2)
            Positioned(
              top: 40,
              right: 20,
              child: TextButton(
                onPressed: () {
                  controller.jumpToPage(2);
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
        ],
      ),
      bottomSheet:
          isLastPage ? buildGetStartedButton() : buildBottomNavigation(),
    );
  }

  Widget buildPage(
      {required String image,
      required String title,
      required String subtitle}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 500),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget buildGetStartedButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserType(),
              ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: const Text(
          "Get Started",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget buildBottomNavigation() {
    return Container(
       color: bgcolor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: const WormEffect(
                spacing: 8,
                dotColor: Colors.grey,
                dotWidth: 12,
                dotHeight: 12,
                activeDotColor: kPrimaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: kPrimaryColor,
              ),
              width: 70,
              height: 70,
              child: const Center(
                child: Text(
                  "Next",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
