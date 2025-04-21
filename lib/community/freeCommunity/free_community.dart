import 'package:flutter/material.dart';
import 'package:sports_mind/community/freeCommunity/Leaderboard.dart';
import 'package:sports_mind/community/freeCommunity/chat.dart';
import 'package:sports_mind/http/api.dart';
import 'package:sports_mind/widgets/option_card.dart';

class freeCommunity extends StatefulWidget {
  const freeCommunity({super.key});

  @override
  State<freeCommunity> createState() => freeCommunityState();
}

class freeCommunityState extends State<freeCommunity> {
  double progressValue = 0.25;
  String? profileImage;
  List<dynamic> communityMembers = [];
  final Api api = Api();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    fetchCommunityData(); // Fetch community images
  }

  Future<void> _loadUserProfile() async {
    final userData = await api.fetchUserData();
    if (userData != null && mounted) {
      setState(() {
        profileImage = userData['image'];
      });
    }
  }

  Future<void> fetchCommunityData() async {
    var data = await api.getCommunityData();

    if (data is List) {
      setState(() {
        communityMembers = data;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load community members.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 252, 249, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              // Profile & Points Section
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 64,
                        height: 64,
                        child: CircularProgressIndicator(
                          value: progressValue,
                          strokeWidth: 6,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Color.fromRGBO(106, 149, 122, 1)),
                        ),
                      ),
                      profileImage == null || profileImage!.isEmpty
                          ? const CircularProgressIndicator()
                          : CircleAvatar(
                              radius: 32,
                              backgroundImage: AssetImage(profileImage!),
                              onBackgroundImageError: (_, __) => setState(() {
                                profileImage =
                                    null; // Handle broken image links
                              }),
                            ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text("240",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(width: 4),
                          Text("points", style: TextStyle(fontSize: 20)),
                          SizedBox(width: 10),
                          Icon(Icons.local_fire_department,
                              color: Colors.orange, size: 20),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Leaderboard()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(233, 239, 235, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        child: const Row(
                          children: [
                            Text("Leader board",
                                style: TextStyle(
                                    color: Color.fromRGBO(80, 112, 92, 1),
                                    fontSize: 16)),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward_ios,
                                color: Color.fromRGBO(80, 112, 92, 1)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.notifications,
                      size: 32, color: Color.fromRGBO(200, 200, 200, 1)),
                ],
              ),

              const SizedBox(height: 40),

              // Options
              buildOptionCard("Start daily workout", () {}),
              const SizedBox(height: 20),

              const Text("Your Safe Space to Talk and Learn",
                  style: TextStyle(
                      color: Color.fromRGBO(78, 78, 78, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),

              const SizedBox(height: 20),

              buildOptionCard(
                "Discuss personal strategies, get real-time feedback, and boost your performance",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatPage()),
                  );
                },
              ),

              const SizedBox(height: 20),

              const Text("Here’s Your Support Circle",
                  style: TextStyle(
                      color: Color.fromRGBO(78, 78, 78, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),

              const SizedBox(height: 20),

              // Display community images in a scrollable list
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: communityMembers.map((member) {
                    String imageUrl = member['image'] ?? ''; // Get image path

                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: imageUrl.startsWith('assets/')
                            ? AssetImage(imageUrl) as ImageProvider
                            : NetworkImage(imageUrl),
                        onBackgroundImageError: (_, __) => setState(() {
                          imageUrl =
                              ''; // Handle error (set a default image if needed)
                        }),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
