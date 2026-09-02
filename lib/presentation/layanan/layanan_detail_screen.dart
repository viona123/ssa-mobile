import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'service_catalog.dart';

class LayananDetailScreen extends StatelessWidget {
  final ServiceCategory category;

  const LayananDetailScreen({super.key, required this.category});

  // ============================================================
  // COLORS
  // ============================================================
  static const Color _primaryBlue = Color(0xFF007EA7);
  static const Color _pageBackground = Color(0xFFF8FAFC);
  static const Color _darkText = Color(0xFF202124);
  static const Color _greyText = Color(0xFF737B86);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                child: Column(
                  children: [
                    _buildCategoryHeader(),
                    const SizedBox(height: 24),
                    _buildServiceList(),
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
  // APP BAR
  // ============================================================
  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: _pageBackground,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE8EDF2)),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 16,
                color: _darkText,
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Text(
            'Detail Layanan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CATEGORY HEADER — Card besar di atas dengan icon & deskripsi
  // ============================================================
  Widget _buildCategoryHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8EDF2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon kategori besar
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: category.iconBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              category.icon,
              size: 28,
              color: category.iconColor,
            ),
          ),
          const SizedBox(width: 16),
          // Nama & deskripsi
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: _darkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category.subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: _greyText,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SERVICE LIST — Daftar layanan dalam card terpisah
  // ============================================================
  Widget _buildServiceList() {
    return Column(
      children: category.services.map((service) {
        return _buildServiceCard(service);
      }).toList(),
    );
  }

  // ============================================================
  // SERVICE CARD — Mirip design di gambar kategori3.png
  // Card putih dengan border kiri kuning, icon bulat berwarna,
  // nama layanan, subtitle, dan tombol "Buka" di kanan
  // ============================================================
  Widget _buildServiceCard(ServiceItem service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8EDF2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Border kiri kuning/amber (seperti di gambar)
            Container(
              width: 4,
              decoration: const BoxDecoration(
                color: Color(0xFFFFBB33),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
            // Content utama
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    // Icon bulat berwarna
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: service.iconBackground.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        service.icon,
                        size: 22,
                        color: service.iconBackground,
                      ),
                    ),
                    const SizedBox(width: 14),
                    // Nama & subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            service.title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _darkText,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            service.subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: _greyText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Tombol "Buka" dengan icon external link
                    _buildOpenButton(service),
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
  // TOMBOL BUKA — Teks "Buka" + icon open_in_new (seperti gambar)
  // ============================================================
  Widget _buildOpenButton(ServiceItem service) {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () => _onServiceTap(context, service),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Buka',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _primaryBlue,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _primaryBlue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.open_in_new_rounded,
                  size: 15,
                  color: _primaryBlue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // SERVICE TAP HANDLER
  // ============================================================
  void _onServiceTap(BuildContext context, ServiceItem service) {
    if (service.url.isNotEmpty) {
      _openExternalUrl(context, Uri.parse(service.url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Membuka ${service.title}...'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // ============================================================
  // OPEN EXTERNAL URL
  // ============================================================
  Future<void> _openExternalUrl(BuildContext context, Uri uri) async {
    final bool launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak dapat membuka tautan layanan.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
