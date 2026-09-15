import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Card detail barang terpantau pada layar sukses: thumbnail, badge,
/// deskripsi, lokasi, info waktu/petugas, dan status verifikasi.
class ItemSavedCard extends StatelessWidget {
  const ItemSavedCard({
    super.key,
    this.badge = 'Elektronik • Lantai 3',
    this.title = 'Smartwatch Hitam',
    this.description = 'Merk Garmin Venu SQ (Tali Karet)',
    this.location = 'Kamar 314 / Meja Nakas Kanan',
    this.timeLabel = 'Waktu Perekaman',
    this.timeValue = '11:20:14 WIB',
    this.staffLabel = 'Petugas Pelapor',
    this.staffValue = 'Rian S. (HK-04)',
    this.statusText = 'Menunggu Verifikasi Front Office',
    this.statusPill = 'Logged',
  });

  final String badge;
  final String title;
  final String description;
  final String location;
  final String timeLabel;
  final String timeValue;
  final String staffLabel;
  final String staffValue;
  final String statusText;
  final String statusPill;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 74,
                height: 74,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [AppColors.photoGrad1, AppColors.photoGrad2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(child: Icon(Icons.watch, size: 34, color: AppColors.navy)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: AppColors.softBlue, borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        badge,
                        style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.navy),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      title,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.navy),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: TextStyle(fontSize: 10, color: Colors.black45.withValues(alpha: 0.6)),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.bed_outlined, size: 13, color: AppColors.navy),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            location,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Colors.black87.withValues(alpha: 0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _infoBox(icon: Icons.schedule, label: timeLabel, value: timeValue)),
              const SizedBox(width: 10),
              Expanded(child: _infoBox(icon: Icons.badge_outlined, label: staffLabel, value: staffValue)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    statusText,
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.ink),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.softBlue, borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    statusPill,
                    style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.navy),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBox({required IconData icon, required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 12, color: AppColors.navy),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 8, color: AppColors.muted, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.navy),
          ),
        ],
      ),
    );
  }
}