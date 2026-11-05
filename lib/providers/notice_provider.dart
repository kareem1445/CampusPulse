import 'package:flutter/foundation.dart';

import '../models/notice.dart';
import '../services/notice_storage.dart';

enum NoticeLoadStatus { loading, loaded, error }

class NoticeProvider extends ChangeNotifier {
  NoticeProvider(this._storage);

  final NoticeStorage _storage;
  List<Notice> _notices = [];
  NoticeLoadStatus _status = NoticeLoadStatus.loading;
  String? _errorMessage;
  String _departmentFilter = 'All';
  String _searchQuery = '';

  List<Notice> get notices => List.unmodifiable(_notices);
  NoticeLoadStatus get status => _status;
  String? get errorMessage => _errorMessage;
  String get departmentFilter => _departmentFilter;
  String get searchQuery => _searchQuery;

  List<Notice> get visibleNotices {
    final query = _searchQuery.trim().toLowerCase();
    return _notices.where((notice) {
      final departmentMatches = _departmentFilter == 'All' ||
          notice.department == _departmentFilter;
      final queryMatches = query.isEmpty ||
          notice.title.toLowerCase().contains(query) ||
          notice.description.toLowerCase().contains(query) ||
          notice.category.toLowerCase().contains(query);
      return departmentMatches && queryMatches;
    }).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> loadNotices() async {
    _status = NoticeLoadStatus.loading;
    _errorMessage = null;
    notifyListeners();
    try {
      _notices = await _storage.load();
      _status = NoticeLoadStatus.loaded;
    } catch (error) {
      _status = NoticeLoadStatus.error;
      _errorMessage = 'Could not load saved notices. Please try again.';
    }
    notifyListeners();
  }

  Future<void> addNotice({
    required String title,
    required String department,
    required String category,
    required String description,
    required bool important,
  }) async {
    final notice = Notice(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title.trim(),
      department: department,
      category: category,
      description: description.trim(),
      createdAt: DateTime.now(),
      important: important,
    );
    final updated = [notice, ..._notices];
    await _storage.save(updated);
    _notices = updated;
    _status = NoticeLoadStatus.loaded;
    notifyListeners();
  }

  void setDepartmentFilter(String value) {
    _departmentFilter = value;
    notifyListeners();
  }

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  Future<void> deleteNotice(String id) async {
    final updated = _notices.where((notice) => notice.id != id).toList();
    await _storage.save(updated);
    _notices = updated;
    notifyListeners();
  }
}
