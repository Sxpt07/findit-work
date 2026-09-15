import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/auto_return_countdown.dart';
import '../widgets/item_saved_card.dart';
import '../widgets/saved_success_intro.dart';
import '../widgets/ticket_registration_card.dart';
import '../widgets/worker_bottom_navbar.dart';
import '../widgets/worker_header.dart';
import 'quick_report_form_screen.dart';

/// Layar sukses setelah barang tersimpan (Petugas - Item Saved).
///
/// Menampilkan [SavedSuccessIntro], [TicketRegistrationCard],
/// [ItemSavedCard], [AutoReturnCountdown], serta aksi kembali ke Beranda /
/// catat barang lain.
class ItemSavedSuccessScreen extends StatefulWidget {
  const ItemSavedSuccessScreen({super.key});

  @override
  State<ItemSavedSuccessScreen> createState() => _ItemSavedSuccessScreenState();
}

class _ItemSavedSuccessScreenState extends State<ItemSavedSuccessScreen> {
  Timer? _timer;
  int _seconds = 3;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_seconds <= 0) {
        _timer?.cancel();
        _goHome();
        return;
      }
      setState(() => _seconds--);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _goHome() {
    _timer?.cancel();
    if (!mounted) return;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _copyTicket() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Kode tiket disalin!')),
    );
  }

  void _logAnother() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const QuickReportFormScreen()),
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
            const WorkerHeader(showSearch: true),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
                children: [
                  const SavedSuccessIntro(),
                  const SizedBox(height: 16),
                  TicketRegistrationCard(onCopy: _copyTicket),
                  const SizedBox(height: 14),
                  const ItemSavedCard(),
                  const SizedBox(height: 16),
                  AutoReturnCountdown(seconds: _seconds),
                  const SizedBox(height: 14),
                  _primaryButton(),
                  const SizedBox(height: 10),
                  _secondaryButton(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const WorkerBottomNavBar(currentIndex: 1),
    );
  }

  Widget _primaryButton() {
    return SizedBox(
      height: 54,
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.yellow,
          foregroundColor: AppColors.navy,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: _goHome,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 18, color: AppColors.navy),
            SizedBox(width: 8),
            Text(
              'Kembali ke Beranda Sekarang',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  Widget _secondaryButton() {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.navy,
          backgroundColor: AppColors.softBlueBg,
          side: const BorderSide(color: Color(0xB3E4E9F7)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: _logAnother,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.photo_camera_outlined, size: 18, color: AppColors.navy),
            SizedBox(width: 8),
            Text(
              '+ Catat Barang Lainnya di Kamar 314',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}