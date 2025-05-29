import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sports_mind/calm_routine/quick_t1.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/helper/token_helper.dart';
import 'package:sports_mind/http/api.dart';
import 'package:sports_mind/models/progress_data.dart';
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
  late Future<ProgressData> progressFuture;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    progressFuture = fetchProgress();
  }

  Future<void> _loadUserProfile() async {
    final userData = await api.fetchUserData();
    if (userData != null && mounted) {
      setState(() {
        profileImage = userData['image'];
      });
    }
  }

  Future<ProgressData> fetchProgress() async {
    String? token = await TokenHelper.getToken();
    final url = Uri.parse('https://calmletics-production.up.railway.app/api/player/get-progress');

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ProgressData.fromJson(data);
    } else {
      throw Exception('Failed to load progress');
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
              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  IconButton(
                    icon: const Icon(Icons.notifications_rounded, size: 32),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Ready to conquer your anxiety today?',
                style: TextStyle(fontSize: 25, color: textcolor),
              ),
              const SizedBox(height: 24),

              // Content
              Expanded(
                child: ListView(
                  children: [
                    buildCard(
                      context: context,
                      title: 'Anxiety',
                      description: 'Feeling anxious? Take this test to see how you’re doing!',
                      image: 'assets/images/card1.png',
                      navigateTo: const SurveyScoreScreen(),
                    ),
                    const SizedBox(height: 16),

                    /// Plan & Task Progress Section
                    FutureBuilder<ProgressData>(
                      future: progressFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData) {
                          return const Center(child: Text('No data'));
                        }

                        final progress = snapshot.data!;
                        return Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 130,
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey, width: 1.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Your Plan',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Session ${progress.sessionNumber}: ${progress.sessionName}',
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                    const SizedBox(height: 16),
                                    LinearProgressIndicator(
                                      value: progress.planPercentage,
                                      color: kPrimaryColor,
                                      backgroundColor: Colors.grey.shade200,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 130,
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.only(left: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey, width: 1.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Task's Today",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      progress.taskProgress,
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                    const SizedBox(height: 12),
                                    LinearProgressIndicator(
                                      value: progress.taskPercentage,
                                      color: kPrimaryColor,
                                      backgroundColor: Colors.grey.shade200,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 16),
                    buildCard(
                      context: context,
                      title: 'Calm Routine Before match',
                      description: 'A quick and simple routine to calm your mind before the game.',
                      image: 'assets/images/card2.png',
                      navigateTo: const QuickTaskOne(pageIndex: 0, totalPages: 4),
                    ),
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
