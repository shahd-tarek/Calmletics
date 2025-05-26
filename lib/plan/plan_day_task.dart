import 'package:flutter/material.dart';
import 'package:sports_mind/community/coachCommunity/book-vr.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/http/api.dart';
import 'package:sports_mind/plan%20widgets/audio_plan.dart';
import 'package:sports_mind/plan%20widgets/text_plan.dart';
import 'package:sports_mind/plan%20widgets/video_plan.dart';
import 'package:sports_mind/plan/task_tab.dart';

class PlanDayTask extends StatefulWidget {
  final int sessionId;
  final String sessionName;
  final String sessionNumber;
  final String status;
  final int sessionType;

  const PlanDayTask({
    super.key,
    required this.sessionId,
    required this.sessionName,
    required this.sessionNumber,
    required this.status,
    required this.sessionType,
  });

  @override
  State<PlanDayTask> createState() => _PlanDayTaskState();
}

class _PlanDayTaskState extends State<PlanDayTask>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<Map<String, dynamic>> _sessionContentFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _sessionContentFuture = Api().fetchSessionContent(widget.sessionId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _sessionContentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final data = snapshot.data!;
          final content = data['content'];
          final task = data['task'];
          final practical = data['practical'];

          return Column(
            children: [
              Center(
                child: Container(
                  height: 120,
                  width: 380,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    widget.status,
                                    width: 24,
                                    height: 24,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.broken_image,
                                                size: 24),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    widget.sessionNumber,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 127, 124, 124)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(widget.sessionName,
                                  style: const TextStyle(fontSize: 18)),
                            ],
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        child: Image.asset(
                          'assets/images/img-week1.png',
                          width: 100,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: kPrimaryColor,
                        tabs: const [
                          Tab(text: 'Session'),
                          Tab(text: 'Task'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _SessionTab(
                              content: content,
                              sessionType: widget.sessionType,
                               sessionId: widget.sessionId,
                            ),
                            TaskTab(
                                taskDescription: task, practical: practical,sessionId: widget.sessionId,),
                              
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SessionTab extends StatelessWidget {
  final String content;
  final int sessionType;
    final int sessionId;

  const _SessionTab({required this.content, required this.sessionType,required this.sessionId});

  @override
  Widget build(BuildContext context) {
    String contentType =
        content.split('.').last.toLowerCase(); 
    Widget contentWidget;

    if (contentType == 'mp4') {
      contentWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: VideoPlayerWidget(url: content),
          ),
          if (sessionType == 1) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to phone test
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.grey),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('On Your Phone'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookVRSessionPage(
                                 sessionId: sessionId,
                                )));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Book VR session'),
                ),
              ],
            ),
          ]
        ],
      );
    } else if (contentType == 'mp3') {
      // صوت
      contentWidget = SizedBox(
        height: 50,
        child: AudioPlayerWidget(url: content),
      );
    } else if (contentType == 'txt') {
      // PDF
      contentWidget = TextViewerWidget(url: content);
    } else {
      contentWidget = const Text('Unsupported content type');
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          contentWidget,
        ],
      ),
    );
  }
}