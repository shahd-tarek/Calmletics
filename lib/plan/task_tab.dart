import 'package:flutter/material.dart';
import 'package:sports_mind/constant.dart';

class TaskTab extends StatefulWidget {
  final String? taskDescription;
  final String? practical;

  const TaskTab({
    super.key,
    required this.taskDescription,
    required this.practical,
  });

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  int selectedFeelingIndex = -1; 
  bool isChecked = false;
  bool isCardDisabled = false; 
  final List<Map<String, dynamic>> feelings = [
    {"image": "assets/images/very_anxious.png", "text": "Very anxious"},
    {"image": "assets/images/anxious.png", "text": "Anxious"},
    {"image": "assets/images/tense.png", "text": "A bit tense"},
    {"image": "assets/images/neutral.png", "text": "Neutral"},
    {"image": "assets/images/slightly_calm.png", "text": "Slightly calm"},
    {"image": "assets/images/calm.png", "text": "Calm"},
    {"image": "assets/images/feeling_good.png", "text": "Feeling good"},
    {"image": "assets/images/very_relaxed.png", "text": "Very relaxed"},
    {"image": "assets/images/peaceful.png", "text": "Peaceful&happy"},
    {"image": "assets/images/super_relaxed.png", "text": "Super relaxed"},
  ];

  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: isCardDisabled ? const Color.fromARGB(255, 243, 240, 240) : Colors.white, // لون الكارد يتغير
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                        // تحقق من إذا تم تحديد الـ Checkbox و اختيار الإيموشن و كتابة ملاحظة
                        isCardDisabled = isChecked &&
                            selectedFeelingIndex != -1 &&
                            notesController.text.isNotEmpty;
                      });
                    },
                    activeColor: kPrimaryColor,
                    shape: const CircleBorder(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.taskDescription!,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.practical!,
                        style: const TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.repeat_rounded, color: kPrimaryColor),
                          Text("3 Times", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text("How did you feel today?", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: feelings.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.6,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final isSelected = selectedFeelingIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFeelingIndex = index;
                      // تحقق من إذا تم اختيار الإيموشن و الـ Checkbox و كتابة ملاحظة
                      isCardDisabled = isChecked &&
                          selectedFeelingIndex != -1 &&
                          notesController.text.isNotEmpty;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? const Color.fromARGB(255, 221, 239, 222) : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: isSelected ? Colors.green : Colors.transparent),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          feelings[index]["image"],
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          feelings[index]["text"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: isSelected ? kPrimaryColor : Colors.black87,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text("Notes", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: notesController,
                maxLines: 5,
                decoration: const InputDecoration.collapsed(hintText: "Write what you feel"),
                onChanged: (value) {
                  setState(() {
                    // تحقق من إذا تم كتابة الملاحظة و الـ Checkbox و اختيار الإيموشن
                    isCardDisabled = isChecked &&
                        selectedFeelingIndex != -1 &&
                        notesController.text.isNotEmpty;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}







/*
class TaskTab extends StatefulWidget {
  const TaskTab({super.key});

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  int selectedFeelingIndex = 1; // Default: Anxious
  final List<Map<String, dynamic>> feelings = [
    {"icon": Icons.sentiment_very_dissatisfied, "text": "Very anxious"},
    {"icon": Icons.sentiment_dissatisfied, "text": "Anxious"},
    {"icon": Icons.sentiment_dissatisfied_outlined, "text": "A bit tense"},
    {"icon": Icons.sentiment_neutral, "text": "neutral"},
    {"icon": Icons.sentiment_satisfied_alt, "text": "Slightly calm"},
    {"icon": Icons.sentiment_satisfied, "text": "Calm"},
    {"icon": Icons.sentiment_satisfied_sharp, "text": "Feeling good"},
    {"icon": Icons.self_improvement, "text": "Very relaxed"},
    {"icon": Icons.sentiment_very_satisfied, "text": "Peaceful & happy"},
    {"icon": Icons.spa, "text": "Super relaxed"},
  ];

  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Title & Description
            const Row(
              children: [
                Icon(Icons.radio_button_unchecked, color: Colors.green),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Practice box breathing",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "This technique helps reset your nervous system, reduces stress",
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 12),

            // Repeat count
            const Row(
              children: [
                Icon(Icons.refresh, size: 16, color: Colors.grey),
                SizedBox(width: 6),
                Text("3 Times", style: TextStyle(color: Colors.black54)),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              "How did you feel this today?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Feelings grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: feelings.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final isSelected = selectedFeelingIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFeelingIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.green.shade100
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.transparent,
                      ),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          feelings[index]["icon"],
                          color: const Color.fromARGB(255, 77, 205, 79), // اللون الأخضر للأيقونة
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          feelings[index]["text"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            color: isSelected ? kPrimaryColor : Colors.black87,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            const Text("Notes", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: notesController,
                maxLines: 5,
                decoration: const InputDecoration.collapsed(
                  hintText: "Write what you feel",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/