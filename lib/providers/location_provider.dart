import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationProvider with ChangeNotifier {
  String _currentAddress = "San Francisco, CA";
  String get currentAddress => _currentAddress;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> updateLocation() async {
    _isLoading = true;
    notifyListeners();

    try {
      final status = await Permission.location.request();
      if (status.isGranted) {
        await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
          ),
        );
        
        // In a real app, we'd reverse geocode here. 
        // For this "Zero-Static" mock, we'll simulate finding a location.
        await Future.delayed(const Duration(seconds: 1));
        _currentAddress = "New York, NY"; // Simulated update
      }
    } catch (e) {
      debugPrint("Error getting location: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
