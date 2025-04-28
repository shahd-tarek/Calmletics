import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/views/main_screen.dart';

class AudioPlayerScreen extends StatefulWidget {
  final int pageIndex;
  final int totalPages;

  const AudioPlayerScreen({
    super.key,
    required this.pageIndex,
    required this.totalPages,
  });

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _player;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool isPlaying = false;
  bool isLoading = true;
  String? audioUrl;
  bool isAudioFinished = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _fetchAudioUrl();
  }

  Future<void> _fetchAudioUrl() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("user_token");

    print("Token: $token");

    final response = await http.post(
      Uri.parse(
          "https://calmletics-production.up.railway.app/api/file/upload/rec3"),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        audioUrl = data['rec3'];
        isLoading = false;
      });

      print("Audio URL: $audioUrl");

      if (audioUrl == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load audio.')),
        );
      } else {
        _loadAudio();
      }
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error loading audio URL.')),
      );
    }
  }

  Future<void> _loadAudio() async {
    if (audioUrl == null) return;

    await _player.setUrl(audioUrl!);

    _player.durationStream.listen((d) {
      setState(() {
        _duration = d ?? Duration.zero;
      });
    });

    _player.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
    });

    _player.playerStateStream.listen((state) {
      setState(() {
        isPlaying = state.playing;
        if (state.processingState == ProcessingState.completed) {
          isAudioFinished = true;
        }
      });
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
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
                    // Progress bar
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
                    const SizedBox(height: 20),

                    // Text
                    const Text(
                      "Take a moment to imagine yourself succeeding",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/audio.png',
                        height: 380,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      "Visualize Success",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    // Progress
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatDuration(_position)),
                        Expanded(
                          child: Slider(
                            min: 0,
                            max: _duration.inSeconds.toDouble(),
                            value: _position.inSeconds
                                .clamp(0, _duration.inSeconds)
                                .toDouble(),
                            onChanged: (value) {
                              _player.seek(Duration(seconds: value.toInt()));
                            },
                            activeColor: kPrimaryColor,
                            inactiveColor: Colors.grey[300],
                          ),
                        ),
                        Text(_formatDuration(_duration)),
                      ],
                    ),

                    // Play button
                    IconButton(
                      iconSize: 50,
                      icon: Icon(
                        isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                        color: kPrimaryColor,
                      ),
                      onPressed: () {
                        if (isPlaying) {
                          _player.pause();
                        } else {
                          _player.play();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Done Button
        
Container(
  padding: const EdgeInsets.all(16),
  color: bgcolor,
  child: Center(
    child: SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isAudioFinished ? kPrimaryColor : Colors.grey, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: isAudioFinished
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MainScreen()),
                );
              }
            : null, 
        child: const Text(
          "Done",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ),
  ),
),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
