import 'package:flutter/material.dart';
import 'package:sports_mind/coach/screens/coach_leaderboard.dart';
import 'package:sports_mind/coach/screens/players.dart';
import 'package:sports_mind/coach/widgetsOfHome/player_progress_card.dart';
import 'package:sports_mind/coach/widgetsOfHome/stats_card.dart';
import 'package:sports_mind/widgets/leaderboard_item.dart';

class PopCode extends StatefulWidget {
  final String otpCode; // Add this to accept the OTP code

  const PopCode({super.key, required this.otpCode}); // Constructor to receive the OTP code

  @override
  State<PopCode> createState() => _PopCodeState();
}

class _PopCodeState extends State<PopCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 252, 249, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 252, 249, 1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // OTP Code Section
            Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.black12,
                        backgroundImage: AssetImage(
                            'assets/images/Coach 3.png'), // Ensure this image exists
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text("Anxiety Warriors",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(239, 255, 206, 1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text("low",
                                    style: TextStyle(
                                        color: Color.fromRGBO(153, 194, 70, 1),
                                        fontSize: 12)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(233, 239, 235, 1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.message,
                                    color: Color.fromRGBO(80, 112, 92, 1),
                                    size: 16),
                                const SizedBox(width: 4),
                                Text(widget.otpCode,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(80, 112, 92, 1))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Rest of the UI remains the same
            const Text(
              'plan',
              style: TextStyle(
                  color: Color.fromRGBO(78, 78, 78, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildPlanCard(
                      "week 1", "Relaxation and Stress Reduction", 0.5),
                  const SizedBox(width: 8),
                  _buildPlanCard("week 2", "Mindfulness Techniques", 0.3),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Stats Section
            const Row(
              children: [
                StatsCard(
                    title: 'Total Players',
                    value: '18',
                    iconPath: 'assets/images/tabler_play-football.png'),
                Spacer(),
                StatsCard(
                    title: 'Sessions Today',
                    value: '3',
                    iconPath: 'assets/images/Group.png'),
              ],
            ),
            const SizedBox(height: 20),

            // Add Player and View Schedule Buttons
            Row(
              children: [
                _buildIconButton("Add player", Icons.add),
                const SizedBox(
                  width: 100,
                ),
                _buildIconButton("View schedule", Icons.calendar_today),
              ],
            ),
            const SizedBox(height: 20),

            // Top Player Section
            _buildSectionHeader("Top player", "Leader board"),
            const SizedBox(height: 10),
            const LeaderboardItem(
                rank: 4,
                name: 'ahmed',
                points: 2222,
                imagePath: 'assets/images/Coach 3.png'),
            const SizedBox(height: 8),
            const LeaderboardItem(
                rank: 5,
                name: 'mohamed',
                points: 2212,
                imagePath: 'assets/images/Coach 3.png'),
            const SizedBox(
              height: 10,
            ),
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
            const SizedBox(
              height: 10,
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
              icon: Icons.error_outline,
              iconColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  // Widget for plan cards
  Widget _buildPlanCard(String week, String title, double progress) {
    return Container(
      width: 377,
      height: 130,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(week,
                style: const TextStyle(
                    fontSize: 14, color: Color.fromRGBO(133, 133, 133, 1))),
            const SizedBox(height: 4),
            Text(title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(66, 66, 66, 0.8))),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  width: 217,
                  height: 19,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: const Color.fromRGBO(237, 237, 237, 1),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(106, 149, 122, 1)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(78, 78, 78, 1)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget for icon buttons
  Widget _buildIconButton(String title, IconData icon) {
    return Row(children: [
      Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(106, 149, 122, 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          // Centering the icon
          child: Icon(
            icon,
            size: 16,
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
      ),
      const SizedBox(width: 8),
      Text(
        title,
        style: const TextStyle(fontSize: 16, color: Color.fromRGBO(78, 78, 78, 1)),
      )
    ]);
  }

  // Widget for section headers
  Widget _buildSectionHeader(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CoachLeaderboard()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(233, 239, 235, 1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          child: const Row(
            children: [
              Text("Leader board",
                  style: TextStyle(
                      color: Color.fromRGBO(80, 112, 92, 1), fontSize: 16)),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward_ios,
                  color: Color.fromRGBO(80, 112, 92, 1)),
            ],
          ),
        ),
      ],
    );
  }
}
