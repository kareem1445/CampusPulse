import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/notice_provider.dart';
import '../widgets/notice_card.dart';
import 'add_notice_screen.dart';
import 'department_screen.dart';
import 'notice_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NoticeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('CampusPulse',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 23)),
        actions: [
          IconButton(
            tooltip: 'Departments',
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const DepartmentScreen())),
            icon: const Icon(Icons.tune_rounded),
          ),
          const SizedBox(width: 6),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const AddNoticeScreen())),
        icon: const Icon(Icons.add),
        label: const Text('Add notice'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 4, 18, 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2457C5), Color(0xFF5485E8)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your campus. One pulse.',
                        style: TextStyle(color: Colors.white, fontSize: 19,
                            fontWeight: FontWeight.w800)),
                    SizedBox(height: 5),
                    Text('Stay updated with the latest college notices.',
                        style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: _searchController,
                onChanged: provider.setSearchQuery,
                decoration: InputDecoration(
                  hintText: 'Search notices...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            _searchController.clear();
                            provider.setSearchQuery('');
                          },
                          icon: const Icon(Icons.close),
                        ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const Text('Latest notices',
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
                  const Spacer(),
                  Text(provider.departmentFilter,
                      style: const TextStyle(color: Color(0xFF2457C5),
                          fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: switch (provider.status) {
                  NoticeLoadStatus.loading =>
                    const Center(child: CircularProgressIndicator()),
                  NoticeLoadStatus.error => Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.cloud_off_outlined, size: 42),
                          const SizedBox(height: 10),
                          Text(provider.errorMessage ?? 'Something went wrong'),
                          const SizedBox(height: 10),
                          FilledButton.icon(
                            onPressed: provider.loadNotices,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  NoticeLoadStatus.loaded => provider.visibleNotices.isEmpty
                      ? _EmptyState(
                          hasNotices: provider.notices.isNotEmpty,
                          onAdd: () => Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const AddNoticeScreen())),
                        )
                      : RefreshIndicator(
                          onRefresh: provider.loadNotices,
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: provider.visibleNotices.length,
                            itemBuilder: (context, index) {
                              final notice = provider.visibleNotices[index];
                              return NoticeCard(
                                notice: notice,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => NoticeDetailScreen(notice: notice),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.hasNotices, required this.onAdd});
  final bool hasNotices;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.campaign_outlined, size: 58, color: Color(0xFF8A9AB5)),
            const SizedBox(height: 12),
            Text(hasNotices ? 'No matching notices' : 'No notices yet',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(hasNotices
                ? 'Try another search or department.'
                : 'Add the first notice to get your campus board started.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueGrey.shade600)),
            if (!hasNotices) ...[
              const SizedBox(height: 14),
              FilledButton.icon(onPressed: onAdd,
                  icon: const Icon(Icons.add), label: const Text('Create notice')),
            ],
          ],
        ),
      );
}
