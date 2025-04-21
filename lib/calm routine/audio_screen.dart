import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:just_audio/just_audio.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/views/main_screen.dart';
import 'package:sports_mind/widgets/custom_button.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

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

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _fetchAudioUrl();
  }

  Future<void> _fetchAudioUrl() async {
    final response = await http
        .get(Uri.parse("https://your-api.com/audio")); 

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        audioUrl = data['audio_url']; 
        isLoading = false;
      });
      _loadAudio();
    } else {
      // error handling
      print("Failed to load audio URL");
      setState(() {
        isLoading = false;
      });
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
      backgroundColor: bgcolor,
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                margin: const EdgeInsets.only(top: 35),
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    // Top bar
                    Row(
                      children: [
                        const Icon(Icons.arrow_back),
                        const SizedBox(width: 10),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 1.0,
                            backgroundColor: Colors.grey[300],
                            color: kPrimaryColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text("4/4"),
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
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      "Visualize Success",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

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
                    const SizedBox(height: 10),

                    // Done Button
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: CustomButton(
                          text: "Done",
                          ontap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainScreen()),
                            );
                          },
                        ))
                  ],
                ),
              ),
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
