import 'package:flutter/material.dart';

class TopThreeUsers extends StatelessWidget {
  final List<Map<String, dynamic>> topUsers;

  const TopThreeUsers({
    super.key,
    required this.topUsers,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildUserColumn(topUsers[0], '2', 'assets/images/2.png'),
        _buildUserColumn(topUsers[1], '1', 'assets/images/1.png'),
        _buildUserColumn(topUsers[2], '3', 'assets/images/3.png'),
      ],
    );
  }

  Widget _buildUserColumn(
      Map<String, dynamic> user, String rank, String image) {
    double topPadding = 0; // Default padding

    // Adjust padding based on rank
    if (rank == '2') {
      topPadding = 20; // Small distance below 1
    } else if (rank == '3') {
      topPadding = 50; // Big distance below 1
    }

    return Column(
      children: [
        SizedBox(height: topPadding), // Add padding based on rank
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey,
          backgroundImage: AssetImage(user['imagePath']),
        ),
        const SizedBox(height: 10),
        Text(
          user['name'],
          style: const TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(0, 0, 0, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 55,
          height: 27,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(233, 239, 235, 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              user['points'].toString(),
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(106, 149, 122, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              image,
              width: rank == '1' ? 108 : 127,
              height: rank == '1' ? 137 : 102,
            ),
            Text(
              rank,
              style: TextStyle(
                fontSize: rank == '1' ? 128 : 96,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}