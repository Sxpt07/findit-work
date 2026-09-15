import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Widget field waktu (Tanggal & Jam) untuk formulir pencatatan barang temuan.
///
/// Menampilkan waktu dalam format "15 Sep 2026, 14:30 WIB". Waktu awal
/// default ke [DateTime.now]. Ketika diketuk, memunculkan date picker
/// lalu time picker untuk pengubahan.
class ReportDateTimeField extends StatelessWidget {
  const ReportDateTimeField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final DateTime value;
  final ValueChanged<DateTime> onChanged;

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
  ];

  String _format(DateTime dt) {
    final d = dt.day.toString().padLeft(2, '0');
    final m = _months[dt.month - 1];
    final h = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$d $m ${dt.year}, $h:$min WIB';
  }

  Future<void> _pick(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: value,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate == null || !context.mounted) return;
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(value),
    );
    if (pickedTime == null) return;
    onChanged(DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Waktu (Tanggal & Jam)',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.navy),
        ),
        const SizedBox(height: 8),
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            onTap: () => _pick(context),
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.schedule_outlined, size: 18, color: AppColors.navy),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _format(value),
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.navy),
                    ),
                  ),
                  Icon(Icons.edit_calendar_outlined, size: 18, color: Colors.grey.shade500),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}