import 'package:flutter/material.dart';
import '../../agenda/agenda_screen.dart';
import '../../bantuan/bantuan_screen.dart';
import 'reservasi_screen.dart';

class PariwisataScreen extends StatefulWidget {
  const PariwisataScreen({super.key});

  @override
  State<PariwisataScreen> createState() => _PariwisataScreenState();
}

class _PariwisataScreenState extends State<PariwisataScreen> {
  // ============================================================
  // COLORS
  // ============================================================
  static const Color primaryBlue = Color(0xFF007EA7);
  static const Color lightBlue = Color(0xFF58D8EC);
  static const Color darkBlue = Color(0xFF315579);
  static const Color darkText = Color(0xFF202124);
  static const Color greyText = Color(0xFF737B86);
  static const Color pageBackground = Color(0xFFF8FAFC);

  // ============================================================
  // DATA WISATA
  // ============================================================
  final List<WisataItem> _wisataList = [
    WisataItem(
      nama: 'Gunung Kemukus',
      gambar: 'assets/images/home/gunung_kemukus.jpg',
      deskripsi:
          'Obyek wisata religi dan ziarah dengan pemandangan alam asri di sekitar Waduk...',
      lokasi: 'Soko, Kec. Sumberlawang, Sragen',
      diskon: 'Diskon Pelajar 50%',
      harga: [
        HargaTiket(kategori: 'Hari Biasa', harga: 'Rp 5.000'),
        HargaTiket(kategori: 'Hari Libur', harga: 'Rp 6.000'),
        HargaTiket(kategori: 'Malam Jumat Pon/Kliwon', harga: 'Rp 10.000'),
      ],
    ),
    WisataItem(
      nama: 'Museum Purbakala Sangiran',
      gambar: 'assets/images/home/museum_sangiran.jpg',
      deskripsi:
          'Situs prasejarah warisan dunia UNESCO, menyimpan koleksi fosil manusia purba...',
      lokasi: 'Kalijambe, Sragen',
      harga: [
        HargaTiket(kategori: 'Hari Biasa', harga: 'Rp 15.000'),
        HargaTiket(kategori: 'Hari Libur', harga: 'Rp 15.000'),
      ],
    ),
    WisataItem(
      nama: 'Klaster Bukuran',
      gambar: 'assets/images/home/klaster_bukuran.jpg',
      deskripsi:
          'Pusat informasi evolusi manusia purba dengan sajian fosil hominid yang sangat edukatif.',
      lokasi: 'Plupuh, Sragen',
      harga: [
        HargaTiket(kategori: 'Dewasa', harga: 'Rp 15.000'),
        HargaTiket(kategori: 'Anak-anak', harga: 'Rp 10.000'),
      ],
    ),
    WisataItem(
      nama: 'Kolam Renang Kartika',
      gambar: 'assets/images/home/kolam_kartika.jpg',
      deskripsi:
          'Fasilitas olahraga dan rekreasi air keluarga dengan kolam yang bersih dan nyaman di pusat',
      lokasi: 'Sragen Kota',
      harga: [
        HargaTiket(kategori: 'Hari Biasa', harga: 'Rp 5.000'),
        HargaTiket(kategori: 'Hari Libur', harga: 'Rp 6.000'),
      ],
    ),
  ];

  // ============================================================
  // BUILD
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      bottomNavigationBar: _buildBottomNavigation(),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildHeader(context),
                Expanded(child: _buildBody()),
              ],
            ),

            // Tombol Pusat Bantuan
            Positioned(right: 26, bottom: 14, child: _buildHelpButton()),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PUSAT BANTUAN
  // ============================================================
  Widget _buildHelpButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BantuanScreen()),
        ),
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: primaryBlue,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.16),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.support_agent_rounded,
            size: 27,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HEADER — ← Layanan Pariwisata (seragam dengan layanan lain)
  // ============================================================
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 66,
      decoration: const BoxDecoration(
        color: pageBackground,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE5E7EB), width: 0.7),
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
              color: primaryBlue,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Layanan Pariwisata',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BODY
  // ============================================================
  Widget _buildBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // Header E-Ticket
          _buildETicketHeader(),

          const SizedBox(height: 16),

          // Stepper
          _buildStepper(),

          const SizedBox(height: 20),

          // Daftar Wisata
          ..._wisataList.map((wisata) => _buildWisataCard(wisata)),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ============================================================
  // E-TICKET HEADER
  // ============================================================
  Widget _buildETicketHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Badge kecil di atas judul
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00B4D8), Color(0xFF007EA7)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: primaryBlue.withValues(alpha: 0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.confirmation_number_rounded,
                    size: 15, color: Colors.white),
                SizedBox(width: 6),
                Text(
                  'TIKET WISATA ONLINE',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Judul dengan gradient
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF007EA7), Color(0xFF00B4D8), Color(0xFF58D8EC)],
            ).createShader(bounds),
            child: const Text(
              'E-Ticket Wisata Sragen',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 0.3,
                height: 1.15,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Garis dekoratif di tengah
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 26,
                height: 3,
                decoration: BoxDecoration(
                  color: lightBlue,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: primaryBlue,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 26,
                height: 3,
                decoration: BoxDecoration(
                  color: lightBlue,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Subjudul
          Text(
            'Layanan Pembelian Tiket Wisata Online Kabupaten Sragen',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: greyText.withValues(alpha: 0.9),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STEPPER (Pilih Destinasi > Isi Data > Konfirmasi > Pembayaran)
  // Gaya seragam dengan halaman Konfirmasi (ikon + garis biru).
  // ============================================================
  Widget _buildStepper() {
    final steps = [
      _StepInfo(
          label: 'Pilih Destinasi',
          icon: Icons.location_on,
          isCompleted: false,
          isActive: true),
      _StepInfo(label: 'Isi Data', icon: Icons.edit_note, isCompleted: false),
      _StepInfo(
          label: 'Konfirmasi',
          icon: Icons.description_outlined,
          isCompleted: false),
      _StepInfo(
          label: 'Pembayaran',
          icon: Icons.payment_outlined,
          isCompleted: false),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(steps.length * 2 - 1, (index) {
          if (index.isOdd) {
            final int stepBefore = index ~/ 2;
            final bool isCompletedLine = steps[stepBefore].isCompleted;
            return Expanded(
              child: Container(
                height: 3,
                color:
                    isCompletedLine ? primaryBlue : const Color(0xFFE0E0E0),
              ),
            );
          }
          return _buildStepIcon(steps[index ~/ 2]);
        }),
      ),
    );
  }

  Widget _buildStepIcon(_StepInfo step) {
    final bool filled = step.isCompleted || step.isActive;
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled ? primaryBlue : Colors.white,
            border: Border.all(
              color: filled ? primaryBlue : const Color(0xFFBDBDBD),
              width: 2,
            ),
          ),
          child: Center(
            child: Icon(
              step.icon,
              size: 18,
              color: filled ? Colors.white : const Color(0xFFBDBDBD),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          step.label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 9,
            fontWeight: filled ? FontWeight.w600 : FontWeight.w400,
            color: filled ? primaryBlue : greyText,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // WISATA CARD
  // ============================================================
  Widget _buildWisataCard(WisataItem wisata) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar
            _buildWisataImage(wisata),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Wisata
                  Text(
                    wisata.nama,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: darkText,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Divider
                  Container(
                    height: 1,
                    color: const Color(0xFFEEEEEE),
                  ),

                  const SizedBox(height: 12),

                  // Tabel Harga
                  ...wisata.harga.map((h) => _buildHargaRow(h)),

                  const SizedBox(height: 14),

                  // Deskripsi
                  Text(
                    wisata.deskripsi,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: greyText,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Lokasi
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 14,
                        color: greyText,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          wisata.lokasi,
                          style: const TextStyle(
                            fontSize: 11,
                            color: greyText,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Tombol Beli Tiket
                  _buildBeliTiketButton(wisata),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // WISATA IMAGE
  // ============================================================
  Widget _buildWisataImage(WisataItem wisata) {
    return Stack(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF76C3D4), Color(0xFF3B94A9)],
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.landscape_rounded,
              size: 60,
              color: Colors.white70,
            ),
          ),
        ),
        // Badge diskon di depan gambar
        if (wisata.diskon != null)
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B6B), Color(0xFFEE5253)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.local_offer_rounded,
                      size: 14, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(
                    wisata.diskon!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  // ============================================================
  // HARGA ROW
  // ============================================================
  Widget _buildHargaRow(HargaTiket harga) {
    // Highlight untuk kategori spesial
    final bool isSpecial = harga.kategori.contains('Malam') ||
        harga.kategori.contains('Pon') ||
        harga.kategori.contains('Kliwon');

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            harga.kategori,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSpecial ? FontWeight.w600 : FontWeight.w400,
              color: isSpecial ? primaryBlue : darkText,
            ),
          ),
          Text(
            harga.harga,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BELI TIKET BUTTON
  // ============================================================
  Widget _buildBeliTiketButton(WisataItem wisata) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ReservasiScreen(
                namaWisata: wisata.nama,
                lokasi: wisata.lokasi,
                deskripsi: wisata.deskripsi,
              ),
            ),
          );
        },
        icon: const Icon(Icons.confirmation_number_outlined, size: 18),
        label: const Text(
          'Beli Tiket',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================
  Widget _buildBottomNavigation() {
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
              child: _buildNavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                label: 'Beranda',
                active: false,
                onTap: () => Navigator.of(context).popUntil((r) => r.isFirst),
              ),
            ),
            Expanded(
              child: _buildNavItem(
                icon: Icons.grid_view_rounded,
                activeIcon: Icons.grid_view_rounded,
                label: 'Layanan',
                active: true,
                onTap: () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: _buildNavItem(
                icon: Icons.calendar_month_outlined,
                activeIcon: Icons.calendar_month_rounded,
                label: 'Agenda',
                active: false,
                onTap: () {
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

  // ============================================================
  // NAV ITEM (seragam dengan layanan lain)
  // ============================================================
  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 95,
          height: 52,
          decoration: BoxDecoration(
            color: active ? lightBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(27),
          ),
          child: Transform.translate(
            offset: const Offset(0, -1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  active ? activeIcon : icon,
                  size: 22,
                  color: active ? darkBlue : const Color(0xFF374151),
                ),
                const SizedBox(height: 1),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                    color: active ? darkBlue : const Color(0xFF374151),
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

// ================================================================
// MODEL WISATA
// ================================================================
class WisataItem {
  final String nama;
  final String gambar;
  final String deskripsi;
  final String lokasi;
  final List<HargaTiket> harga;
  final String? diskon;

  const WisataItem({
    required this.nama,
    required this.gambar,
    required this.deskripsi,
    required this.lokasi,
    required this.harga,
    this.diskon,
  });
}

class HargaTiket {
  final String kategori;
  final String harga;

  const HargaTiket({
    required this.kategori,
    required this.harga,
  });
}

// ================================================================
// STEP INFO MODEL
// ================================================================
class _StepInfo {
  final String label;
  final IconData icon;
  final bool isCompleted;
  final bool isActive;

  const _StepInfo({
    required this.label,
    required this.icon,
    required this.isCompleted,
    this.isActive = false,
  });
}
