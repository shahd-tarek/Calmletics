import 'package:flutter/material.dart';
import 'package:sports_mind/calm%20routine/box_breathing.dart';
import 'package:sports_mind/constant.dart';

class QuickTaskOne extends StatefulWidget {
  final int pageIndex;
  final int totalPages;

  const QuickTaskOne({super.key, 
    required this.pageIndex,
    required this.totalPages,
  });

  @override
  State<QuickTaskOne> createState() => _QuickTaskOneState();
}

class _QuickTaskOneState extends State<QuickTaskOne> {
  final List<Map<String, String>> tips = [
    {
      'image': 'assets/images/img-card1.png',
      'text': 'Stay focused on the game itself, not the result.',
    },
    {
      'image': 'assets/images/img-card2.png',
      'text':
          "Remember that you're ready and well trained — this is your time to show your work.",
    },
    {
      'image': 'assets/images/img-card3.png',
      'text':
          "Anxiety isn't a weakness. It's a sign that you care. What matters is how you handle it.",
    },
    {
      'image': 'assets/images/img-card4.png',
      'text':
          'Smile, even if you have to force it — a smile calms both the body and the mind.',
    },
    {
      'image': 'assets/images/img-card5.png',
      'text':
          'Every time you think of something negative, replace it with a positive phrase:',
    },
    {
      'image': 'assets/images/img-card6.png',
      'text': 'Always remember: playing is joy, not pressure.',
    }
  ];

  int currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.85);

  @override
  void dispose() {
    _pageController.dispose();
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const Center(
                      child: Text(
                        'Quick Tips Before the Match',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // PageView for tips
                    SizedBox(
                      height: 450,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: tips.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          final tip = tips[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  tip['image']!,
                                  height: 275,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 12),
                                if (index == 4)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        tip['text']!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      const Row(
                                        children: [
                                          Wrap(
                                            alignment: WrapAlignment.center,
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: [
                                              PositivePhraseChip(
                                                  text: 'I’m ready'),
                                              PositivePhraseChip(
                                                  text: 'I’m capable'),
                                              PositivePhraseChip(
                                                  text: 'I’ll do my best'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                else
                                  Text(
                                    tip['text']!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade800,
                                       fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Indicator Dots
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(tips.length, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == index
                                  ? kPrimaryColor
                                  : Colors.grey.shade300,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Continue button
          Container(
            padding: const EdgeInsets.all(16),
            color: bgcolor,
            child: Center(
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BoxBreathingScreen(
                          pageIndex: widget.pageIndex + 1,
                          totalPages: widget.totalPages,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(255, 255, 255, 1),
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
}

// Custom widget for positive phrases
class PositivePhraseChip extends StatelessWidget {
  final String text;

  const PositivePhraseChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(222, 247, 227, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF4B9F72),
          fontSize: 13,
        ),
      ),
    );
  }
}
