import 'package:flutter/material.dart';

import '../widgets/onboarding_page_item.dart';
import 'login_screen.dart';

const _navy = Color(0xFF1E3A8A);
const _orange = Color(0xFFFF9F1C);

/// Alur Onboarding via [PageView].
///
/// Screen ini hanya menangani logika navigasi: [PageController], indikator
/// dots, serta tombol Skip/Next/Back/Get Started. Tampilan tiap slide
/// dirender oleh [OnboardingPageItem].
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  static const _slides = [
    OnboardingSlide(
      badge: '12,400+ items reunited',
      icon: Icons.key_rounded,
      pill: 'COMMUNITY-POWERED & SECURE',
      title: 'Lost something?\nLet\'s go find it.',
      desc: 'Report it in seconds and let smart radar matching do the searching with your local neighborhood.',
    ),
    OnboardingSlide(
      badge: 'ZERO SPAM & VERIFIED',
      icon: Icons.verified_user_outlined,
      pill: 'PRIVACY FIRST MATCHING',
      title: 'Your info stays safe.',
      desc: 'Contact details unlock only after both sides confirm a genuine recovery match.',
      showInfo: true,
    ),
    OnboardingSlide(
      badge: '98.4% RECOVERY RATE • CAMPUS & TRANSIT',
      icon: Icons.groups_outlined,
      pill: 'NEIGHBORHOOD NETWORK',
      title: 'A community that returns things.',
      desc: 'Thousands of items reunited by people just like you. Welcome to a kinder way to find what matters.',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    _controller.nextPage(duration: const Duration(milliseconds: 320), curve: Curves.easeOutCubic);
  }

  void _back() {
    _controller.previousPage(duration: const Duration(milliseconds: 320), curve: Curves.easeOutCubic);
  }

  void _goToLogin() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _page == _slides.length - 1;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (i) => setState(() => _page = i),
              children: [for (final slide in _slides) OnboardingPageItem(slide: slide)],
            ),
          ),
          _bottomBar(isLast: isLast),
        ],
      ),
    );
  }

  Widget _bottomBar({required bool isLast}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Indicator(activeIndex: _page),
          const SizedBox(height: 16),
          if (_page == 0)
            Row(
              children: [
                Expanded(child: _skipButton()),
                const SizedBox(width: 10),
                Expanded(flex: 2, child: _primaryButton('Next ➔', _next)),
              ],
            )
          else if (_page == 1)
            Row(
              children: [
                Expanded(child: _backButton()),
                const SizedBox(width: 12),
                Expanded(flex: 2, child: _primaryButton('Next ➔', _next)),
              ],
            )
          else ...[
            _primaryButton('Get Started ➔', _goToLogin),
            const SizedBox(height: 4),
            Center(
              child: TextButton(
                onPressed: _goToLogin,
                child: const Text(
                  'Already have an account? Log in',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _navy),
                ),
              ),
            ),
          ],
          if (isLast) const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _skipButton() {
    return SizedBox(
      height: 54,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF334155),
          side: const BorderSide(color: Color(0xFFE2E8F0)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: () => _controller.jumpToPage(_slides.length - 1),
        child: const Text('Skip', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _backButton() {
    return SizedBox(
      height: 54,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF334155),
          side: const BorderSide(color: Color(0xFFE2E8F0)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: _back,
        child: const Text('Back', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _primaryButton(String label, VoidCallback onPressed) {
    return SizedBox(
      height: 54,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: _orange,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({required this.activeIndex});

  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < 3; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: i == activeIndex ? 30 : 8,
            height: 6,
            decoration: BoxDecoration(
              color: i == activeIndex ? _orange : const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
      ],
    );
  }
}