import 'package:flutter/material.dart';
import '../../agenda/agenda_screen.dart';
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
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(child: _buildBody()),
          ],
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

          // Search Bar
          _buildSearchBar(),

          const SizedBox(height: 20),

          // Header E-Ticket
          _buildETicketHeader(),

          const SizedBox(height: 16),

          // Stepper
          _buildStepper(),

          const SizedBox(height: 16),

          // Diskon Banner
          _buildDiskonBanner(),

          const SizedBox(height: 20),

          // Daftar Wisata
          ..._wisataList.map((wisata) => _buildWisataCard(wisata)),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ============================================================
  // SEARCH BAR
  // ============================================================
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE0E0E0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Row(
          children: [
            SizedBox(width: 14),
            Icon(Icons.search, size: 22, color: greyText),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Cari destinasi wisata...',
                style: TextStyle(
                  fontSize: 14,
                  color: greyText,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'E-Ticket Wisata Sragen',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: darkText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Layanan Pembelian Tiket Wisata Online Kabupaten Sragen',
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
  // ============================================================
  Widget _buildStepper() {
    final steps = ['Pilih Destinasi', 'Isi Data', 'Konfirmasi', 'Pembayaran'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(steps.length, (index) {
          final bool isActive = index == 0;
          return Expanded(
            child: Row(
              children: [
                if (index > 0)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: const Color(0xFFE0E0E0),
                    ),
                  ),
                Column(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive ? primaryBlue : Colors.white,
                        border: Border.all(
                          color: isActive ? primaryBlue : const Color(0xFFE0E0E0),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: isActive
                            ? const Icon(Icons.circle, size: 10, color: Colors.white)
                            : Icon(Icons.circle,
                                size: 8, color: const Color(0xFFE0E0E0)),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      steps[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight:
                            isActive ? FontWeight.w600 : FontWeight.w400,
                        color: isActive ? primaryBlue : greyText,
                      ),
                    ),
                  ],
                ),
                if (index < steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: const Color(0xFFE0E0E0),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ============================================================
  // DISKON BANNER
  // ============================================================
  Widget _buildDiskonBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF00B4D8),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00B4D8).withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Text(
            'Diskon Pelajar 50% • Gunung Kemukus',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
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
    return Container(
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

  const WisataItem({
    required this.nama,
    required this.gambar,
    required this.deskripsi,
    required this.lokasi,
    required this.harga,
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
