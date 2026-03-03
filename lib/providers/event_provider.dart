import 'package:flutter/material.dart';
import '../models/event.dart';
import '../models/ticket.dart';
import '../data/mock_data.dart';
import 'package:uuid/uuid.dart';

class EventProvider with ChangeNotifier {
  final List<EventModel> _events = MockData.events;
  final List<TicketModel> _purchasedTickets = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';

  List<EventModel> get events {
    return _events.where((e) {
      final matchesCategory = _selectedCategory == 'All' || e.category == _selectedCategory;
      final matchesSearch = e.title.toLowerCase().contains(_searchQuery.toLowerCase()) || 
                            e.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void purchaseTicket(EventModel event, String tierName, String price) {
    final ticket = TicketModel(
      id: const Uuid().v4(),
      eventId: event.id,
      event: event,
      tierName: tierName,
      price: price,
      purchaseDate: DateTime.now(),
      qrCodeData: 'TICKET-${event.id}-${DateTime.now().millisecondsSinceEpoch}',
    );
    _purchasedTickets.add(ticket);
    notifyListeners();
  }

  EventModel getEventById(String id) {
    return _events.firstWhere((e) => e.id == id);
  }

  List<TicketModel> get purchasedTickets => _purchasedTickets;
  List<EventModel> get trendingEvents => _events.where((e) => e.isTrending).toList();
}
