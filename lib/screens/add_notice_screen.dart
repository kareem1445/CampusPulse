import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/notice_provider.dart';

const departments = [
'CSE',
'ECE',
'EEE',
'CIVIL',
'MECH',
'IT',
'All College',
];

const categories = [
'General',
'Exam',
'Event',
'Placement',
'Workshop',
'Holiday',
];

class AddNoticeScreen extends StatefulWidget {
const AddNoticeScreen({super.key});

@override
State<AddNoticeScreen> createState() => _AddNoticeScreenState();
}

class _AddNoticeScreenState extends State<AddNoticeScreen> {
final _formKey = GlobalKey<FormState>();
final _title = TextEditingController();
final _description = TextEditingController();

String _department = departments.first;
String _category = categories.first;
bool _important = false;
bool _saving = false;

@override
void dispose() {
_title.dispose();
_description.dispose();
super.dispose();
}

Future<void> _submit() async {
if (!_formKey.currentState!.validate()) return;

setState(() => _saving = true);

try {
  await context.read<NoticeProvider>().addNotice(
        title: _title.text,
        department: _department,
        category: _category,
        description: _description.text,
        important: _important,
      );

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Notice published successfully.'),
    ),
  );

  Navigator.pop(context);
} catch (_) {
  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Could not save notice. Please try again.'),
    ),
  );
} finally {
  if (mounted) {
    setState(() => _saving = false);
  }
}

}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Create notice'),
),
body: SafeArea(
child: Form(
key: _formKey,
child: ListView(
padding: const EdgeInsets.all(18),
children: [
const Text(
'Share an update with your campus',
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.w800,
),
),
const SizedBox(height: 18),
TextFormField(
controller: _title,
maxLength: 70,
decoration: const InputDecoration(
labelText: 'Notice title',
hintText: 'e.g. Internal exam timetable',
),
validator: (value) {
if (value == null || value.trim().isEmpty) {
return 'Enter a notice title.';
}
if (value.trim().length < 4) {
return 'Title must be at least 4 characters.';
}
return null;
},
),
const SizedBox(height: 12),
DropdownButtonFormField<String>(
initialValue: _department,
decoration: const InputDecoration(
labelText: 'Department',
),
items: departments.map((department) {
return DropdownMenuItem<String>(
value: department,
child: Text(department),
);
}).toList(),
onChanged: (value) {
if (value != null) {
setState(() => _department = value);
}
},
),
const SizedBox(height: 12),
DropdownButtonFormField<String>(
initialValue: _category,
decoration: const InputDecoration(
labelText: 'Category',
),
items: categories.map((category) {
return DropdownMenuItem<String>(
value: category,
child: Text(category),
);
}).toList(),
onChanged: (value) {
if (value != null) {
setState(() => _category = value);
}
},
),
const SizedBox(height: 12),
TextFormField(
controller: _description,
minLines: 5,
maxLines: 8,
maxLength: 1000,
decoration: const InputDecoration(
labelText: 'Description',
alignLabelWithHint: true,
hintText: 'Write the complete notice details...',
),
validator: (value) {
if (value == null || value.trim().isEmpty) {
return 'Enter notice details.';
}
if (value.trim().length < 10) {
return 'Add at least 10 characters.';
}
return null;
},
),
SwitchListTile(
contentPadding: EdgeInsets.zero,
title: const Text('Mark as important'),
subtitle: const Text(
'Show a pin icon on this notice.',
),
value: _important,
onChanged: (value) {
setState(() => _important = value);
},
),
const SizedBox(height: 18),
FilledButton.icon(
onPressed: _saving ? null : _submit,
icon: _saving
? const SizedBox(
width: 18,
height: 18,
child: CircularProgressIndicator(
strokeWidth: 2,
),
)
: const Icon(Icons.publish),
label: Text(
_saving ? 'Publishing...' : 'Publish notice',
),
style: FilledButton.styleFrom(
minimumSize: const Size.fromHeight(52),
),
),
],
),
),
),
);
}
}
