import 'package:flutter/material.dart';

import '../models/found_item_model.dart';
import '../state/found_items_controller.dart';
import '../theme/app_colors.dart';
import '../widgets/found_item_card.dart';
import '../widgets/found_item_detail_sheet.dart';
import '../widgets/history_filter_bar.dart';
import '../widgets/quick_capture_card.dart';
import '../widgets/worker_header.dart';
import '../widgets/worker_profile_sheet.dart';
import 'quick_report_form_screen.dart';

/// Halaman utama Dashboard Petugas "Find It! — Petugas".
///
/// Menerapkan ListView dari widget-widget kecil: [WorkerHeader],
/// [QuickCaptureCard], [HistoryFilterBar], dan [FoundItemCard].
class WorkerDashboardScreen extends StatefulWidget {
  const WorkerDashboardScreen({super.key});

  @override
  State<WorkerDashboardScreen> createState() => _WorkerDashboardScreenState();
}

class _WorkerDashboardScreenState extends State<WorkerDashboardScreen> {
  final _controller = FoundItemsController();
  int _statusFilter = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  void _openReportForm() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const QuickReportFormScreen()));
  }

  void _openDetail(FoundItemModel item) {
    showFoundItemDetail(
      context,
      item: item,
      onMarkClaimed: () => _controller.markAsClaimed(item.id),
    );
  }

  List<FoundItemModel> get _filteredItems {
    final all = _controller.items;
    switch (_statusFilter) {
      case 1:
        return all.where((i) => i.status == FoundItemStatus.logged).toList();
      case 2:
        return all.where((i) => i.status == FoundItemStatus.claimed).toList();
      default:
        return all;
    }
  }

  int get _unclaimedCount => _controller.items.length - _controller.claimedCount;

  @override
  Widget build(BuildContext context) {
    final items = _filteredItems;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          WorkerHeader(
            leading: const WorkerBrandLogo(),
            subtitle: 'Grand Meliá Jakarta',
            onAvatarTap: () => WorkerProfileSheet.show(context),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                QuickCaptureCard(onTap: _openReportForm),
                const SizedBox(height: 16),
                HistoryFilterBar(
                  selectedIndex: _statusFilter,
                  total: _controller.items.length,
                  unclaimed: _unclaimedCount,
                  claimed: _controller.claimedCount,
                  onChanged: (i) => setState(() => _statusFilter = i),
                ),
                const SizedBox(height: 12),
                if (items.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 36),
                    child: Center(child: Text('Belum ada barang di filter ini.')),
                  )
                else
                  ...items.map((item) => FoundItemCard(item: item, onTap: () => _openDetail(item))),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.navy,
        onPressed: _openReportForm,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}