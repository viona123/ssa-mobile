import 'package:flutter/material.dart';

import '../../agenda/agenda_screen.dart';

// ================================================================
// PUSKESMAS SHARED — warna, header, banner, & bottom navigation
// Dipakai bersama oleh seluruh sub-halaman Layanan Puskesmas.
// ================================================================

class PuskesmasColors {
  static const Color primaryGreen = Color(0xFF1B8A5A);
  static const Color mintGreen = Color(0xFFE8F5EE);
  static const Color mintGreenBorder = Color(0xFFB6E0C8);
  static const Color softGreenBg = Color(0xFFF0FAF4);
  static const Color darkText = Color(0xFF1A2B22);
  static const Color greyText = Color(0xFF6B7A72);
  static const Color pageBackground = Color(0xFFF6FAF8);
  static const Color cardBorder = Color(0xFFE2ECE7);

  // Navbar colors (identik screen lain)
  static const Color primaryBlue = Color(0xFF007EA7);
  static const Color lightBlue = Color(0xFF58D8EC);
  static const Color darkBlue = Color(0xFF315579);
}

// ================================================================
// HEADER dengan tombol back
// ================================================================
class PuskesmasHeader extends StatelessWidget {
  final String title;

  const PuskesmasHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 66,
      decoration: const BoxDecoration(
        color: PuskesmasColors.pageBackground,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE1EAE5), width: 0.7),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 22,
              color: PuskesmasColors.primaryBlue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: PuskesmasColors.primaryBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// BANNER HIJAU — reusable (judul, deskripsi, Muat Ulang, Buka Tab Baru)
// ================================================================
class PuskesmasBanner extends StatelessWidget {
  final IconData icon;
  final Widget title;
  final String description;
  final VoidCallback onReload;
  final VoidCallback onOpenTab;

  const PuskesmasBanner({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onReload,
    required this.onOpenTab,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFE8F6EE), Color(0xFFF2FBF6)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: PuskesmasColors.mintGreenBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: PuskesmasColors.mintGreen,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(icon, size: 20, color: PuskesmasColors.primaryGreen),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title,
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 11,
                        color: PuskesmasColors.greyText,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: PuskesmasBannerButton(
                  label: 'Muat Ulang',
                  icon: Icons.refresh_rounded,
                  filled: false,
                  onTap: onReload,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: PuskesmasBannerButton(
                  label: 'Buka di Tab Baru',
                  icon: Icons.open_in_new_rounded,
                  filled: true,
                  onTap: onOpenTab,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PuskesmasBannerButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;

  const PuskesmasBannerButton({
    super.key,
    required this.label,
    required this.icon,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: filled ? PuskesmasColors.primaryGreen : Colors.white,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: filled ? PuskesmasColors.primaryGreen : PuskesmasColors.cardBorder,
          ),
          boxShadow: [
            if (filled)
              BoxShadow(
                color: PuskesmasColors.primaryGreen.withValues(alpha: 0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 15,
                color: filled ? Colors.white : PuskesmasColors.primaryGreen),
            const SizedBox(width: 7),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: filled ? Colors.white : PuskesmasColors.darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================================================================
// BOTTOM NAVIGATION (identik screen lain)
// ================================================================
class PuskesmasBottomNav extends StatelessWidget {
  const PuskesmasBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: _navItem(
                context,
                Icons.home_outlined,
                Icons.home_rounded,
                'Beranda',
                false,
                () => Navigator.popUntil(context, (route) => route.isFirst),
              ),
            ),
            Expanded(
              child: _navItem(
                context,
                Icons.grid_view_rounded,
                Icons.grid_view_rounded,
                'Layanan',
                true,
                () {},
              ),
            ),
            Expanded(
              child: _navItem(
                context,
                Icons.calendar_month_outlined,
                Icons.calendar_month_rounded,
                'Agenda',
                false,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AgendaScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    IconData offIcon,
    IconData onIcon,
    String label,
    bool active,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 95,
          height: 52,
          decoration: BoxDecoration(
            color: active ? PuskesmasColors.lightBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(27),
          ),
          child: Transform.translate(
            offset: const Offset(0, -1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  active ? onIcon : offIcon,
                  size: 22,
                  color: active
                      ? PuskesmasColors.darkBlue
                      : const Color(0xFF374151),
                ),
                const SizedBox(height: 1),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                    color: active
                        ? PuskesmasColors.darkBlue
                        : const Color(0xFF374151),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
