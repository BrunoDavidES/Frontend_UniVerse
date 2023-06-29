class ReportData {
  final String title;
  final String location;

  ReportData({
    required this.title,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'location': location,
    };
  }
}