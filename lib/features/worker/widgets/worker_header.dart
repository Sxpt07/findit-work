import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Header profil atas berlatar biru `#00236F` untuk semua halaman Worker.
///
/// Struktur: leading opsional (logo/back/search), judul + subtitle, dan
/// trailing avatar profil.
class WorkerHeader extends StatelessWidget {
  const WorkerHeader({
    super.key,
    this.title = 'Find It! — Petugas',
    this.subtitle = 'Grand Melia Jakarta • Shift Pagi',
    this.extra,
    this.leading,
    this.showBack = false,
    this.showSearch = false,
    this.onBack,
    this.trailing,
  });

  final String? title;
  final String? subtitle;
  final String? extra;
  final Widget? leading;
  final bool showBack;
  final bool showSearch;
  final VoidCallback? onBack;
  final Widget? trailing;

  Widget? _buildLeading() {
    if (leading != null) return leading;
    if (showBack) {
      return IconButton(
        onPressed: onBack,
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
        padding: EdgeInsets.zero,
      );
    }
    if (showSearch) {
      return Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: const Icon(Icons.search, color: AppColors.navy, size: 20),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final leadingWidget = _buildLeading();
    return Container(
      width: double.infinity,
      color: AppColors.navy,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            if (leadingWidget != null) ...[leadingWidget, const SizedBox(width: 10)],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(subtitle!, style: const TextStyle(color: Colors.white70, fontSize: 11)),
                  ],
                  if (extra != null) ...[
                    const SizedBox(height: 2),
                    Text(extra!, style: const TextStyle(color: Colors.white60, fontSize: 10)),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing! else const WorkerHeaderAvatar(),
          ],
        ),
      ),
    );
  }
}

/// Avatar profil lingkaran putih dengan ikon person.
class WorkerHeaderAvatar extends StatelessWidget {
  const WorkerHeaderAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: const Icon(Icons.person_outline, color: AppColors.navy, size: 22),
    );
  }
}

/// Blok logo "Find It!" + tulisan LOST & FOUND untuk leading dashboard.
class WorkerBrandLogo extends StatelessWidget {
  const WorkerBrandLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.explore_outlined, color: AppColors.navy, size: 17),
            ),
            const SizedBox(width: 8),
            const Text(
              'Find It!',
              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const SizedBox(height: 2),
        const Text(
          'LOST & FOUND',
          style: TextStyle(color: Colors.white70, fontSize: 8, fontWeight: FontWeight.w700, letterSpacing: 1),
        ),
      ],
    );
  }
}