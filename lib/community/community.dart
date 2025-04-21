import 'package:flutter/material.dart';
import 'package:sports_mind/community/coachCommunity/join_community.dart';
import 'package:sports_mind/community/freeCommunity/free_community.dart';
import 'package:sports_mind/http/api.dart';
import 'package:sports_mind/widgets/community_card.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final Api api = Api();
  bool isLoading = false;
  bool isJoined = false;
  Map<String, dynamic>? communityData;

  @override
  void initState() {
    super.initState();
    fetchCommunityData(); // Fetch community data on initialization
  }

  /// Fetches community data from API
  void fetchCommunityData() async {
    setState(() {
      isLoading = true;
    });

    var data = await api.getCommunityData();

    setState(() {
      isLoading = false;
      communityData = data is Map<String, dynamic> ? data : null;
    });

    if (data == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load community data.")),
      );
    }
  }

  /// Handles joining the free community
  void handleJoinCommunity() async {
    setState(() {
      isLoading = true;
    });

    bool success = await api.joinFreeCommunity();

    setState(() {
      isLoading = false;
      isJoined = success;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success
            ? "Successfully joined Free Community! 🎉"
            : "Failed to join Free Community."),
      ),
    );

    if (success) {
      fetchCommunityData(); // Refresh community data after joining
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 252, 249, 1),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Container(
            width: double.infinity,
            height: 280,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Image.asset(
              'assets/images/Team spirit-cuate 1.png',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CommunityCard(
                            title: 'Free community',
                            description:
                                'Join a supportive community of individuals\nsharing the same goals. Work together without\nneeding a coach',
                            features: const [
                              'Group discussions.',
                              'Peer support.',
                              'Challenges.',
                              'Leaderboards.',
                              'Chating.',
                            ],
                            onPressed: () {
                              handleJoinCommunity();
                              fetchCommunityData();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const freeCommunity()),
                              );
                            },
                          ),
                          const SizedBox(width: 30),
                          CommunityCard(
                            title: 'Coach community',
                            description:
                                'Join a supportive community of individuals\nsharing the same goals. Work together without\nneeding a coach',
                            features: const [
                              'One-on-one coaching.',
                              'VR sessions.',
                              'Challenges.',
                              'Leaderboards.',
                              'Chating.',
                            ],
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const JoinCommunity()),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
