import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Bottom Navigation Bar khusus Worker (Rooms, Log Item, Storage, Profile).
///
/// Menu Log Item menampilkan lingkaran dengan ikon kamera di tengah.
class WorkerBottomNavBar extends StatelessWidget {
  const WorkerBottomNavBar({
    super.key,
    this.currentIndex = 1,
    this.onSelected,
  });

  final int currentIndex;
  final ValueChanged<int>? onSelected;

  @override
  Widget build(BuildContext context) {
    const items = [
      _NavItemData(Icons.meeting_room_outlined, 'Rooms'),
      _NavItemData(Icons.camera_alt, 'Log Item'),
      _NavItemData(Icons.inventory_2_outlined, 'Storage'),
      _NavItemData(Icons.person_outline, 'Profile'),
    ];

    return SafeArea(
      top: false,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var i = 0; i < items.length; i++)
              _buildItem(i, items[i]),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(int index, _NavItemData data) {
    final active = currentIndex == index;
    final isCenter = index == 1;
    final color = active ? AppColors.navy : const Color(0xFF94A3B8);

    return InkWell(
      onTap: onSelected != null ? () => onSelected!(index) : null,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isCenter)
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: active ? AppColors.navy : Colors.white,
                  shape: BoxShape.circle,
                  border: active ? null : Border.all(color: AppColors.navy, width: 1.4),
                ),
                child: Icon(data.icon, size: 20, color: active ? Colors.white : AppColors.navy),
              )
            else
              Icon(data.icon, size: 22, color: color),
            const SizedBox(height: 3),
            Text(
              data.label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItemData {
  const _NavItemData(this.icon, this.label);
  final IconData icon;
  final String label;
}