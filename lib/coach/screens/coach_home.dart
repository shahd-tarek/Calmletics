import 'package:flutter/material.dart';
import 'package:sports_mind/coach/VR/vr_schedula.dart';
import 'package:sports_mind/coach/screens/all_community.dart';
import 'package:sports_mind/coach/screens/create_community.dart';
import 'package:sports_mind/coach/screens/players.dart';
import 'package:sports_mind/coach/widget/bottom_navigation_bar.dart';
import 'package:sports_mind/coach/widgetsOfHome/community_card.dart';
import 'package:sports_mind/coach/widgetsOfHome/player_progress_card.dart';
import 'package:sports_mind/coach/widgetsOfHome/stats_card.dart';
import 'package:sports_mind/http/api.dart';

class CoachHome extends StatefulWidget {
  const CoachHome({super.key});

  @override
  State<CoachHome> createState() => _CoachHomeState();
}

class _CoachHomeState extends State<CoachHome> {
  int _selectedIndex = 0; // Track selected tab

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Screens for each tab
  final List<Widget> _screens = [
    const HomeContent(), // Home screen content
    const VRScheduleScreen(),
    const Players(), // Players screen
    const AllCommunity(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 252, 249, 1),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateCommunity()));
        },
        backgroundColor: const Color.fromRGBO(106, 149, 122, 1),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
    );
  }
}

// Extracted Home Content to Keep it Clean
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String? profileImage;

  final Api api = Api();
  Future<void> loadUserProfile() async {
    final userData = await api.fetchUserData();
    if (userData != null && mounted) {
      setState(() {
        profileImage = userData['image'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: const Color.fromRGBO(226, 226, 226, 1),
                      width: 1,
                    ),
                  ),
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
                const Spacer(),
                const Icon(Icons.notifications, size: 32, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Community',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllCommunity(
                                  showBottomBar: true,
                                )));
                  },
                  child: const Text('See All',
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CommunityCard(
                    title: 'Anxiety Warriors',
                    level: 'low',
                    week: 'Week 3 - Stress Management',
                    players: 15,
                    progress: 0.4,
                  ),
                  SizedBox(width: 8),
                  CommunityCard(
                    title: 'Mindfulness Group',
                    level: 'intermediate',
                    week: 'Week 2 - Breathing Techniques',
                    players: 10,
                    progress: 0.6,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Player Progress',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Players(
                                  showBottomBar: true,
                                )));
                  },
                  child: const Text('See All',
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ),
              ],
            ),
            const PlayerProgressCard(
              playerName: 'Savannah Nguyen',
              communityName: 'Anxiety Warriors',
              statusMessage: "hasn't logged progress in the last 3 days",
              icon: Icons.error_outline,
              iconColor: Colors.red,
            ),
            const PlayerProgressCard(
              playerName: 'Savannah Nguyen',
              communityName: 'Anxiety Warriors',
              statusMessage: "hasn't logged progress in the last 3 days",
              icon: Icons.check_circle_outline,
              iconColor: Colors.green,
            ),
            const SizedBox(height: 30),
            const Row(
              children: [
                StatsCard(
                    title: 'Total Players',
                    value: '50',
                    iconPath: 'assets/images/tabler_play-football.png'),
                Spacer(),
                StatsCard(
                    title: 'Sessions Today',
                    value: '3',
                    iconPath: 'assets/images/Group.png'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
