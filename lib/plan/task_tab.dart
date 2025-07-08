import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/helper/token_helper.dart';

class TaskTab extends StatefulWidget {
  final String? taskDescription;
  final String? practical;
  final int sessionId;

  const TaskTab({
    super.key,
    required this.taskDescription,
    required this.practical,
    required this.sessionId,
  });

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  int selectedFeelingIndex = -1;
  bool isChecked = false;
  bool isCardDisabled = false;
  bool isLoading = false;
  TextEditingController notesController = TextEditingController();

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

  Future<void> sendSessionDone(int sessionId) async {
    final url = Uri.parse(
        'https://calmletics-production.up.railway.app/api/player/done');

    try {
      String? token = await TokenHelper.getToken();

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("no token found")),
        );
        return;
      }

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'session_id': sessionId}),
      );
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['message'] == 'Score saved successfully') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Score saved successfully")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('faild: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('failed in connection: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: isCardDisabled
                  ? const Color.fromARGB(255, 243, 240, 240)
                  : Colors.white,
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
                            widget.taskDescription ?? '',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          ...(widget.practical ?? '')
                              .replaceAll('\\n', '\n')
                              .replaceAll('\n\n', '\n')
                              .split('\n')
                              .map((line) => Text(
                                    line.trim(),
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13,
                                    ),
                                  )),
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
                const Text("How did you feel today?",
                    style: TextStyle(fontWeight: FontWeight.bold)),
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
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color.fromARGB(255, 221, 239, 222)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: isSelected
                                  ? Colors.green
                                  : Colors.transparent),
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
                                color:
                                    isSelected ? kPrimaryColor : Colors.black87,
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
                const Text("Notes",
                    style: TextStyle(fontWeight: FontWeight.bold)),
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
                        hintText: "Write what you feel"),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: isCardDisabled
                        ? null
                        : () {
                            if (!isChecked) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please confirm that you completed the task')),
                              );
                              return;
                            }
                            if (selectedFeelingIndex == -1) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Please select how you felt')),
                              );
                              return;
                            }
                            if (notesController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Please write a your feeling')),
                              );
                              return;
                            }

                            setState(() {
                              isCardDisabled = true;
                              isLoading = true;
                            });

                            sendSessionDone(widget.sessionId);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                    ),
                    child: const Text("Done",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
