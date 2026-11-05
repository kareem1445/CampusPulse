import 'package:flutter_test/flutter_test.dart';
import 'package:campus_pulse/models/notice.dart';

void main() {
  test('Notice converts to JSON and back without losing data', () {
    final original = Notice(
      id: '123',
      title: 'Internal exam timetable',
      department: 'CSE',
      category: 'Exam',
      description: 'Check the college portal for the timetable.',
      createdAt: DateTime(2026, 11, 5, 10, 30),
      important: true,
    );

    final restored = Notice.fromJson(original.toJson());

    expect(restored.id, original.id);
    expect(restored.title, original.title);
    expect(restored.department, original.department);
    expect(restored.category, original.category);
    expect(restored.description, original.description);
    expect(restored.createdAt, original.createdAt);
    expect(restored.important, isTrue);
  });
}
