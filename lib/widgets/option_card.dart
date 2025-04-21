import 'package:flutter/material.dart';

Widget buildOptionCard(String text, VoidCallback onPressed) {
  return Container(
    width: double.infinity,
    height: 72,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Colors.grey,
        width: 1,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(78, 78, 78, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.white,
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              const Color.fromRGBO(106, 149, 122, 1),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            minimumSize: WidgetStateProperty.all(const Size(24, 24)),
          ),
        ),
      ],
    ),
  );
}
