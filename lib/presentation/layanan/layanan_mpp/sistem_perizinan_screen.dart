import 'package:flutter/material.dart';

import 'mpp_shared.dart';

// ================================================================
// SISTEM PERIZINAN ONLINE SRAGEN
// Box INFORMASI + form Cek NRP (Nomor Registrasi Permohonan).
// ================================================================

class SistemPerizinanScreen extends StatefulWidget {
  const SistemPerizinanScreen({super.key});

  @override
  State<SistemPerizinanScreen> createState() => _SistemPerizinanScreenState();
}

class _SistemPerizinanScreenState extends State<SistemPerizinanScreen> {
  static final Uri _sipionerUri =
      Uri.parse('https://sipioner.sragenkab.go.id/index');

  final TextEditingController _nrpController = TextEditingController();

  @override
  void dispose() {
    _nrpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MppColors.pageBackground,
      bottomNavigationBar: const MppBottomNav(),
      body: SafeArea(
        child: Column(
          children: [
            const MppHeader(title: 'Sistem Perizinan Online'),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 32),
                child: Column(
                  children: [
                    const MppHero(),
                    const SizedBox(height: 22),
                    _buildInformasi(),
                    const SizedBox(height: 16),
                    _buildCekNrp(),
                    const SizedBox(height: 16),
                    _buildOpenPortalLink(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInformasi() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF4FE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC5DFF8)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, size: 20, color: MppColors.primaryBlue),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'INFORMASI!',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: MppColors.darkBlue,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Bagi Anda yang sedang mengajukan permohonan perizinan di '
                  'DPMPTSP Kabupaten Sragen, Anda dapat melacak posisi terakhir '
                  'dari permohonan Anda melalui form berikut:',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: MppColors.darkBlue,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCekNrp() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: MppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'CEK NRP (NOMOR REGISTRASI PERMOHONAN)',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: MppColors.darkText,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: MppColors.cardBorder),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search_rounded,
                          size: 19, color: MppColors.greyText),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _nrpController,
                          style: const TextStyle(
                              fontSize: 14, color: MppColors.darkText),
                          textInputAction: TextInputAction.search,
                          onSubmitted: (_) => _lacak(),
                          decoration: const InputDecoration(
                            isCollapsed: true,
                            border: InputBorder.none,
                            hintText: 'Contoh: R26-060026',
                            hintStyle: TextStyle(
                                fontSize: 14, color: Color(0xFFB0B7BF)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: _lacak,
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: MppColors.cyan,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: MppColors.cyan.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Lacak',
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOpenPortalLink() {
    return GestureDetector(
      onTap: () => openMppUrl(context, _sipionerUri),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF7FC),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFC4E4EF)),
        ),
        child: const Row(
          children: [
            Icon(Icons.language_rounded, size: 18, color: MppColors.primaryBlue),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Buka portal SIPIONER Kabupaten Sragen',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: MppColors.darkText,
                ),
              ),
            ),
            Icon(Icons.open_in_new_rounded, size: 16, color: MppColors.primaryBlue),
          ],
        ),
      ),
    );
  }

  void _lacak() {
    if (_nrpController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Masukkan Nomor Registrasi Permohonan (NRP) terlebih dahulu.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    FocusScope.of(context).unfocus();
    openMppUrl(context, _sipionerUri);
  }
}
