import 'package:flutter/material.dart';

class PlayerProgressCard extends StatelessWidget {
  final String playerName;
  final String communityName;
  final String statusMessage;
  final IconData icon; // Changed to IconData for icon
  final Color iconColor; // Changed to Color for icon color

  const PlayerProgressCard({
    super.key,
    required this.playerName,
    required this.communityName,
    required this.statusMessage,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          height: 101,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.circular(16),
            border:
                Border.all(color: const Color.fromRGBO(218, 218, 218, 1), width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: const Color.fromRGBO(226, 226, 226, 1),
                    width: 1,
                  ),
                ),
                child: Image.asset('assets/images/Coach 3.png'),
              ),
              const SizedBox(width: 12),

              // Text Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                playerName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(78, 78, 78, 1),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                communityName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(160, 160, 160, 1),
                                ),
                              ),
                            ],
                          ),

                          // Warning Icon
                          Icon(
                            icon, // Use the icon parameter here
                            color:
                                iconColor, // Use the iconColor parameter here
                            size: 20, // Adjust the size if needed
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        statusMessage,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(78, 78, 78, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }
}
