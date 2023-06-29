class CalendarEvent {

  final bool? isEditable;
  final String? title;
  final String? planner;
  final String? location;
  final String? hour;
  final String? date;

  CalendarEvent(
      //this.id,
      this.isEditable,
      this.title,
      this.planner,
      this.location,
      this.hour,
      this.date
      );

  static List<CalendarEvent> events = [
    CalendarEvent(true, "Este é o título".toUpperCase(), "user", "Relvado da biblioteca", "09:00", "21-02-2023"),
    CalendarEvent(false, "Este é um segundo evento".toUpperCase(), "Ninf", "Relvado da biblioteca", "10:50", "21-02-2023"),


  ];

}