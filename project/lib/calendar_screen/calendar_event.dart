class CalendarEvent {

  final String? title;
  final String? planner;
  final String? location;

  CalendarEvent(
      //this.id,
      this.title,
      this.planner,
      this.location
      );

  static List<CalendarEvent> events = [
    CalendarEvent("Este é o título".toUpperCase(), "Ninf", "Relvado da biblioteca"),
    CalendarEvent("Este é um segundo evento".toUpperCase(), "Ninf", "Relvado da biblioteca"),


  ];

}