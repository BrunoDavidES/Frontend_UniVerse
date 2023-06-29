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
    CalendarEvent(true, "Este é o primeiro evento de teste".toUpperCase(), "user", "Edifício II sala 127", "09:00", "25-06-2023"),
    CalendarEvent(false, "Demonstração da fase beta".toUpperCase(), "Capi Crew", "Auditório", "13:30", "29-06-2023"),


  ];

}