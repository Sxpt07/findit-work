import '../models/found_item_model.dart';

/// Data dummy awal supaya Dashboard Worker langsung bisa diuji tanpa
/// backend. Tidak menyentuh/menggunakan data dummy apa pun dari modul lain.
List<FoundItemModel> mockFoundItems() {
  final now = DateTime.now();
  return [
    FoundItemModel(
      id: 'w1',
      name: 'Charger Laptop Hitam',
      category: FoundItemCategory.electronics,
      color: 'Hitam',
      location: 'Room 214 - Nakas',
      description: 'Ditemukan di bawah meja nakas Kamar 214. Kondisi masih bagus.',
      foundDate: now.subtract(const Duration(hours: 5)),
    ),
    FoundItemModel(
      id: 'w2',
      name: 'Jaket Denim',
      category: FoundItemCategory.clothing,
      color: 'Biru',
      location: 'Room 108 - Lemari',
      description: 'Tertinggal di lemari Kamar 108, sudah dilipat rapi oleh housekeeping.',
      foundDate: now.subtract(const Duration(days: 1)),
    ),
    FoundItemModel(
      id: 'w3',
      name: 'Kacamata Baca',
      category: FoundItemCategory.accessories,
      color: 'Coklat Tua',
      location: 'Room 305 - Nakas',
      description: 'Ditemukan di nakas dekat tempat tidur, Kamar 305.',
      foundDate: now.subtract(const Duration(days: 2, hours: 3)),
    ),
    FoundItemModel(
      id: 'w4',
      name: 'Paspor',
      category: FoundItemCategory.documents,
      color: 'Merah Maroon',
      location: 'Room 412 - Laci Meja Kerja',
      description: 'Ditemukan di laci meja kerja Kamar 412. Sudah dititipkan ke Front Office.',
      foundDate: now.subtract(const Duration(days: 3)),
    ),
  ];
}