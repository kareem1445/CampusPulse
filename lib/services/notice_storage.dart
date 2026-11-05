import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/notice.dart';

class NoticeStorage {
  static const _storageKey = 'campus_pulse_notices_v1';

  Future<List<Notice>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) return [];
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => Notice.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> save(List<Notice> notices) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(notices.map((notice) => notice.toJson()).toList());
    final success = await prefs.setString(_storageKey, encoded);
    if (!success) throw Exception('Could not save notices on this device.');
  }
}
