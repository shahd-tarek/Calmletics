import 'package:flutter/material.dart';
import 'package:sports_mind/coach/VR/vr_schedula.dart';
import 'package:sports_mind/coach/screens/coach_home.dart';
import 'package:sports_mind/coach/screens/players.dart';
import 'package:sports_mind/coach/tabbars/community_tab_bar.dart';
import 'package:sports_mind/coach/widget/bottom_navigation_bar.dart';
import 'package:sports_mind/coach/widgetsOfHome/community_card.dart';
import 'package:sports_mind/constant.dart';

class AllCommunity extends StatefulWidget {
  final bool showBottomBar;

  const AllCommunity({super.key, this.showBottomBar = false});

  @override
  State<AllCommunity> createState() => _AllCommunityState();
}

class _AllCommunityState extends State<AllCommunity> {
  String selectedTab = 'all';
  int _selectedIndex = 3; // Community tab index

  List<Map<String, dynamic>> community = [
    {
      "title": "Anxiety Warriors",
      "level": "high",
      "week": 1,
      "players": 12,
      "progress": 0.4, // Fixed extra space in key
    },
    {
      "title": "Mindfulness Group",
      "level": "intermediate",
      "week": 2,
      "players": 10,
      "progress": 0.6,
    },
    {
      "title": "Calm Minds",
      "level": "low",
      "week": 3,
      "players": 8,
      "progress": 0.3,
    },
    {
      "title": "Stress-Free Zone",
      "level": "high",
      "week": 1,
      "players": 15,
      "progress": 0.5,
    },
  ];

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() => _selectedIndex = index);
      _navigateToScreen(index);
    }
  }

  void _navigateToScreen(int index) {
    switch (index) {
        case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CoachHome()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const VRScheduleScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Players()),
        );
      case 3:
       Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AllCommunity()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CommunityTabBar(
              selectedTab: selectedTab,
              onTabSelected: (tab) => setState(() => selectedTab = tab),
            ),
            const SizedBox(height: 16),
            const Text(
              "Community",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(78, 78, 78, 1),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: community.length,
                itemBuilder: (context, index) {
                  return CommunityCard(
                    title: community[index]['title'],
                    level: community[index]['level'],
                    week: "Week ${community[index]['week']}",
                    players: community[index]['players'],
                    progress: community[index]['progress'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.showBottomBar
          ? CustomBottomNavigationBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            )
          : null,
      floatingActionButton: widget.showBottomBar
          ? FloatingActionButton(
              onPressed: () => print("FAB tapped"),
              backgroundColor: const Color.fromRGBO(106, 149, 122, 1),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            )
          : null,
      floatingActionButtonLocation: widget.showBottomBar
          ? FloatingActionButtonLocation.centerDocked
          : null,
    );
  }
}
