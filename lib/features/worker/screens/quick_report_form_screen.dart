import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../theme/app_colors.dart';
import '../widgets/category_grid_selector.dart';
import '../widgets/photo_upload_card.dart';
import '../widgets/report_datetime_field.dart';
import '../widgets/report_text_field.dart';
import '../widgets/worker_header.dart';
import 'item_saved_success_screen.dart';

/// Form Pencatatan Lengkap barang temuan (Petugas).
///
/// Menyusun field foto, nama barang, kategori, nomor kamar,
/// waktu ditemukan (auto-filled DateTime.now), dan catatan tambahan.
/// Submit mengarahkan ke [ItemSavedSuccessScreen].
class QuickReportFormScreen extends StatefulWidget {
  const QuickReportFormScreen({super.key, this.photoPath});

  /// Path foto awal opsional — bisa dari kamera sebelumnya.
  final String? photoPath;

  @override
  State<QuickReportFormScreen> createState() => _QuickReportFormScreenState();
}

class _QuickReportFormScreenState extends State<QuickReportFormScreen> {
  static const _categories = [
    'Elektronik',
    'Dompet & Tas',
    'Pakaian',
    'Dokumen/ID',
    'Perhiasan/Jam',
    'Lainnya',
  ];

  final _nameCtrl = TextEditingController();
  final _colorCtrl = TextEditingController();
  final _roomCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  int _selectedCategory = 0;
  late String? _photoPath = widget.photoPath;
  late DateTime _foundAt = DateTime.now();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _colorCtrl.dispose();
    _roomCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Ambil Foto', style: TextStyle(fontWeight: FontWeight.w700)),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Pilih dari Galeri', style: TextStyle(fontWeight: FontWeight.w700)),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null || !mounted) return;
    try {
      final picked = await ImagePicker().pickImage(source: source, maxWidth: 1280, imageQuality: 85);
      if (picked != null && mounted) setState(() => _photoPath = picked.path);
    } on Exception {
      // Kamera/galeri tidak tersedia — biarkan tanpa foto.
    }
  }

  void _submit() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ItemSavedSuccessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            WorkerHeader(
              showBack: true,
              subtitle: 'Form Pencatatan Lengkap',
              onBack: () => Navigator.pop(context),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
                children: [
                  PhotoUploadCard(photoPath: _photoPath, onPick: _pickPhoto),
                  const SizedBox(height: 20),
                  ReportTextField(
                    label: 'Nama Barang',
                    hint: 'Contoh: Jam Tangan Pintar',
                    controller: _nameCtrl,
                  ),
                  const SizedBox(height: 20),
                  ReportTextField(
                    label: 'Warna Barang',
                    hint: 'Masukkan warna barang (misal: Hitam, Perak, Biru)',
                    controller: _colorCtrl,
                    prefixIcon: const Icon(Icons.color_lens_outlined, size: 20, color: AppColors.navy),
                  ),
                  const SizedBox(height: 20),
                  CategoryGridSelector(
                    categories: _categories,
                    selectedIndex: _selectedCategory,
                    onSelected: (i) => setState(() => _selectedCategory = i),
                  ),
                  const SizedBox(height: 20),
                  ReportTextField(
                    label: 'Nomor Kamar',
                    hint: 'Masukkan nomor kamar (misal: 314)',
                    controller: _roomCtrl,
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.meeting_room_outlined, size: 20, color: AppColors.navy),
                  ),
                  const SizedBox(height: 20),
                  ReportDateTimeField(
                    value: _foundAt,
                    onChanged: (dt) => setState(() => _foundAt = dt),
                  ),
                  const SizedBox(height: 20),
                  ReportTextField(
                    label: 'Deskripsi / Catatan Tambahan',
                    hint: 'Contoh: Ditemukan di atas meja nakas sebelah kanan tempat tidur',
                    controller: _descCtrl,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 22),
                  _submitButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return SizedBox(
      height: 54,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.yellow,
          foregroundColor: AppColors.navy,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: _submit,
        child: const Text(
          'Simpan & Laporkan Temuan ➔',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}