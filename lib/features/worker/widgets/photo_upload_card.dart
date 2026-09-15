import 'dart:io';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Card upload foto barang pada formulir pencatatan.
///
/// Bila [photoPath] null, menampilkan kotak upload dengan tombol
/// "Ambil Foto / Pilih Gambar"; bila sudah ada foto, menampilkan preview
/// + chip "Ganti Foto".
class PhotoUploadCard extends StatelessWidget {
  const PhotoUploadCard({super.key, this.photoPath, required this.onPick});

  final String? photoPath;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Foto Barang',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.navy),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onPick,
          child: Container(
            height: 180,
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: photoPath != null ? Colors.white : AppColors.softBlueBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: photoPath != null ? Colors.grey.shade300 : const Color(0xFFC6CFE4),
                width: photoPath != null ? 1 : 1.5,
              ),
            ),
            child: photoPath != null ? Image.file(File(photoPath!), fit: BoxFit.cover) : _uploadBox(),
          ),
        ),
      ],
    );
  }

  Widget _uploadBox() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFC6CFE4)),
          ),
          child: const Icon(Icons.add_a_photo_outlined, size: 24, color: AppColors.navy),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.yellow,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Ambil Foto / Pilih Gambar',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.navy),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Foto tidak wajib, bisa ditambahkan nanti.',
          style: TextStyle(fontSize: 10, color: Colors.black45.withValues(alpha: 0.6)),
        ),
      ],
    );
  }
}