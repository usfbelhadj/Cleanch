class Event {
  final int eventId;
  final String eventType;
  final DateTime eventDate;
  final double latitude;
  final double longitude;
  final String message;

  Event({
    required this.eventId,
    required this.eventType,
    required this.eventDate,
    required this.latitude,
    required this.longitude,
    required this.message,
  });
}
