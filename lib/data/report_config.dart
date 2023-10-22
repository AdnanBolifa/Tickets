class Report {
  final int? id;
  final String userName;
  final String mobile;
  final String? acc;
  final String? sector;
  final String? place;
  final String? createdAt;
  final String? lastComment;

  Report(
      {required this.userName,
      required this.mobile,
      this.acc,
      this.sector,
      this.place,
      this.id,
      this.createdAt,
      this.lastComment});

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] as int,
      userName: json['name'],
      mobile: json['phone'],
      acc: json['account'],
      sector: json['sector'],
      place: json['place'],
      createdAt: json['created_at'],
      lastComment: json['last_comment'] != null ? json['last_comment']['comment'] : '',
    );
  }
}
