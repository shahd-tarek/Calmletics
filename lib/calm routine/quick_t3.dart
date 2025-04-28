import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/calm%20routine/audio_place.dart';

class QuickTaskThree extends StatefulWidget {
  final int pageIndex;
  final int totalPages;

  const QuickTaskThree({
    super.key,
    required this.pageIndex,
    required this.totalPages,
  });

  @override
  State<QuickTaskThree> createState() => _QuickTaskThreeState();
}

class _QuickTaskThreeState extends State<QuickTaskThree> {
  int? selectedPlaceIndex;
  int? selectedAudioIndex;

  final List<String> placeImages = [
    'assets/images/beach.png',
    'assets/images/mountain.png',
    'assets/images/stadium.png',
  ];

  final List<String> placeSceneImages = [
    'assets/images/Component 5.png',
    'assets/images/Component 6.png',
    'assets/images/Component 7.png',
  ];

  final List<String> audioImages = [
    'assets/images/cloud.png',
    'assets/images/tree.png',
  ];

  Future<void> _goToAudioScreen() async {
    if (selectedPlaceIndex == null || selectedAudioIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a place and audio.')),
      );
      return;
    }

    final selectedNumber = (selectedAudioIndex! + 1).toString(); // "1" or "2"
    final url = Uri.parse(
        'https://calmletics-production.up.railway.app/api/file/get-recording');

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null || token.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in again.')),
        );
        Navigator.pushReplacementNamed(context, '/login');
        return;
      }

      print('🔢 Selected number: $selectedNumber');
      print('🔑 Token: $token');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $token', // Try 'Token $token' if Bearer fails
        },
        body: jsonEncode({'file': selectedNumber}),
      );

      print('🔄 Status Code: ${response.statusCode}');
      print('📄 Response: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final audioUrl = responseData['rec$selectedNumber'];

        if (audioUrl == null || audioUrl.isEmpty) {
          throw Exception('Audio URL missing in response');
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AudioInPlace(
              imagePath: placeSceneImages[selectedPlaceIndex!],
              audioUrl: audioUrl,
              pageIndex: widget.pageIndex,
              totalPages: widget.totalPages,
            ),
          ),
        );
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Session expired. Please log in again.')),
        );
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 240, 240),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color.fromARGB(255, 243, 240, 240),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgcolor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 20,
                            width: 250,
                            child: LinearProgressIndicator(
                              value: (widget.pageIndex + 1) / widget.totalPages,
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  kPrimaryColor),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${widget.pageIndex + 1}/${widget.totalPages}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Switch Off Your Mind for a Minute',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'If you need to calm down quickly and escape\noverthinking, try this exercise for just two\nminutes.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: 361,
                      height: 49,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: const Center(
                        child: Text(
                          'Find a quiet spot and close your eyes.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(78, 78, 78, 1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 361,
                      height: 125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text(
                              'Imagine yourself in a place you love',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(78, 78, 78, 1),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  List.generate(placeImages.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedPlaceIndex = index;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: selectedPlaceIndex == index
                                                  ? kPrimaryColor
                                                  : Colors.transparent,
                                              width: 2,
                                            ),
                                          ),
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage:
                                                AssetImage(placeImages[index]),
                                          ),
                                        ),
                                        if (selectedPlaceIndex == index)
                                          const Positioned(
                                            top: 0,
                                            right: 0,
                                            child: CircleAvatar(
                                              radius: 12,
                                              backgroundColor: kPrimaryColor,
                                              child: Icon(
                                                Icons.check,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 361,
                      height: 125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text(
                              'Imagine yourself in an audio you love',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(78, 78, 78, 1),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  List.generate(audioImages.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedAudioIndex = index;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: selectedAudioIndex == index
                                                  ? kPrimaryColor
                                                  : Colors.transparent,
                                              width: 2,
                                            ),
                                          ),
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage:
                                                AssetImage(audioImages[index]),
                                          ),
                                        ),
                                        if (selectedAudioIndex == index)
                                          const Positioned(
                                            top: 0,
                                            right: 0,
                                            child: CircleAvatar(
                                              radius: 12,
                                              backgroundColor: kPrimaryColor,
                                              child: Icon(
                                                Icons.check,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 361,
                      height: 62,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Focus on your breathing and allow yourself to relax.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(78, 78, 78, 1),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color:bgcolor,
            child: Center(
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _goToAudioScreen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Start Now',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
