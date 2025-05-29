import 'package:flutter/material.dart';
import 'package:sports_mind/constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> weekEmotions = [
    {"day": "Mon", "date": "17", "emotion": "assets/images/very_anxious.png"},
    {"day": "Tue", "date": "18", "emotion": "assets/images/anxious.png"},
    {"day": "Wed", "date": "19", "emotion": "assets/images/tense.png"},
    {"day": "Thu", "date": "20", "emotion": "assets/images/neutral.png"},
    {"day": "Fri", "date": "21", "emotion": "assets/images/slightly_calm.png"},
    {"day": "Sat", "date": "22", "emotion": "assets/images/calm.png"},
  ];

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 20),
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
          const Text("Emotional State",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: weekEmotions.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                bool isSelected = index == 1; // simulate "today"

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? kPrimaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              isSelected ? kPrimaryColor : Colors.grey.shade300,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            weekEmotions[index]['day'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            weekEmotions[index]['date'],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Image.asset(weekEmotions[index]['emotion'], height: 24),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 150,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 70, // تم تقليل الحجم
                            width: 70,
                            child: CircularProgressIndicator(
                              value: 0.6,
                              strokeWidth: 4, // أنحف قليلاً
                              backgroundColor: Colors.grey.shade200,
                              color: kPrimaryColor,
                            ),
                          ),
                          const Text(
                            "60%\nCompleted",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12), // حجم النص مناسب لحجم الدائرة
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "8/28 Days Completed",
                        style: TextStyle(
                            fontSize: 12), // اختياري: ضبط حجم النص السفلي أيضًا
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 150,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Session 2",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("A Quiet Start"),
                          ],
                        ),
                      ),
                      Image.asset("assets/images/Sad Face 1.png", height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Tasks",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const Text("Your task completion progress"),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 0.4,
                  backgroundColor: Colors.grey.shade200,
                  color: kPrimaryColor,
                  minHeight: 6,
                ),
                const SizedBox(height: 4),
                const Text("985 completed     215 remaining"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text.rich(
                TextSpan(
                  text: "Rank\n",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  children: [
                    TextSpan(
                      text: "44/50",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class ChartData {
  final String x;
  final double y;
  ChartData(this.x, this.y);
}
