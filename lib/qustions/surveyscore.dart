import 'package:flutter/material.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/http/api.dart';
import 'package:sports_mind/qustions/finalscore.dart';

class SurveyScoreScreen extends StatefulWidget {
  const SurveyScoreScreen({super.key});

  @override
  _SurveyScoreScreenState createState() => _SurveyScoreScreenState();
}

class _SurveyScoreScreenState extends State<SurveyScoreScreen> {
  Map<int, int> questionScores = {};
  int currentPage = 0;

  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> surveyData = [
    {
      'questions': [
        {
          'question':
              'I am worried I might not perform as well as I can in my next match',
          'options': {
            'Not at all': 1,
            'Somewhat': 2,
            'Neutral/ Uncertain': 3,
            'Moderate': 4,
            'Very much': 5
          }
        },
      ],
    },
    {
      'questions': [
        {
          'question': 'My body feels tense as I think about the game',
          'options': {
            'Not at all': 1,
            'Somewhat': 2,
            'Neutral/ Uncertain': 3,
            'Moderate': 4,
            'Very much': 5
          }
        },
      ],
    },
    {
      'questions': [
        {
          'question': 'I feel confident about my ability to perform.',
          'options': {
            'Not at all': 1,
            'Somewhat': 2,
            'Neutral/ Uncertain': 3,
            'Moderate': 4,
            'Very much': 5
          }
        },
      ],
    },
    {
      'questions': [
        {
          'question': 'I feel calm and secure about my preparation',
          'options': {
            'Not at all': 1,
            'Somewhat': 2,
            'Neutral/ Uncertain': 3,
            'Moderate': 4,
            'Very much': 5
          }
        },
      ],
    },
    {
      'questions': [
        {
          'question':
              'I believe I can handle the challenges of the upcoming match.',
          'options': {
            'Not at all': 1,
            'Somewhat': 2,
            'Neutral/ Uncertain': 3,
            'Moderate': 4,
            'Very much': 5
          }
        },
      ],
    },
    {
      'questions': [
        {
          'question': 'I am worried I might perform poorly in my next match.',
          'options': {
            'Not at all': 1,
            'Somewhat': 2,
            'Neutral/ Uncertain': 3,
            'Moderate': 4,
            'Very much': 5
          }
        },
      ],
    },
    {
      'questions': [
        {
          'question':
              'My heart beats faster when I think about the competition.',
          'options': {
            'Not at all': 1,
            'Somewhat': 2,
            'Neutral/ Uncertain': 3,
            'Moderate': 4,
            'Very much': 5
          }
        },
      ],
    },
    {
      'questions': [
        {
          'question': 'I am confident I can perform at my best.',
          'options': {
            'Not at all': 1,
            'Somewhat': 2,
            'Neutral/ Uncertain': 3,
            'Moderate': 4,
            'Very much': 5
          }
        },
      ],
    },
    {
      'questions': [
        {
          'question': 'I am worried about reaching my sports goal.',
          'options': {
            'Not at all': 1,
            'Somewhat': 2,
            'Neutral/ Uncertain': 3,
            'Moderate': 4,
            'Very much': 5
          }
        },
      ],
    },
    {
      'questions': [
        {
          'question': 'My stomach feels heavy when I think about the match.',
          'options': {
            'Not at all': 1,
            'Somewhat': 2,
            'Neutral/ Uncertain': 3,
            'Moderate': 4,
            'Very much': 5
          }
        },
      ],
    },
    {
      'questions': [
        {
          'question':
              'I am worried that others might be disappointed with how I play.',
          'options': {
            'Not at all': 1,
            'Somewhat': 2,
            'Neutral/ Uncertain': 3,
            'Moderate': 4,
            'Very much': 5
          }
        },
      ],
    },
    {
      'questions': [
        {
          'question':
              'I feel confident because I can imagine myself achieving my goal.',
          'options': {
            'Not at all': 1,
            'Somewhat': 2,
            'Neutral/ Uncertain': 3,
            'Moderate': 4,
            'Very much': 5
          }
        },
      ],
    },
    {
      'questions': [
        {
          'question':
              'I am worried I might not be able to stay focused during the match.',
          'options': {
            'Not at all': 1,
            'Somewhat': 2,
            'Neutral/ Uncertain': 3,
            'Moderate': 4,
            'Very much': 5
          }
        },
      ],
    },
    {
      'questions': [
        {
          'question':
              'My muscles feel tight when I think about the competition.',
          'options': {
            'Not at all': 1,
            'Somewhat': 2,
            'Neutral/ Uncertain': 3,
            'Moderate': 4,
            'Very much': 5
          }
        },
      ],
    },
    {
      'questions': [
        {
          'question':
              'I feel some discomfort in my stomach thinking about the match',
          'options': {
            'Not at all': 1,
            'Somewhat': 2,
            'Neutral/ Uncertain': 3,
            'Moderate': 4,
            'Very much': 5
          }
        },
      ],
    }
  ];

  int calculateTotalScore() {
    int totalScore = 0;
    for (var score in questionScores.values) {
      totalScore += score;
    }
    return totalScore;
  }

  void nextPage() {
    if (currentPage < surveyData.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      int totalScore = calculateTotalScore();
      int maxScore = surveyData.length * 5;
      double percentage = (totalScore / maxScore) * 100;
      
      // Save the score and anxiety level to the database
      final api = Api();
      api.saveScore(percentage.toInt(),).then((success) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Score saved successfully!"),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Failed to save score."),
            ),
          );
        }
      });

      // Navigate to the final result screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnxietyScreen(
            percentage: percentage,
          ),
        ),
      );
    }
  }

  bool areAllQuestionsAnswered(int pageIndex) {
    final questions = surveyData[pageIndex]['questions'];
    for (int i = 0; i < questions.length; i++) {
      if (!questionScores.containsKey(pageIndex * 10 + i)) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        itemCount: surveyData.length,
        itemBuilder: (context, pageIndex) {
          final page = surveyData[pageIndex];
          return buildSurveyPage(page, pageIndex);
        },
      ),
    );
  }

  Widget buildSurveyPage(Map<String, dynamic> page, int pageIndex) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Center(
                    child: Text(
                      "Sport Anxiety Test",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const SizedBox(width: 40),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: 20,
                          width: 250,
                          child: LinearProgressIndicator(
                            value: (pageIndex + 1) / surveyData.length,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                kPrimaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${pageIndex + 1}/${surveyData.length}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.builder(
                      itemCount: page['questions'].length,
                      itemBuilder: (context, questionIndex) {
                        final question = page['questions'][questionIndex];
                        return buildQuestion(
                            question, pageIndex * 10 + questionIndex);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (pageIndex == surveyData.length - 1)
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: ElevatedButton(
              onPressed: areAllQuestionsAnswered(pageIndex) ? nextPage : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: areAllQuestionsAnswered(pageIndex)
                    ? kPrimaryColor
                    : Colors.green.withOpacity(0.5),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Complete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  Widget buildQuestion(Map<String, dynamic> question, int questionId) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        width: 300,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Colors.grey, width: 1),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question['question'],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                ...question['options'].entries.map<Widget>((entry) {
                  final optionText = entry.key;
                  final optionValue = entry.value;
                  final isSelected = questionScores[questionId] == optionValue;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          questionScores[questionId] = optionValue;
                        });
                        if (areAllQuestionsAnswered(currentPage)) {
                          nextPage();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected
                            ? const Color.fromRGBO(215, 244, 212, 1)
                            : Colors.white,
                        foregroundColor:
                            isSelected ? Colors.black : Colors.grey,
                        minimumSize: const Size(double.infinity, 50),
                        elevation: isSelected ? 2 : 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color:
                                isSelected ? Colors.transparent : Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          optionText,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
