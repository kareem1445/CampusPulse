import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/notice.dart';
import '../providers/notice_provider.dart';
import '../utils/date_format.dart';

class NoticeDetailScreen extends StatelessWidget {
  const NoticeDetailScreen({super.key, required this.notice});
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notice details'),
        actions: [
          IconButton(
            tooltip: 'Delete notice',
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text('Delete notice?'),
                  content: const Text('This notice will be removed from this device.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(dialogContext, false),
                        child: const Text('Cancel')),
                    FilledButton(onPressed: () => Navigator.pop(dialogContext, true),
                        child: const Text('Delete')),
                  ],
                ),
              );
              if (confirm == true && context.mounted) {
                await context.read<NoticeProvider>().deleteNotice(notice.id);
                if (context.mounted) Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          if (notice.important)
            const Chip(avatar: Icon(Icons.push_pin, size: 16),
                label: Text('Important notice')),
          Text(notice.title,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800,
                  height: 1.2)),
          const SizedBox(height: 14),
          Wrap(spacing: 8, runSpacing: 8, children: [
            Chip(label: Text(notice.department)),
            Chip(label: Text(notice.category)),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            const Icon(Icons.calendar_today_outlined, size: 16),
            const SizedBox(width: 8),
            Text('Posted ${formatNoticeDate(notice.createdAt)}'),
          ]),
          const Divider(height: 32),
          const Text('Notice information',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          Text(notice.description, style: const TextStyle(fontSize: 16, height: 1.6)),
        ],
      ),
    );
  }
}
