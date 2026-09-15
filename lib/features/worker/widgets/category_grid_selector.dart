import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Grid 2x3 pilihan kategori barang pada formulir.
///
/// Item terpilih berwarna biru navy `#00236F`.
class CategoryGridSelector extends StatelessWidget {
  const CategoryGridSelector({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Kategori Barang',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.navy),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.softBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Terpilih Otomatis',
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.navy),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 2.2,
          children: [
            for (var i = 0; i < categories.length; i++)
              _item(
                label: categories[i],
                selected: selectedIndex == i,
                onTap: () => onSelected(i),
              ),
          ],
        ),
      ],
    );
  }

  Widget _item({required String label, required bool selected, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.navy : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? AppColors.navy : Colors.grey.shade300),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : AppColors.ink,
          ),
        ),
      ),
    );
  }
}