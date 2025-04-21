import 'package:flutter/material.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/http/api.dart';
import 'package:sports_mind/qustions/surveyscore.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AnxietyScreen extends StatefulWidget {
  final double percentage;

  const AnxietyScreen({super.key, required this.percentage});

  @override
  State<AnxietyScreen> createState() => _AnxietyScreenState();
}

class _AnxietyScreenState extends State<AnxietyScreen> {
  Future<void> fetchAndSendCluster() async {
    try {
      Api api = Api();
      print("Fetching user answers...");

      // Step 1: Get user answers
      Map<String, dynamic>? answers = await api.getUserAnswers();

      if (answers != null) {
        print("✅ User Answers Retrieved:");
        answers.forEach((key, value) {
          print("$key: $value");
        });

        // Step 2: Send answers to AI API
        print("Sending answers to AI API...");
        Map<String, dynamic>? aiResponse = await api.sendAnswersToAI(answers);

        if (aiResponse != null) {
          print("✅ AI API Response:");
          aiResponse.forEach((key, value) {
            print("$key: $value");
          });

          // Step 3: Extract cluster number
          if (aiResponse.containsKey("cluster")) {
            int clusterNumber = aiResponse["cluster"];
            print("🎯 Cluster Number: $clusterNumber");

            // Step 4: Send the cluster number to `player/cluster` API
            bool clusterSent = await api.sendClusterNumber(clusterNumber);

            if (clusterSent) {
              print("✅ Cluster number sent successfully!");
            } else {
              print("❌ Failed to send cluster number.");
            }
          } else {
            print("❌ Cluster number not found in AI API response.");
          }
        } else {
          print("❌ Failed to get response from AI API.");
        }
      } else {
        print("❌ Failed to load answers.");
      }
    } catch (e) {
      print("⚠️ Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    const Text(
                      "Your Anxiety Level",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildAnxietyGauge(),
                    const Text(
                      "What your score means",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "It seems you're facing some challenges. Don't\nworry we've prepared a plan to help.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildResultsCard(),
                  ],
                ),
              ),
            ),
          ),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildAnxietyGauge() {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          startAngle: 180,
          endAngle: 0,
          showTicks: false,
          showLabels: false,
          radiusFactor: 0.8,
          axisLineStyle: AxisLineStyle(
            thickness: 0.15,
            thicknessUnit: GaugeSizeUnit.factor,
            cornerStyle: CornerStyle.bothFlat,
            color: Colors.grey[200],
          ),
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 33,
              color: const Color.fromRGBO(164, 206, 78, 1),
              startWidth: 50,
              endWidth: 50,
            ),
            GaugeRange(
              startValue: 33,
              endValue: 66,
              color: const Color.fromRGBO(241, 221, 36, 1),
              startWidth: 50,
              endWidth: 50,
            ),
            GaugeRange(
              startValue: 66,
              endValue: 100,
              color: const Color.fromRGBO(238, 86, 36, 1),
              startWidth: 50,
              endWidth: 50,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: widget.percentage,
              needleLength: 0.6,
              enableAnimation: true,
              animationType: AnimationType.easeOutBack,
              needleColor: Colors.black,
              knobStyle: const KnobStyle(
                knobRadius: 0.06,
                sizeUnit: GaugeSizeUnit.factor,
                color: Colors.black,
              ),
            )
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${widget.percentage.toInt()}%",
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    _getAnxietyStatus(),
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              angle: 90,
              positionFactor: 0.5,
            ),
          ],
        ),
      ],
    );
  }

// anxiety level
  String _getAnxietyStatus() {
    if (widget.percentage <= 33) {
      return "Low";
    } else if (widget.percentage <= 66) {
      return "Moderate";
    } else {
      return "High";
    }
  }

// build card
  Widget _buildResultsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 10,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
          ),
          //card contain
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildScoreRow(
                    "Physical Symptoms", _getPercentage(widget.percentage, 75)),
                const Divider(),
                _buildScoreRow("Performance Worries",
                    _getPercentage(widget.percentage - 10, 75)),
                const Divider(),
                _buildScoreRow("Confidence Level",
                    _getPercentage(widget.percentage - 20, 75)),
              ],
            ),
          ),
        ],
      ),
    );
  }

// caculate percentage
  String _getPercentage(double score, double maxScore) {
    double percentage = (score / maxScore) * 100;
    return "${percentage.toStringAsFixed(1)}%";
  }

  Widget _buildScoreRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //   retest button
          SizedBox(
            width: 167,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SurveyScoreScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                    color: Color.fromRGBO(106, 149, 122, 1),
                    width: 1,
                  ),
                ),
              ),
              child: const Text(
                "ReTest",
                style: TextStyle(
                  color: Color.fromRGBO(106, 149, 122, 1),
                  fontSize: 20,
                ),
              ),
            ),
          ),
          // next step
          SizedBox(
            width: 167,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                fetchAndSendCluster();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(106, 149, 122, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Next Steps",
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
