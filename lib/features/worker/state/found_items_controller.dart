import 'package:flutter/foundation.dart';
import '../data/mock_found_items.dart';
import '../models/found_item_model.dart';

/// State management lokal & mandiri untuk modul Worker Dashboard.
///
/// Sengaja pakai `ChangeNotifier` bawaan Flutter (tanpa package state
/// management eksternal) supaya modul ini benar-benar independen dan
/// tidak memicu conflict dengan state management apa pun yang sudah
/// dipakai di project utama. Cukup dibuat sebagai instance biasa di
/// `WorkerDashboardScreen`, tidak perlu didaftarkan secara global.
class FoundItemsController extends ChangeNotifier {
  FoundItemsController() : _items = mockFoundItems();

  final List<FoundItemModel> _items;

  List<FoundItemModel> get items => List.unmodifiable(_items);

  /// Jumlah barang yang foundDate-nya beneran hari ini (bukan total semua).
  int get todayCount {
    final now = DateTime.now();
    return _items
        .where((i) => i.foundDate.year == now.year && i.foundDate.month == now.month && i.foundDate.day == now.day)
        .length;
  }

  void addItem(FoundItemModel item) {
    _items.insert(0, item);
    notifyListeners();
  }

  int get claimedCount => _items.where((i) => i.status == FoundItemStatus.claimed).length;

  /// Label shift terdeteksi berdasarkan jam saat ini (untuk header dashboard).
  String get currentShiftLabel {
    final hour = DateTime.now().hour;
    if (hour >= 7 && hour < 15) return 'Shift Pagi (07:00-15:00)';
    if (hour >= 15 && hour < 23) return 'Shift Sore (15:00-23:00)';
    return 'Shift Malam (23:00-07:00)';
  }

  void markAsClaimed(String id) {
    final item = _items.firstWhere((i) => i.id == id);
    item.status = FoundItemStatus.claimed;
    notifyListeners();
  }
}