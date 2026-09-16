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
    this.subtitle = 'Grand Meliá Jakarta',
    this.leading,
    this.showBack = false,
    this.showSearch = false,
    this.onBack,
    this.trailing,
    this.onAvatarTap,
  });

  final String? title;
  final String? subtitle;
  final Widget? leading;
  final bool showBack;
  final bool showSearch;
  final VoidCallback? onBack;
  final Widget? trailing;
  final VoidCallback? onAvatarTap;

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leadingWidget != null) ...[leadingWidget, const SizedBox(width: 10)],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 11),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            if (trailing != null) trailing! else WorkerHeaderAvatar(onTap: onAvatarTap),
          ],
        ),
      ),
    );
  }
}

/// Avatar profil lingkaran putih dengan ikon person.
class WorkerHeaderAvatar extends StatelessWidget {
  const WorkerHeaderAvatar({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: const Icon(Icons.person_outline, color: AppColors.navy, size: 22),
      ),
    );
  }
}

/// Blok logo "Find It!" untuk leading/trailing header Worker.
class WorkerBrandLogo extends StatelessWidget {
  const WorkerBrandLogo({super.key, this.height = 44});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo-light.png',
      height: height,
      fit: BoxFit.contain,
    );
  }
}