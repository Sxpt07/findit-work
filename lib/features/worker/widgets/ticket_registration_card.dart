import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Card registrasi/tiket dengan QR, nomor tiket, dan tombol Salin.
class TicketRegistrationCard extends StatelessWidget {
  const TicketRegistrationCard({
    super.key,
    this.ticketNo = '#LF-2024-0314-08',
    this.onCopy,
  });

  final String ticketNo;
  final VoidCallback? onCopy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.ticketBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.ticketBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.qr_code_2, color: AppColors.navy, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'NO. REGISTRASI / TIKET',
                  style: TextStyle(
                    fontSize: 9,
                    color: AppColors.muted,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  ticketNo,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.navy),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onCopy,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(color: AppColors.navy, borderRadius: BorderRadius.circular(20)),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.copy, size: 13, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    'Salin',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}