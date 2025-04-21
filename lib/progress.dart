import 'package:flutter/material.dart';
import 'package:sports_mind/constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  String selectedTab = "Week"; // Default selected tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        title: const Text("Progress",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toggle Tabs (Week, Month, Year)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ["Week", "Month", "Year"].map((tab) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTab = tab;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color:
                            selectedTab == tab ? kPrimaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Center(
                        child: Text(
                          tab,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedTab == tab
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Productivity Chart
            const Text("Your Productivity",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: SfCartesianChart(
                primaryXAxis: const CategoryAxis(),
                primaryYAxis: const NumericAxis(isVisible: false),
                series: <CartesianSeries>[
                  SplineAreaSeries<ChartData, String>(
                    dataSource: [
                      ChartData('4 April', 3),
                      ChartData('5 April', 2),
                      ChartData('6 April', 2.5),
                      ChartData('7 April', 4),
                      ChartData('8 April', 3),
                      ChartData('9 April', 3.5),
                      ChartData('Today', 4.5),
                    ],
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.withOpacity(0.5),
                        Colors.green.withOpacity(0.1)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderWidth: 3,
                    borderColor: Colors.green.shade700,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Progress & Relaxation Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 170,
                  height: 200,
                  child: _progressCard(
                      percentage: 60, text: "8/28 Days Completed"),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 170,
                  height: 200,
                  child: _infoCard("Relaxation mastery this week",
                      "assets/images/Sad Face 1.png"),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Task Summary
            _taskSummary(),

            const SizedBox(height: 20),

            // Mood Selection
            const Text("How did you feel this week?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ["very sad", "sad", "good", "very good"].map((mood) {
                return Column(
                  children: [
                    Icon(
                      mood == "very sad"
                          ? Icons.sentiment_very_dissatisfied
                          : mood == "sad"
                              ? Icons.sentiment_dissatisfied
                              : mood == "good"
                                  ? Icons.sentiment_satisfied
                                  : Icons.sentiment_very_satisfied,
                      color: mood == "good" ? Colors.green : Colors.grey,
                      size: 32,
                    ),
                    Text(mood, style: const TextStyle(fontSize: 12)),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Community Section
            const Text("Community",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                
                  child: _communityCard("3/4 VR sessions attended this week"),
                ),
                const SizedBox(width: 10),
                SizedBox(
                 
                  child: _communityCard(
                      "You're 8 out of 20 players in the community!"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Circular Progress Indicator Card
  Widget _progressCard({required int percentage, required String text}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey.shade200,
            color: Colors.green,
          ),
          const SizedBox(height: 20),
          Text(text, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  // Info Card
  Widget _infoCard(String title, String asset) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Image.asset(
            asset,
            height: 90,
            width: 70,
          ),
          const SizedBox(height: 10),
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Task Summary Card
  Widget _taskSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Week 1", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(
              "Relaxation and Stress Reduction \nYou completed 2/5 tasks this week!"),
        ],
      ),
    );
  }

  // Community Card
  Widget _communityCard(String text) {
    return Container(
      width: 170,
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.green.shade200,
          borderRadius: BorderRadius.circular(16)),
      child: Text(text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

class ChartData {
  final String x;
  final double y;
  ChartData(this.x, this.y);
}
