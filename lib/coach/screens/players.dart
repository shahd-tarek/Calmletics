import 'package:flutter/material.dart';
import 'package:sports_mind/coach/VR/vr_schedula.dart';
import 'package:sports_mind/coach/screens/all_community.dart';
import 'package:sports_mind/coach/screens/coach_home.dart';
import 'package:sports_mind/coach/tabbars/player_tab_bar.dart';
import 'package:sports_mind/coach/widget/bottom_navigation_bar.dart';
import 'package:sports_mind/coach/widgetsOfHome/player_progress_card.dart';

class Players extends StatefulWidget {
  final bool showBottomBar;

  const Players({super.key, this.showBottomBar = false});

  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  String selectedTab = 'all';
  int _selectedIndex = 2; // Players tab index

  List<Map<String, dynamic>> players = [
    {
      "name": "Savannah Nguyen",
      "team": "Anxiety Warriors",
      "message": "hasn’t logged progress in the last 3 days",
      "icon": Icons.error_outline,
      "iconColor": Colors.red,
    },
    {
      "name": "Alex Taylor",
      "team": "Anxiety Warriors",
      "message":
          "Player Alex Taylor achieved a personal best in the Anxiety Test",
      "icon": Icons.check_circle_outline,
      "iconColor": Colors.green,
    },
    {
      "name": "Emily Carter",
      "team": "Anxiety Warriors",
      "message": "hasn’t logged progress in the last 3 days",
      "icon": Icons.check_circle_outline,
      "iconColor": Colors.green,
    },
    {
      "name": "Savannah Nguyen",
      "team": "Anxiety Warriors",
      "message": "hasn’t logged progress in the last 3 days",
      "icon": Icons.error_outline,
      "iconColor": Colors.red,
    },
    {
      "name": "Savannah Nguyen",
      "team": "Anxiety Warriors",
      "message": "hasn’t logged progress in the last 3 days",
      "icon": Icons.error_outline,
      "iconColor": Colors.red,
    },
    {
      "name": "Savannah Nguyen",
      "team": "Anxiety Warriors",
      "message": "hasn’t logged progress in the last 3 days",
      "icon": Icons.error_outline,
      "iconColor": Colors.red,
    },
    {
      "name": "Savannah Nguyen",
      "team": "Anxiety Warriors",
      "message": "hasn’t logged progress in the last 3 days",
      "icon": Icons.error_outline,
      "iconColor": Colors.red,
    },
    {
      "name": "Savannah Nguyen",
      "team": "Anxiety Warriors",
      "message": "hasn’t logged progress in the last 3 days",
      "icon": Icons.error_outline,
      "iconColor": Colors.red,
    },
    {
      "name": "Savannah Nguyen",
      "team": "Anxiety Warriors",
      "message": "hasn’t logged progress in the last 3 days",
      "icon": Icons.error_outline,
      "iconColor": Colors.red,
    },
    {
      "name": "Savannah Nguyen",
      "team": "Anxiety Warriors",
      "message": "hasn’t logged progress in the last 3 days",
      "icon": Icons.error_outline,
      "iconColor": Colors.red,
    },
    {
      "name": "Savannah Nguyen",
      "team": "Anxiety Warriors",
      "message": "hasn’t logged progress in the last 3 days",
      "icon": Icons.error_outline,
      "iconColor": Colors.red,
    },
    {
      "name": "Savannah Nguyen",
      "team": "Anxiety Warriors",
      "message": "hasn’t logged progress in the last 3 days",
      "icon": Icons.error_outline,
      "iconColor": Colors.red,
    },
    {
      "name": "Savannah Nguyen",
      "team": "Anxiety Warriors",
      "message": "hasn’t logged progress in the last 3 days",
      "icon": Icons.error_outline,
      "iconColor": Colors.red,
    },
  ];

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
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
        break; // Already on Players screen
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
      backgroundColor: const Color.fromRGBO(255, 252, 249, 1),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                Container(
                  width: 42,
                  height: 39,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(106, 149, 122, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Image.asset('assets/images/setting-4.png'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: const Color.fromRGBO(255, 255, 255, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            PlayerTabBar(
              selectedTab: selectedTab,
              onTabSelected: (tab) {
                setState(() {
                  selectedTab = tab;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              "Players",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(78, 78, 78, 1)),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: players.length,
                itemBuilder: (context, index) {
                  var player = players[index];
                  return PlayerProgressCard(
                    playerName: player["name"],
                    communityName: player["team"],
                    statusMessage: player["message"],
                    icon: player["icon"],
                    iconColor: player['iconColor'],
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
              onPressed: () {
                print("FAB tapped");
              },
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
