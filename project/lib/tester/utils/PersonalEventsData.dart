class PersonalEventsData {
  final String title;
  final String username;
  final String beginningDate;
  final String hours;
  final String location;

  PersonalEventsData({
    required this.title,
    required this.username,
    required this.beginningDate,
    required this.hours,
    required this.location
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'username': username,
      'beginningDate': beginningDate,
      'hours': hours,
      'location': location
    };
  }
}