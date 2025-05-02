import 'package:flutter/material.dart';

class TopThreeUsers extends StatelessWidget {
  final List<Map<String, dynamic>> topUsers;

  const TopThreeUsers({super.key, required this.topUsers});

  @override
  Widget build(BuildContext context) {
    // Sort top 3 by points descending
    final sortedUsers = [...topUsers]..sort((a, b) => b['points'].compareTo(a['points']));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(3, (index) {
        final user = sortedUsers[index];
        final height = getBarHeight(index);
        final isFirst = index == 0;

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (isFirst)
              const Icon(Icons.emoji_events, color: Colors.amber, size: 24), // التاج الذهبي

            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(user['imagePath']),
            ),
            const SizedBox(height: 6),
            Text(
              user['name'],
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              user['points'].toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              width: 65,
              height: height,
              decoration: BoxDecoration(
                color: const Color(0xFF6A957A),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  (index + 1).toString(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 70),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  double getBarHeight(int index) {
    switch (index) {
      case 0:
        return 150;
      case 1:
        return 120;
      case 2:
        return 100;
      default:
        return 100;
    }
  }
}
