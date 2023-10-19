class Report {
  final int? id;
  final String userName;
  final String mobile;
  final String? acc;
  final String? sector;
  final String? place;

  Report(
      {required this.userName,
      required this.mobile,
      this.acc,
      this.sector,
      this.place,
      this.id});
}
