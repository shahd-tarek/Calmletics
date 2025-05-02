import 'package:flutter/material.dart';
import 'package:sports_mind/community/freeCommunity/list.dart';
import 'package:sports_mind/coach/widget/leaderboard_item.dart';
import 'package:sports_mind/widgets/leaderboard_tab_bar.dart';
import 'package:sports_mind/coach/widget/top_three.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  String selectedTab = 'Today';
  final List<Map<String, dynamic>> topUsers = [
    {'name': 'Jane', 'points': 958, 'imagePath': 'assets/images/Coach 1.jpg'},
    {'name': 'John', 'points': 1200, 'imagePath': 'assets/images/Coach 1.jpg'},
    {'name': 'Alice', 'points': 800, 'imagePath': 'assets/images/Coach 1.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color.fromRGBO(255, 252, 249, 1),
      ),
      backgroundColor: const Color.fromRGBO(255, 252, 249, 1),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Center(
              child: Column(
                children: [
                  LeaderboardTabBar(
                    selectedTab: selectedTab,
                    onTabSelected: (tab) {
                      setState(() {
                        selectedTab = tab;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TopThreeUsers(topUsers: topUsers),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 252, 249, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: LeaderboardItem(
                        rank: items[index].number,
                        name: items[index].name,
                        points: items[index].point,
                        imagePath: 'assets/images/Coach 1.jpg',
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
