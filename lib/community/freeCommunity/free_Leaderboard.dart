import 'package:flutter/material.dart';
import 'package:sports_mind/http/api.dart';
import 'package:sports_mind/widgets/leaderboard_item.dart';
import 'package:sports_mind/widgets/leaderboard_tab_bar.dart';
import 'package:sports_mind/widgets/top_three.dart';

class FreeLeaderboard extends StatefulWidget {
  const FreeLeaderboard({super.key});

  @override
  State<FreeLeaderboard> createState() => _FreeLeaderboardState();
}

class _FreeLeaderboardState extends State<FreeLeaderboard> {
  String selectedTab = 'Daily';

  List<Map<String, dynamic>> topThreeFree = [];
  List<Map<String, dynamic>> otherUsers = [];
  bool isLoading = true;

  Future<void> fetchFreeLeaderboardData(String time) async {
    final data = await Api.fetchFreeLeaderboard(time);

    setState(() {
      topThreeFree = data['top3'] ?? [];
      otherUsers = data['others'] ?? [];
      isLoading = false;
    });
  }

  void onTabSelected(String tab) {
    setState(() {
      selectedTab = tab;
      isLoading = true;
    });
    fetchFreeLeaderboardData(tab.toLowerCase());
  }

  @override
  void initState() {
    super.initState();
    fetchFreeLeaderboardData("weekly");
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
            child: Column(
              children: [
                LeaderboardTabBar(
                  selectedTab: selectedTab,
                  onTabSelected: onTabSelected,
                ),
                const SizedBox(height: 20),
                topThreeFree.isNotEmpty
                    ? TopThree(topUsers: topThreeFree)
                    : const Center(child: Text("No top users available")),
              ],
            ),
          ),
          const SizedBox(height: 16),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : otherUsers.isNotEmpty
                        ? ListView.builder(
                            itemCount: otherUsers.length,
                            itemBuilder: (context, index) {
                              final user = otherUsers[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: LeaderboardItem(
                                  rank: user['rank'],
                                  name: user['name'],
                                  points: user['total_score'],
                                  imagePath: user['image'] ??
                                      'assets/images/default.png',
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text("No users in the leaderboard")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
