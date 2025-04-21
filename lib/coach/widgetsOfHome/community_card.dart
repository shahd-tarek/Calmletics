import 'package:flutter/material.dart';

class CommunityCard extends StatelessWidget {
  final String title;
  final String level;
  final String week;
  final int players;
  final double progress;

  const CommunityCard({
    super.key,
    required this.title,
    required this.level,
    required this.week,
    required this.players,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    switch (level.toLowerCase()) {
      case "low":
        backgroundColor = const Color.fromRGBO(239, 255, 206, 1);
        textColor = const Color.fromRGBO(153, 194, 70, 1);
        break;
      case "intermediate":
        backgroundColor =const Color.fromRGBO(254, 251, 226, 1);
        textColor = const Color.fromRGBO(212, 193, 17, 1);
        break;
      default: // High
        backgroundColor = const Color.fromRGBO(255, 235, 228, 1);
        textColor = const Color.fromRGBO(212, 60, 10, 1);
        break;
    }

    // ضبط حجم الـ Container بناءً على عدد الأحرف
    double containerWidth = (level.length * 12.0).clamp(40.0, 100.0);
    double containerHeight = (level.length * 8.0).clamp(30.0, 35.0);

    return Column(
      children: [
        Container(
          width: 358,
          height: 165,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color.fromRGBO(218, 218, 218, 1),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(78, 78, 78, 1),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // مستوى اللاعب (يتم ضبط حجمه ديناميكياً)
                    Container(
                      width: containerWidth,
                      height: containerHeight,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          level,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 239, 235, 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Current Week',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(80, 112, 92, 1),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      week,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(66, 66, 66, 0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/tabler_play-football.png',
                      width: 18,
                      height: 18,
                      color: const Color.fromRGBO(106, 149, 122, 1),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Total Players: $players',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(66, 66, 66, 0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(
                      width: 258,
                      height: 19,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey.shade300,
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
                        color: Color.fromRGBO(78, 78, 78, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
