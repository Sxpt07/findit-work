import 'package:flutter/material.dart';

const _navyDark = Color(0xFF0A192F);
const _navy = Color(0xFF1E3A8A);

/// Data satu slide Onboarding.
class OnboardingSlide {
  const OnboardingSlide({
    required this.badge,
    required this.icon,
    required this.pill,
    required this.title,
    required this.desc,
    this.showInfo = false,
  });

  final String badge;
  final IconData icon;
  final String pill;
  final String title;
  final String desc;
  final bool showInfo;
}

/// Layout/item untuk satu slide Onboarding di dalam [PageView].
///
/// Berisi header gradasi (badge + ilustrasi) dan card putih (pill, judul,
/// deskripsi, info box opsional). Navigasi (dots/Next/Skip) ditangani oleh
/// screen pemanggil.
class OnboardingPageItem extends StatelessWidget {
  const OnboardingPageItem({super.key, required this.slide});

  final OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [_navyDark, _navy],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: _Badge(slide.badge),
                    ),
                    Expanded(child: Center(child: _Illustration(icon: slide.icon))),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(28, 24, 28, 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [_Pill(slide.pill)]),
              const SizedBox(height: 14),
              Text(
                slide.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w800, height: 1.15, color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 10),
              Text(
                slide.desc,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, height: 1.4, color: Color(0xFF64748B)),
              ),
              if (slide.showInfo) ...[
                const SizedBox(height: 16),
                const _InfoBox(),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EDFB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.5, color: _navy),
      ),
    );
  }
}

class _Illustration extends StatelessWidget {
  const _Illustration({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(width: 210, height: 210, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0x33FFFFFF))),
        Container(width: 160, height: 160, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0x26FFFFFF))),
        Container(
          width: 104,
          height: 104,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 18, offset: const Offset(0, 8)),
            ],
          ),
          child: Icon(icon, size: 46, color: _navy),
        ),
      ],
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF3FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCE4FB)),
      ),
      child: const Row(
        children: [
          Icon(Icons.lock_outline, size: 18, color: _navy),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Phone & address masked by default',
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
            ),
          ),
        ],
      ),
    );
  }
}