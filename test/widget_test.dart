import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:campus_pulse/models/notice.dart';
import 'package:campus_pulse/widgets/notice_card.dart';

void main() {
  testWidgets('Notice card displays notice details and responds to tap',
      (WidgetTester tester) async {
    bool tapped = false;

    final notice = Notice(
      id: '1',
      title: 'Internal Exam',
      department: 'CSE',
      category: 'Exam',
      description: 'Internal examination timetable announced.',
      createdAt: DateTime(2026, 11, 5),
      important: true,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NoticeCard(
            notice: notice,
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    expect(find.text('Internal Exam'), findsOneWidget);
    expect(find.text('CSE'), findsOneWidget);

    await tester.tap(find.text('Internal Exam'));
    expect(tapped, isTrue);
  });
}