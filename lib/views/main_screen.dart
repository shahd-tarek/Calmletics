import 'package:flutter/material.dart';
import 'package:sports_mind/chatbot/start-chatbot.dart';
import 'package:sports_mind/community/community.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/coach/payment.dart';
import 'package:sports_mind/progress.dart';
import 'package:sports_mind/views/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const PaymentPage(),
    const ProgressPage(),
    const Community(),
  ];

  void _goToChatBot(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StartChatbot()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToChatBot(context),
        backgroundColor: kPrimaryColor,
        tooltip: 'Chat Bot',
        child: const Icon(Icons.chat, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  navBarItem(Icons.home_rounded, 'Home', 0),
                  navBarItem(Icons.event_available_rounded, 'Plan', 1),
                ],
              ),
              const SizedBox(width: 48),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  navBarItem(Icons.show_chart_rounded, 'Progress', 2),
                  navBarItem(Icons.group_rounded, 'Community', 3),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navBarItem(IconData icon, String label, int index) {
    return MaterialButton(
      minWidth: 40,
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _currentIndex == index ? kPrimaryColor : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: _currentIndex == index ? kPrimaryColor : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
