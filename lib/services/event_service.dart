import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event.dart';

class EventService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collection reference
  CollectionReference get _eventsRef => _db.collection('events');

  // Stream of all events
  Stream<List<EventModel>> get eventsStream {
    return _eventsRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return EventModel.fromJson(doc.data() as Map<String, dynamic>).copyWith(id: doc.id);
      }).toList();
    });
  }

  // Add a new event
  Future<void> addEvent(EventModel event) async {
    await _eventsRef.add(event.toJson());
  }

  // Update an event
  Future<void> updateEvent(EventModel event) async {
    await _eventsRef.doc(event.id).update(event.toJson());
  }

  // Delete an event
  Future<void> deleteEvent(String eventId) async {
    await _eventsRef.doc(eventId).delete();
  }

  // Get trending events (mocked simple query)
  Future<List<EventModel>> getTrendingEvents() async {
    final snapshot = await _eventsRef
        .where('isTrending', isEqualTo: true)
        .limit(5)
        .get();
    
    return snapshot.docs.map((doc) {
      return EventModel.fromJson(doc.data() as Map<String, dynamic>).copyWith(id: doc.id);
    }).toList();
  }
}
