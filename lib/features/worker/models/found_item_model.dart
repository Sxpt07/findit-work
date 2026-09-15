/// Kategori barang temuan.
enum FoundItemCategory { electronics, clothing, accessories, documents, other }

extension FoundItemCategoryX on FoundItemCategory {
  String get label => switch (this) {
    FoundItemCategory.electronics => 'Elektronik',
    FoundItemCategory.clothing => 'Pakaian',
    FoundItemCategory.accessories => 'Aksesoris',
    FoundItemCategory.documents => 'Dokumen',
    FoundItemCategory.other => 'Lainnya',
  };
}

/// Status barang temuan: baru dicatat (Logged) atau sudah diambil tamu (Claimed).
enum FoundItemStatus { logged, claimed }

extension FoundItemStatusX on FoundItemStatus {
  String get label => this == FoundItemStatus.logged ? 'Logged' : 'Claimed';
}

/// Model sederhana untuk satu barang temuan yang dicatat worker/petugas
/// kebersihan hotel. Modul ini berdiri sendiri (tidak bergantung pada
/// model `Report` atau model lain di project utama).
class FoundItemModel {
  FoundItemModel({
    required this.id,
    required this.name,
    required this.category,
    required this.color,
    required this.location,
    required this.description,
    required this.foundDate,
    this.photoPath,
    this.status = FoundItemStatus.logged,
  });

  final String id;
  final String name;
  final FoundItemCategory category;
  final String color;

  /// Lokasi/ruangan tempat barang ditemukan, mis. "Room 412 - Under the bed".
  final String location;
  final String description;
  final DateTime foundDate;

  /// Path file lokal hasil image_picker. Null kalau belum ada foto.
  final String? photoPath;

  /// Sengaja tidak final: diubah lewat FoundItemsController.markAsClaimed().
  FoundItemStatus status;
}