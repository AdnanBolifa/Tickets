import 'package:jwt_auth/data/comment_config.dart';

class Report {
  final int id;
  final String userName;
  final String mobile;
  final String? acc;
  final String? sector;
  final String? place;
  final String? createdAt;
  final String? lastComment;
  final List<CommentData>? comments;

  Report(
      {required this.userName,
      required this.mobile,
      this.acc,
      this.sector,
      this.place,
      required this.id,
      this.createdAt,
      this.lastComment,
      this.comments});

  factory Report.fromJson(Map<String, dynamic> json) {
    // Parse the comments list
    final List<CommentData> commentsList = [];
    final commentsJson = json['comments'];
    if (commentsJson is List) {
      commentsList.addAll(commentsJson
          .map((comment) =>
              comment != null ? CommentData.fromJson(comment) : null)
          .where((comment) => comment != null)
          .cast<CommentData>());
    }

    return Report(
      id: json['id'] as int,
      userName: json['name'],
      mobile: json['phone'],
      acc: json['account'],
      sector: json['sector'],
      place: json['place'],
      createdAt: json['created_at'],
      lastComment:
          json['last_comment'] != null ? json['last_comment']['comment'] : '',
      comments: commentsList,
    );
  }
}
