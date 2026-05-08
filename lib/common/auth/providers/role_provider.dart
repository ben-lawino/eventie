import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _roleKey = 'user_role';

class RoleNotifier extends StateNotifier<String?> {
  RoleNotifier() : super(null);

  // Load saved role from SharedPreferences
  Future<void> loadRole() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString(_roleKey);
  }

  // Called from welcome screen when a card is tapped
  void selectRole(String role) {
    state = role;
  }

  // Called after successful sign up
  Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, role);
    state = role;
  }

  // Called after sign out
  Future<void> clearRole() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_roleKey);
    state = null;
  }
}

final roleProvider = StateNotifierProvider<RoleNotifier, String?>((ref) {
  return RoleNotifier();
});