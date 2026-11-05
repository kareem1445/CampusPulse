import 'package:flutter/material.dart';

import '../models/notice.dart';
import '../utils/date_format.dart';

class NoticeCard extends StatelessWidget {
  const NoticeCard({super.key, required this.notice, required this.onTap});

  final Notice notice;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF0FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      notice.department,
                      style: const TextStyle(
                        color: Color(0xFF2457C5),
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (notice.important)
                    const Icon(Icons.push_pin, size: 17, color: Colors.deepOrange),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                notice.title,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 7),
              Text(
                notice.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.blueGrey.shade600, height: 1.35),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(notice.category,
                      style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 12)),
                  const Spacer(),
                  Icon(Icons.calendar_today_outlined,
                      size: 13, color: Colors.blueGrey.shade500),
                  const SizedBox(width: 5),
                  Text(formatNoticeDate(notice.createdAt),
                      style: TextStyle(color: Colors.blueGrey.shade500, fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
