import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Baris berisi 3 card statistik: Total Dicatat, Belum Klaim, Sudah Kembali.
class StatSummaryRow extends StatelessWidget {
  const StatSummaryRow({
    super.key,
    required this.total,
    required this.unclaimed,
    required this.claimed,
  });

  final int total;
  final int unclaimed;
  final int claimed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'Total Dicatat',
            value: '$total',
            sub: 'Bulan ini',
            bg: Colors.white,
            fg: AppColors.navy,
            dot: const Color(0xFFE6EBF7),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            label: 'Belum Klaim',
            value: '$unclaimed',
            sub: 'Di Storage',
            bg: AppColors.softBlueBg,
            fg: AppColors.navy,
            dot: const Color(0xFFC7D2FE),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            label: 'Sudah Kembali',
            value: '$claimed',
            sub: 'Sukses',
            bg: AppColors.greenSoft,
            fg: AppColors.greenMid,
            dot: const Color(0xFF86EFAC),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.sub,
    required this.bg,
    required this.fg,
    required this.dot,
  });

  final String label;
  final String value;
  final String sub;
  final Color bg;
  final Color fg;
  final Color dot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: AppColors.muted)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: fg)),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(width: 6, height: 6, decoration: BoxDecoration(color: dot, shape: BoxShape.circle)),
              const SizedBox(width: 5),
              Text(sub, style: const TextStyle(fontSize: 9.5, color: AppColors.muted, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}