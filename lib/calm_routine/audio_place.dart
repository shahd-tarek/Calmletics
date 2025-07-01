import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/calm_routine/audio_screen.dart';

class AudioInPlace extends StatefulWidget {
  final String imagePath;
  final String audioUrl; 
  final int pageIndex;
  final int totalPages;

  const AudioInPlace({
    super.key,
    required this.imagePath,
    required this.audioUrl,
    required this.pageIndex,
    required this.totalPages,
  });

  @override
  State<AudioInPlace> createState() => _AudioInPlaceState();
}

class _AudioInPlaceState extends State<AudioInPlace> with SingleTickerProviderStateMixin {
  Duration remainingTime = const Duration(minutes: 1);
  Timer? timer;
  bool isButtonEnabled = false;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    startAudio();
    startCountdown();
  }

  Future<void> startAudio() async {
    try {
      await _audioPlayer.setUrl(widget.audioUrl);
      _audioPlayer.play();
    } catch (e) {
      print('Error loading audio: $e');
    }
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (remainingTime.inSeconds > 0) {
        setState(() {
          remainingTime -= const Duration(seconds: 1);
        });
      } else {
        // عند انتهاء التايمر
        timer?.cancel();
        _audioPlayer.stop(); // <-- إيقاف الصوت
        setState(() {
          isButtonEnabled = true;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    _audioPlayer.dispose(); // <-- مهم جداً توقف الصوت لما تخرج
    super.dispose();
  }

  String formatTime(Duration d) {
    return "${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";
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
                              valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor),
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
                      width: double.infinity,
                      height: 450,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.imagePath),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Center(
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              formatTime(remainingTime),
                              style: const TextStyle(
                                fontSize: 48,
                                color: Color(0xFF56805C),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
            color: bgcolor,
            child: Center(
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AudioPlayerScreen(
                                pageIndex: widget.pageIndex + 1,
                                totalPages: widget.totalPages,
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 20, color: Colors.white),
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
