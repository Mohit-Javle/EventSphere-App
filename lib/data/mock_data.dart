import '../models/event.dart';

class MockData {
  static final List<EventModel> events = [
    EventModel(
      id: '1',
      title: 'Flutter Forward 2026',
      description: 'Join the global Flutter community for an exclusive preview of what\'s next for Flutter and Dart. Network with top engineers, participate in workshops, and elevate your skills.',
      bannerUrl: 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=800&q=80',
      category: 'Tech',
      dateTime: DateTime(2026, 10, 10, 9, 0),
      location: 'Moscone Center, San Francisco',
      price: 99.0,
      rating: 4.8,
      type: EventType.inPerson,
      organizerId: 'org1',
      isTrending: true,
    ),
    EventModel(
      id: '2',
      title: 'Neon Nights Music Fest',
      description: 'An immersive electronic music experience featuring top DJs and stunning visual effects.',
      bannerUrl: 'https://images.unsplash.com/photo-1515159676701-d00db5cbd663?w=800&q=80',
      category: 'Music',
      dateTime: DateTime(2026, 11, 15, 20, 0),
      location: 'The Echo Lounge, Austin',
      price: 45.0,
      rating: 4.9,
      type: EventType.hybrid,
      organizerId: 'org2',
      isTrending: true,
    ),
    EventModel(
      id: '3',
      title: 'AI Strategy Summit',
      description: 'Strategic discussions on the future of AI in business and enterprise architecture.',
      bannerUrl: 'https://images.unsplash.com/photo-1551818255-e6e10975bc17?w=800&q=80',
      category: 'Business',
      dateTime: DateTime(2026, 12, 1, 10, 0),
      location: 'Virtual Event',
      price: 0.0,
      rating: 4.7,
      type: EventType.virtual,
      organizerId: 'org1',
    ),
  ];
}
