import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Header "Riwayat Temuan" beserta baris filter pill (Semua, Belum Diklaim,
/// Selesai) yang bisa di-scroll horizontal.
class HistoryFilterBar extends StatelessWidget {
  const HistoryFilterBar({
    super.key,
    required this.selectedIndex,
    required this.total,
    required this.unclaimed,
    required this.claimed,
    required this.onChanged,
  });

  final int selectedIndex;
  final int total;
  final int unclaimed;
  final int claimed;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Riwayat Temuan Anda',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.navy),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Row(
                children: [
                  Icon(Icons.calendar_today_outlined, size: 12, color: AppColors.navy),
                  SizedBox(width: 5),
                  Text(
                    'Hari ini & Kemarin',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.navy),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 38,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _pill(label: 'Semua ($total)', active: selectedIndex == 0, onTap: () => onChanged(0)),
              const SizedBox(width: 8),
              _pill(label: 'Belum Diklaim ($unclaimed)', active: selectedIndex == 1, onTap: () => onChanged(1)),
              const SizedBox(width: 8),
              _pill(label: 'Selesai ($claimed)', active: selectedIndex == 2, onTap: () => onChanged(2)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _pill({required String label, required bool active, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: active ? AppColors.navy : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: active ? AppColors.navy : Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: active ? Colors.white : AppColors.ink,
          ),
        ),
      ),
    );
  }
}