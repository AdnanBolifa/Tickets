class Solution {
  final int id;
  final String name;

  Solution({required this.id, required this.name});

  factory Solution.fromJson(Map<String, dynamic> json) {
    return Solution(
      id: json['id'],
      name: json['solution'],
    );
  }
}
