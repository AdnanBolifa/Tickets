class CommentData {
  final int? ticket;
  final String? comment;
  final String? createdAt;

  CommentData({
    required this.ticket,
    required this.comment,
    required this.createdAt,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
      ticket: json['ticket'],
      comment: json['comment'],
      createdAt: json['created_at'],
    );
  }
}
