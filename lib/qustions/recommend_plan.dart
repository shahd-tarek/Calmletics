import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/helper/token_helper.dart';
import 'package:sports_mind/http/api.dart';
import 'package:sports_mind/plan/plan_page.dart';

void showRecommendationDialog(BuildContext context) {
  bool isLoading = false;
  bool isPlanReady = false;
  int? recommendedPlanId;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(20),
              width: 700,
              height: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    child: Image.asset('assets/images/Loading 1.png'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "We're getting your personalized plan ready",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Just tap "Recommendation Plan" to see the plan made for you.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isLoading ? Colors.grey : kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: isLoading
                        ? null
                        : () async {
                            setState(() {
                              isLoading = true;
                            });

                            final prefs =
                                await SharedPreferences.getInstance();

                            if (!isPlanReady) {
                              // First click: call API and get plan
                              recommendedPlanId = await Api()
                                  .forwardRecommendationAnswersToLocalAPI();

                              if (recommendedPlanId != null) {
                                await prefs.setInt("recommended_plan_id",
                                    recommendedPlanId!);

                                setState(() {
                                  isPlanReady = true;
                                  isLoading = false;
                                });
                              } else {
                                setState(() {
                                  isLoading = false;
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        '❌ Failed to get recommendation.'),
                                  ),
                                );
                              }
                            } else {
                              // Second click: submit to external API and go to plan page
                          String? token = await TokenHelper.getToken();

                              if (token == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('❌ Token not found.'),
                                  ),
                                );
                                return;
                              }

                              final response = await http.post(
                                Uri.parse(
                                    'https://calmletics-production.up.railway.app/api/player/recommended'),
                                headers: {
                                  'Authorization': 'Bearer $token',
                                  'Content-Type': 'application/json',
                                },
                                body:
                                    '{"recommended_plan_id": $recommendedPlanId}',
                              );

                              if (response.statusCode == 200) {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PlanPage(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '❌ Failed to submit plan: ${response.statusCode}'),
                                  ),
                                );
                              }

                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              isPlanReady
                                  ? 'View your plan'
                                  : 'Recommend plan',
                              style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
