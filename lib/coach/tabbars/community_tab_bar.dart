import 'package:flutter/material.dart';

class CommunityTabBar extends StatelessWidget {
  final String selectedTab;
  final Function(String) onTabSelected;

  const CommunityTabBar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            spreadRadius: 4,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTabButton('all'),
            _buildTabButton('low'),
            _buildTabButton('intermediate'),
            _buildTabButton('high'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String tabName) {
    bool isSelected = selectedTab.toLowerCase() == tabName.toLowerCase();

    return GestureDetector(
      onTap: () => onTabSelected(tabName),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 8), // Adjusts to text size
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromRGBO(106, 149, 122, 1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          tabName[0].toUpperCase() +
              tabName.substring(1), // Capitalize first letter
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.white : const Color.fromRGBO(176, 176, 176, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
