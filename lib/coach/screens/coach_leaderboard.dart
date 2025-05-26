import 'package:flutter/material.dart';
import 'package:sports_mind/coach/tabbars/leaderboard_tab_bar.dart';
import 'package:sports_mind/widgets/leaderboard_item.dart';
import 'package:sports_mind/http/api.dart'; 

class CoachLeaderboard extends StatefulWidget {
  final String communityId; // Add communityId as a parameter

  const CoachLeaderboard({super.key, required this.communityId});

  @override
  State<CoachLeaderboard> createState() => _CoachLeaderboardState();
}

class _CoachLeaderboardState extends State<CoachLeaderboard> {
  String selectedTab = 'Daily'; // Default selected tab

  List<Map<String, dynamic>> leaderboardData = [];
  bool isLoading = true;

  // Fetch leaderboard data from API
  Future<void> fetchLeaderboardData(String time) async {
    final data = await Api.fetchLeaderboard(widget.communityId, time); // Use the passed communityId
    setState(() {
      leaderboardData = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchLeaderboardData("weekly"); // Example time, can be updated
  }

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
                      fetchLeaderboardData(selectedTab.toLowerCase());
                    },
                  ),
                  const SizedBox(height: 20),
                  // Display top 3 users
                 
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
                child: isLoading
                    ? const Center(child: CircularProgressIndicator()) // Show loading indicator
                    : ListView.builder(
                        itemCount: leaderboardData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: LeaderboardItem(
                              rank: leaderboardData[index]['rank'],
                              name: leaderboardData[index]['name'],
                              points: leaderboardData[index]['total_score'],
                              imagePath: leaderboardData[index]['image'] ?? 'assets/images/default.png',
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
