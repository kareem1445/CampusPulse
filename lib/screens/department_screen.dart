import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/notice_provider.dart';

const _filters = [
'All',
'CSE',
'ECE',
'EEE',
'CIVIL',
'MECH',
'IT',
'All College',
];

class DepartmentScreen extends StatelessWidget {
const DepartmentScreen({super.key});

@override
Widget build(BuildContext context) {
final selected =
context.watch<NoticeProvider>().departmentFilter;

return Scaffold(
  appBar: AppBar(
    title: const Text('Filter by department'),
  ),
  body: RadioGroup<String>(
    groupValue: selected,
    onChanged: (value) {
      if (value == null) return;

      context
          .read<NoticeProvider>()
          .setDepartmentFilter(value);

      Navigator.pop(context);
    },
    child: ListView.separated(
      padding: const EdgeInsets.all(18),
      itemCount: _filters.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final filter = _filters[index];

        return Card(
          child: RadioListTile<String>(
            value: filter,
            title: Text(
              filter == 'All' ? 'All departments' : filter,
            ),
            secondary: Icon(
              filter == 'All'
                  ? Icons.groups_outlined
                  : Icons.school_outlined,
            ),
          ),
        );
      },
    ),
  ),
);

}
}
