import 'package:flutter/material.dart';
import 'package:sports_mind/constant.dart';
Widget buildCard({
  required String title,
  required String description,
  required String image,
   required Widget navigateTo,
 required BuildContext context,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => navigateTo,
        ),
      );
    },
    child: Container(
      width: 300,
      height: 180,
      padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textcolor
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            image,
            height: 190,
            width: 190,
          ),
        ],
      ),
    ),
  );
}
