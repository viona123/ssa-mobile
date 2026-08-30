import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'puskesmas_shared.dart';

// ================================================================
// PORTAL KLINISIA (ONLINE)
// Pendaftaran Antrean & Rekam Medis Digital.
// Buka di Tab Baru -> https://klinisia.infokes.id/
// ================================================================

class PortalKlinisiaScreen extends StatelessWidget {
  const PortalKlinisiaScreen({super.key});

  static final Uri _url = Uri.parse('https://klinisia.infokes.id/');

  Future<void> _open(BuildContext context) async {
    final bool launched =
        await launchUrl(_url, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak dapat membuka portal Klinisia.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PuskesmasColors.pageBackground,
      bottomNavigationBar: const PuskesmasBottomNav(),
      body: SafeArea(
        child: Column(
          children: [
            const PuskesmasHeader(title: 'Portal Klinisia'),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 18, bottom: 28),
                child: Column(
                  children: [
                    PuskesmasBanner(
                      icon: Icons.important_devices_rounded,
                      title: const Text(
                        'Pendaftaran Antrean & Rekam Medis Digital Klinisia',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: PuskesmasColors.darkText,
                        ),
                      ),
                      description:
                          'Pilih Puskesmas tujuan Anda, pesan antrean poli dari rumah, '
                          'dan pantau nomor panggilan secara realtime.',
                      onReload: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Portal Klinisia dimuat ulang.'),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      onOpenTab: () => _open(context),
                    ),
                    const SizedBox(height: 16),
                    _buildPortalCard(context),
                    const SizedBox(height: 18),
                    _buildFooter(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PORTAL CARD — meniru embed website Klinisia (form Cek Riwayat)
  // ============================================================
  Widget _buildPortalCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: PuskesmasColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: PuskesmasColors.cardBorder)),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2EC76B),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Portal Resmi Klinisia Infokes Indonesia',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: PuskesmasColors.darkText,
                        ),
                      ),
                      Text(
                        'https://klinisia.infokes.id',
                        style: TextStyle(
                            fontSize: 10, color: PuskesmasColors.greyText),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _open(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: PuskesmasColors.cardBorder),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.open_in_full_rounded,
                            size: 12, color: PuskesmasColors.greyText),
                        SizedBox(width: 5),
                        Text(
                          'Layar Penuh',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: PuskesmasColors.darkText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: _buildCekRiwayatForm(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCekRiwayatForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cek Riwayat Kunjungan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: PuskesmasColors.darkText,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _stepBadge('1', 'Verifikasi Data', active: true),
            Expanded(
              child: Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                color: PuskesmasColors.cardBorder,
              ),
            ),
            _stepBadge('2', 'Riwayat Kunjungan', active: false),
          ],
        ),
        const SizedBox(height: 20),
        _fieldLabel('Nomor Induk Kependudukan (NIK)', required: true),
        const SizedBox(height: 6),
        _mockTextField('Nomor Induk Kependudukan (NIK)', focused: true),
        const SizedBox(height: 14),
        _fieldLabel('Nomor Rekam Medis', required: true),
        const SizedBox(height: 6),
        _mockTextField('Nomor Rekam Medis'),
        const SizedBox(height: 4),
        const Text(
          'Sesuai kartu berobat',
          style: TextStyle(fontSize: 10.5, color: PuskesmasColors.greyText),
        ),
        const SizedBox(height: 14),
        _buildCaptcha(),
        const SizedBox(height: 18),
        Row(
          children: [
            GestureDetector(
              onTap: () => _open(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
                decoration: BoxDecoration(
                  color: const Color(0xFF7B8BF5),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Text(
                  'Cari Riwayat',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: PuskesmasColors.cardBorder),
              ),
              child: const Text(
                'Reset',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: PuskesmasColors.darkText,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Align(
          alignment: Alignment.centerRight,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Powered by ',
                  style:
                      TextStyle(fontSize: 11, color: PuskesmasColors.greyText),
                ),
                TextSpan(
                  text: 'infoKes',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF7B8BF5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _stepBadge(String number, String label, {required bool active}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? const Color(0xFF7B8BF5) : const Color(0xFFE4E7EC),
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: active ? Colors.white : PuskesmasColors.greyText,
            ),
          ),
        ),
        const SizedBox(width: 7),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            color: active ? PuskesmasColors.darkText : PuskesmasColors.greyText,
          ),
        ),
      ],
    );
  }

  Widget _fieldLabel(String label, {bool required = false}) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: PuskesmasColors.primaryGreen,
            ),
          ),
          if (required)
            const TextSpan(
              text: '*',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFFD92D2D),
              ),
            ),
        ],
      ),
    );
  }

  Widget _mockTextField(String hint, {bool focused = false}) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: focused ? const Color(0xFF7B8BF5) : PuskesmasColors.cardBorder,
          width: focused ? 1.5 : 1,
        ),
      ),
      child: Text(
        hint,
        style: const TextStyle(fontSize: 12.5, color: Color(0xFFB0B7BF)),
      ),
    );
  }

  Widget _buildCaptcha() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFB),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: PuskesmasColors.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFFC4C9CF)),
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Verifikasi bahwa Anda adalah manusia',
              style: TextStyle(fontSize: 11.5, color: PuskesmasColors.darkText),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(Icons.cloud_rounded,
                  size: 18, color: Color(0xFFE0A118)),
              const Text(
                'CLOUDFLARE',
                style: TextStyle(
                  fontSize: 6.5,
                  fontWeight: FontWeight.w700,
                  color: PuskesmasColors.greyText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: PuskesmasColors.softGreenBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: PuskesmasColors.mintGreenBorder),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified_rounded,
              size: 16, color: PuskesmasColors.primaryGreen),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Terhubung dengan ekosistem kesehatan digital Pemerintah Kabupaten Sragen.',
              style: TextStyle(
                  fontSize: 11, color: PuskesmasColors.darkText, height: 1.4),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _open(context),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Kunjungi',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: PuskesmasColors.primaryGreen,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward_rounded,
                    size: 14, color: PuskesmasColors.primaryGreen),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
