import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoading = true;
  bool _hasSeenOnboarding = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;
  bool get hasSeenOnboarding => _hasSeenOnboarding;

  AuthProvider() {
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    // Artificial delay for splash screen visibility
    await Future.delayed(const Duration(seconds: 2));
    final userStr = prefs.getString('user_data');
    if (userStr != null) {
      _user = UserModel.fromJson(jsonDecode(userStr));
    }
    _hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    _hasSeenOnboarding = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    // Mock login
    _user = UserModel(
      id: 'user_123',
      name: 'John Doe',
      email: email,
      role: UserRole.attendee,
      photoUrl: 'https://i.pravatar.cc/150?img=11',
      bio: 'Event enthusiast and Flutter developer.',
      interests: ['Tech', 'Music', 'Design'],
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(_user!.toJson()));
    notifyListeners();
  }

  Future<void> register(String name, String email, String password, UserRole role) async {
    // Mock registration
    _user = UserModel(
      id: 'user_123',
      name: name,
      email: email,
      role: role,
      photoUrl: 'https://i.pravatar.cc/150?img=11',
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(_user!.toJson()));
    notifyListeners();
  }

  Future<void> logout() async {
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
    notifyListeners();
  }
}
