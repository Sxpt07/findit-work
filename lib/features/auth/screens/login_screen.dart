import 'package:flutter/material.dart';

import '../../worker/screens/worker_dashboard_screen.dart';
import '../widgets/auth_text_field.dart';

const _darkNavy = Color(0xFF0A192F);
const _navy = Color(0xFF1E3A8A);
const _orange = Color(0xFFFF9F1C);

/// Halaman Login internal petugas (FindIt! Worker).
///
/// Menyusun layout utama: header gradasi + card form. Field memakai
/// [AuthTextField]; login langsung membawa ke dashboard.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController(text: 'HK-84920');
  final _pinController = TextEditingController();
  bool _obscurePin = true;

  @override
  void dispose() {
    _idController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  String? Function(String?) _required(String message) {
    return (v) => (v == null || v.trim().isEmpty) ? message : null;
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const WorkerDashboardScreen()),
    );
  }

  void _showForgotPinDialog() {
    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 24, 22, 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F3FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.lock_reset, size: 24, color: Color(0xFF00236F)),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Lupa PIN / Password?',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF00236F),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Demi keamanan sistem internal hotel, pembuatan ulang (reset) PIN atau password hanya dapat dilakukan oleh Admin HR / Supervisor Front Office.',
                  style: TextStyle(fontSize: 12, height: 1.5, color: Color(0xFF334155)),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Cara Reset',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 8),
              _stepList(
                '1',
                'Hubungi Admin HR / FO Supervisor di ekstensi 101/102.',
              ),
              const SizedBox(height: 6),
              _stepList(
                '2',
                'Sertakan ID Karyawan Anda.',
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFFEA619),
                    foregroundColor: const Color(0xFF00236F),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text(
                    'Tutup & Mengerti',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stepList(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF00236F),
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12, height: 1.5, color: Color(0xFF334155)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkNavy,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            Transform.translate(
              offset: const Offset(0, -22),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _card(),
              ),
            ),
            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_darkNavy, _navy],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 34, 24, 52),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo-light.png',
                  height: 76,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Akses Internal Petugas',
                style: TextStyle(color: Colors.white70, fontSize: 12.5, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: _navy.withValues(alpha: 0.12), blurRadius: 24, offset: const Offset(0, 10)),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Login Petugas',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 4),
            const Text(
              'Masuk dengan ID Karyawan & PIN Anda',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 22),
            AuthTextField(
              controller: _idController,
              hint: 'ID Karyawan (HK-84920)',
              icon: Icons.badge_outlined,
              textInputAction: TextInputAction.next,
              suffix: const Icon(Icons.check_circle, size: 20, color: _orange),
              validator: _required('ID Karyawan wajib diisi'),
            ),
            const SizedBox(height: 14),
            AuthTextField(
              controller: _pinController,
              hint: 'Password / PIN',
              icon: Icons.lock_outline,
              obscureText: _obscurePin,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _login(),
              suffix: IconButton(
                icon: Icon(
                  _obscurePin ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  size: 20,
                  color: const Color(0xFF64748B),
                ),
                onPressed: () => setState(() => _obscurePin = !_obscurePin),
              ),
              validator: _required('Password / PIN wajib diisi'),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _showForgotPinDialog,
                style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 6)),
                child: const Text('Lupa PIN?', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _orange)),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 54,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: _orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: _login,
                child: const Text('Masuk ➔', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              ),
            ),
            const SizedBox(height: 14),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 14, color: Color(0xFF94A3B8)),
                SizedBox(width: 6),
                Text(
                  'Login internal — akun petugas resmi',
                  style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8), fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}