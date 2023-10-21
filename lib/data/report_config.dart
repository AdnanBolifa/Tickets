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
}
