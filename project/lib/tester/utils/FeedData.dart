class FeedData {
  final String title;
  final String startDate;
  final String endDate;
  final String location;
  final String department;
  final bool isPublic;
  final int capacity;
  final bool isItPaid;
  final String authorNameByBO;

  FeedData({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.department,
    required this.isPublic,
    required this.capacity,
    required this.isItPaid,
    required this.authorNameByBO,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'startDate': startDate,
      'endDate': endDate,
      'location': location,
      'department': department,
      'isPublic': isPublic,
      'capacity': capacity,
      'isItPaid': isItPaid,
      'authorNameByBO': authorNameByBO,
    };
  }
}