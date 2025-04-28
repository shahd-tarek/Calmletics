import 'package:flutter/material.dart';
import 'package:sports_mind/calm%20routine/quick_t1.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/http/api.dart';
import 'package:sports_mind/views/user_profile.dart';
import 'package:sports_mind/widgets/card.dart';
import 'package:sports_mind/qustions/surveyscore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? profileImage;
  final Api api = Api();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final userData = await api.fetchUserData();
    if (userData != null && mounted) {
      setState(() {
        profileImage = userData['image'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserProfileOverview(),
                            ),
                          );
                        },
                        child: profileImage == null || profileImage!.isEmpty
                            ? const CircularProgressIndicator()
                            : CircleAvatar(
                                radius: 32,
                                backgroundImage: AssetImage(profileImage!),
                                onBackgroundImageError: (_, __) => setState(() {
                                  profileImage = null;
                                }),
                              ),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_rounded,
                      size: 32,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ready to conquer your anxiety today?',
                    style: TextStyle(
                      fontSize: 25,
                      color: textcolor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    buildCard(
                      context: context,
                      title: 'Anxiety',
                      description:
                          'Feeling anxious? Take this test to see how you’re doing!',
                      image: 'assets/images/card1.png',
                      navigateTo: const SurveyScoreScreen(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Your Plan',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Session 2: A Quiet Start',
                                  style: TextStyle(color: Colors.black),
                                ),
                                const SizedBox(height: 12),
                                LinearProgressIndicator(
                                  value: 0.48,
                                  color: kPrimaryColor,
                                  backgroundColor: Colors.grey.shade200,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(left: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Task's Today",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  '1 of 5 tasks completed',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 12),
                                LinearProgressIndicator(
                                  value: 0.4,
                                  color: kPrimaryColor,
                                  backgroundColor: Colors.grey.shade200,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildCard(
                      context: context,
                        title: 'Calm Routine Before match',
                        description:
                            'A quick and simple routine to calm your mind before the game.',
                        image: 'assets/images/card2.png',
                        navigateTo:  const QuickTaskOne(pageIndex: 0,totalPages: 4,)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
