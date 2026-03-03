import 'event.dart';

class TicketModel {
  final String id;
  final String eventId;
  final EventModel event; // Helper to access event details easily
  final String tierName;
  final String price;
  final DateTime purchaseDate;
  final String qrCodeData; // Concatenation of ticket ID and user ID for example

  TicketModel({
    required this.id,
    required this.eventId,
    required this.event,
    required this.tierName,
    required this.price,
    required this.purchaseDate,
    required this.qrCodeData,
  });
}
