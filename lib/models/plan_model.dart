class Session {
  final int sessionId;
  final String sessionName;
  final String sessionNumber;
  final String status;

  Session({
    required this.sessionId,
    required this.sessionName,
    required this.sessionNumber,
    required this.status,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      sessionId: json['session_id'],
      sessionName: json['session_name'],
      sessionNumber: json['session_number'],
      status: json['status'],
    );
  }
}
