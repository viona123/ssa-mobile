import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ketenagakerjaan_data.dart';

// ================================================================
// DETAIL LOWONGAN KERJA
// Desain mengikuti context/lowongan.png (mobile native).
// ================================================================

class KetenagakerjaanDetailScreen extends StatelessWidget {
  final JobItem job;

  const KetenagakerjaanDetailScreen({super.key, required this.job});

  static const Color _appBlue = Color(0xFF127BB5);
  static const Color _deepBlue = Color(0xFF0E5C8A);
  static const Color _ink = Color(0xFF1B2430);
  static const Color _smoke = Color(0xFF6B7683);
  static const Color _bg = Color(0xFFF7F9FB);
  static const Color _cardBorder = Color(0xFFE3E9EF);
  static const Color _greenPill = Color(0xFF2BD48A);
  static const Color _sectionBox = Color(0xFFF1F4F7);
  static const Color _badgePillBg = Color(0xFFE8EFF5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ID + STATUS
                    Row(
                      children: [
                        _pill('Lowongan ID: #${job.id}', _badgePillBg, _deepBlue),
                        const SizedBox(width: 8),
                        if (job.aktif) _statusPill(),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // TITLE
                    Text(
                      job.title.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: _ink,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 18),
                    // DATE CARDS
                    Row(
                      children: [
                        Expanded(
                          child: _dateCard(
                            icon: Icons.calendar_today_rounded,
                            iconColor: _appBlue,
                            label: 'Pendaftaran Mulai',
                            value: job.awal,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _dateCard(
                            icon: Icons.event_busy_rounded,
                            iconColor: const Color(0xFFD92D2D),
                            label: 'Batas Akhir',
                            value: job.akhir,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),

                    // DESKRIPSI PEKERJAAN
                    _sectionTitle(Icons.description_rounded, 'DESKRIPSI PEKERJAAN'),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _sectionBox,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        job.description,
                        style: const TextStyle(
                          fontSize: 13.5,
                          color: _ink,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // PERSYARATAN PELAMAR
                    _sectionTitle(
                        Icons.checklist_rounded, 'PERSYARATAN PELAMAR'),
                    const SizedBox(height: 12),
                    _buildRequirements(),
                    const SizedBox(height: 24),

                    // FLYER BROSUR
                    _sectionTitle(Icons.image_rounded, 'FLYER BROSUR'),
                    const SizedBox(height: 12),
                    _buildFlyer(),
                    const SizedBox(height: 24),

                    // CARA MELAMAR / KONTAK
                    _sectionTitle(
                        Icons.help_outline_rounded, 'CARA MELAMAR / KONTAK'),
                    const SizedBox(height: 12),
                    _buildContact(context),
                  ],
                ),
              ),
            ),
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: _cardBorder, width: 0.8)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_rounded,
                size: 24, color: _deepBlue),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'Lowongan Kerja',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: _deepBlue,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _share(context),
            child: const Icon(Icons.share_rounded, size: 22, color: _deepBlue),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STATUS PILL
  // ============================================================
  Widget _statusPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _greenPill,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: Color(0xFF0B7A4B),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'PENDAFTARAN DIBUKA',
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pill(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: fg,
        ),
      ),
    );
  }

  // ============================================================
  // DATE CARD
  // ============================================================
  Widget _dateCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 7),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: iconColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: _ink,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================
  Widget _sectionTitle(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: _appBlue),
        const SizedBox(width: 9),
        Text(
          text,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: _appBlue,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PERSYARATAN PELAMAR
  // ============================================================
  Widget _buildRequirements() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _cardBorder),
      ),
      child: Column(
        children: [
          // intro
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _numberBadge('!'),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Silakan siapkan dokumen asli berikut saat penyerahan:',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: _ink,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(job.requirements.length, (i) {
            return Column(
              children: [
                const Divider(height: 1, color: _cardBorder),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _numberBadge('${i + 1}'.padLeft(2, '0')),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          job.requirements[i],
                          style: const TextStyle(
                            fontSize: 14,
                            color: _ink,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
          const Divider(height: 1, color: _cardBorder),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Icon(Icons.folder_open_rounded, size: 17, color: _appBlue),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Bawa berkas dalam map plastik bening.',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: _smoke,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _numberBadge(String n) {
    return Container(
      width: 26,
      height: 26,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: _badgePillBg,
        shape: BoxShape.circle,
      ),
      child: Text(
        n,
        style: const TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w800,
          color: _deepBlue,
        ),
      ),
    );
  }

  // ============================================================
  // FLYER BROSUR (tidak tersedia)
  // ============================================================
  Widget _buildFlyer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _cardBorder),
      ),
      child: const Column(
        children: [
          Icon(Icons.hide_image_rounded, size: 40, color: Color(0xFFB8C2CC)),
          SizedBox(height: 12),
          Text(
            'Flyer tidak tersedia untuk lowongan ini.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: _smoke),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CARA MELAMAR / KONTAK
  // ============================================================
  Widget _buildContact(BuildContext context) {
    return Column(
      children: [
        // EMAIL CARD
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _cardBorder),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _deepBlue,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(Icons.mail_rounded,
                    size: 21, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email Perusahaan:',
                      style: TextStyle(fontSize: 12, color: _smoke),
                    ),
                    const SizedBox(height: 2),
                    GestureDetector(
                      onTap: () => _sendEmail(context),
                      child: Text(
                        job.email,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: _deepBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // INFO BOX
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF3F9),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_rounded, size: 18, color: Color(0xFF2E9E6B)),
              SizedBox(width: 10),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Informasi Tambahan: ',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: _ink,
                          height: 1.45,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Pastikan Anda melampirkan berkas lamaran yang lengkap '
                            'dan valid sebelum batas pendaftaran berakhir.',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: _ink,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // BOTTOM BAR — Tutup + Kirim Lamaran
  // ============================================================
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: _cardBorder, width: 0.8)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // TUTUP
            Expanded(
              flex: 4,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF2F5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Text(
                    'Tutup',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // KIRIM LAMARAN
            Expanded(
              flex: 7,
              child: GestureDetector(
                onTap: () => _sendEmail(context),
                child: Container(
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _deepBlue,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: _deepBlue.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.mail_outline_rounded,
                          size: 19, color: Colors.white),
                      SizedBox(width: 9),
                      Text(
                        'Kirim Lamaran',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ACTIONS
  // ============================================================
  Future<void> _sendEmail(BuildContext context) async {
    final uri = Uri(
      scheme: 'mailto',
      path: job.email,
      queryParameters: {
        'subject': 'Lamaran Pekerjaan - ${job.title} (ID #${job.id})',
      },
    );
    final launched =
        await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tidak dapat membuka email. Kirim ke: ${job.email}'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _share(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Bagikan lowongan: ${job.title} (ID #${job.id})'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
