import 'package:flutter/material.dart';
import '../../agenda/agenda_screen.dart';
import '../../bantuan/bantuan_screen.dart';

// ================================================================
// BUS SEKOLAH SCREEN
// Pixel-perfect dari Figma node #241:898 "Layanan Bus Sekolah 1"
// File: LxkxrZvquf2znDJef2FqEe
// ================================================================

class BusSekolahScreen extends StatefulWidget {
  const BusSekolahScreen({super.key});

  @override
  State<BusSekolahScreen> createState() => _BusSekolahScreenState();
}

class _BusSekolahScreenState extends State<BusSekolahScreen>
    with SingleTickerProviderStateMixin {

  // ============================================================
  // PALETTE — exact dari Figma
  // ============================================================

  // Background halaman #F9F9FF
  static const Color _pageBg     = Color(0xFFF9F9FF);
  // Biru utama #006098
  static const Color _blue       = Color(0xFF006098);
  // Text gelap #111C2C
  static const Color _textDark   = Color(0xFF111C2C);
  // Text abu #404851
  static const Color _textMid    = Color(0xFF404851);
  // ignore: unused_field
  static const Color _textLight  = Color(0xFF3E484F);
  // Border abu #BFC7D2
  static const Color _border     = Color(0xFFBFC7D2);
  // Putih
  static const Color _white      = Color(0xFFFFFFFF);

  // Dot jalur (dari Figma exact)
  static const Color _dot1 = Color(0xFF006098); // Jalur 1 active bg
  static const Color _dot2 = Color(0xFF4ADE80); // Jalur 2 hijau
  static const Color _dot3 = Color(0xFFFACC15); // Jalur 3 kuning
  static const Color _dot4 = Color(0xFFFA1915); // Jalur 4 merah
  static const Color _dot5 = Color(0xFFFA15EF); // Jalur 5 magenta

  // Auto-follow button: bg #7BF8A1, icon+text #007239
  static const Color _autoFollowBg   = Color(0xFF7BF8A1);
  static const Color _autoFollowText = Color(0xFF007239);

  // Muat ulang: bg #E7EEFF, icon+text #404851
  static const Color _reloadBg       = Color(0xFFE7EEFF);

  // Badge Aktif: bg #7EFBA4, text #00210C
  static const Color _aktifBg        = Color(0xFF7EFBA4);
  static const Color _aktifText      = Color(0xFF00210C);

  // GPS dot: #006D37
  static const Color _gpsDot         = Color(0xFF006D37);
  // GPS text: #007239
  static const Color _gpsText        = Color(0xFF007239);

  // Map overlay label: rgba(0,96,152,0.9)
  static const Color _mapLabelBg     = Color(0xE6006098);

  // Section map bg: #F0F3FF
  static const Color _mapBg          = Color(0xFFF0F3FF);

  // Progress bar track: #DEE8FF
  static const Color _progressTrack  = Color(0xFFDEE8FF);

  // Stop aktif: #007ABE
  static const Color _stopAktif      = Color(0xFF007ABE);
  // Stop abu: #96989A
  static const Color _stopGrey       = Color(0xFF96989A);
  // Vertical line: #DEE8FF
  static const Color _stopLine       = Color(0xFFDEE8FF);

  // Navbar aktif bg: #58E6FF, text: #006573
  // ignore: unused_field
  static const Color _navActive      = Color(0xFF58E6FF);
  // ignore: unused_field
  static const Color _navActiveText  = Color(0xFF006573);
  // ignore: unused_field
  static const Color _navInactiveText= Color(0xFF3E484F);

  // Navbar — identik home_screen
  static const Color _tealLight  = Color(0xFF58D8EC);
  static const Color _navyDark   = Color(0xFF315579);

  // ============================================================
  // STATE
  // ============================================================

  int _sel = 0; // jalur terpilih

  late AnimationController _pulseCtrl;
  late Animation<double>   _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);
    _pulseAnim = CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  // ============================================================
  // DATA — dari Figma
  // ============================================================

  static const List<_JalurInfo> _jalurs = [
    _JalurInfo(
      nama:    'Jalur 1',
      koridor: 'Koridor Tunjungan - Kota Sragen',
      dot:     _dot1,
      aktif:   true,
      stops: [
        'Titik Awal',
        'SPBU Tunjungan',
        'Simpang 4 Paldaplang',
        'Simpang 4 Pilangsari',
        'PMI Kab.Sragen',
        'SMA N 1 Sragen',
        'SMK N 1 Sragen',
        'SMK N 2 Sragen',
        'SMP Muhammadiyah 1 Sragen',
        'SMP N 1 Sragen',
        'Simpang 3 Alfamidi Sukowati',
        'SMK N2/SMA N 3 Sragen',
        'SMP N 6 Sragen',
        'MTS N 5 Sragen',
        'Titik Akhir',
      ],
      stopAktif: 11, // index 11 = stop ke-12
    ),
    _JalurInfo(
      nama:    'Jalur 2',
      koridor: 'Koridor Masaran - Kota Sragen',
      dot:     _dot2,
      aktif:   false,
      stops: [
        'Titik Awal',
        'Titik Akhir',
        'SMP Negeri 1 Masaran',
        'Simpang Pasar Masaran',
        'SMP Muhammadiyah 2 Masaran',
        'Puskesmas Masaran',
        'Pos Lalu Lintas Bulu',
        'SMP Negeri 1 Sidoharjo',
        'Simpang Nguwer',
        'SD Negeri Jetak 2 Sidoharjo',
        'Simpang Pungkruk',
        'Halte Gambiran',
        'Halte Beloran',
        'Alfamidi Sukowati',
        'SMP Negeri 1 Sragen',
        'SMP Muhammadiyah 1 Sragen',
        'SMP Negeri 2 Sragen',
        'SMK Negeri 1 Sragen',
        'SMA Negeri 1 Sragen',
      ],
      stopAktif: 13, // index 13 = stop ke-14 Alfamidi Sukowati
    ),
    _JalurInfo(
      nama:    'Jalur 3',
      koridor: 'Koridor Kedawung - Karangmalang',
      dot:     _dot3,
      aktif:   false,
      stops: [
        'Kantor Kecamatan Kedawung',
        'SMA N 1 Sragen',
        'Kantor Kecamatan Karangmalang',
        'Kantor Kecamatan Kedawung',
        'SMK N 1 Kedawung',
        'Jembatan Desa Bendungan',
        'Simpang Pasar Puro',
        'Dapur Lely/PDAM',
        'Simpang Kreteg Gandok',
        'Dinas Sosial/SD N Mojo 58',
        'Masjid Raya Sragen',
        'SMP Muhammadiyah 1 Sragen',
        'Halte SMP N 2 Sragen',
        'SMK N 1 Sragen',
        'SMK Binawiyata Sragen',
        'SD N Kroyo (SBI Kroyo Karangmalang)',
        'SD N Puro 1',
        'SMP N 1 Karangmalang',
        'Balai Desa Puro Karangmalang',
        'Simpang 4 APILL Taruna',
        'Simpang 4 APILL Teguhan',
        'Simpang Disnaker/BLK',
      ],
      stopAktif: 10, // index 10 = stop ke-11 Masjid Raya Sragen
    ),
    _JalurInfo(
      nama:    'Jalur 4',
      koridor: 'Koridor Galeh - Tangen',
      dot:     _dot4,
      aktif:   false,
      stops: [
        'Simpang 3 Ojek Galeh (Titik Awal)',
        'Simpang Masjid Al-Falaq',
        'Simpang 3 Keras',
        'Simpang Sidorejo Ngrombo',
        'SDN Ngrombo 2',
        'Simpang 3 Sendangrejo',
        'Simpang 3 Ngablak (SDN Ngrombo 3)',
        'Balai Desa Ngrombo',
        'SDN Ngrombo 1',
        'SMPN 2 Tangen',
        'Gapura Desa Ngrombo',
        'Simpang Tiga Bayanan Tangen',
        'Koramil Tangen',
        'Kantor Pos Tangen',
        'SMP N 1 Tangen',
        'SDN Katelan 1',
        'SDN Katelan 3',
        'SMA N 1 Tangen (Titik Akhir)',
      ],
      stopAktif: 17, // index 17 = stop ke-18 SMA N 1 Tangen
    ),
    _JalurInfo(
      nama:    'Jalur 5',
      koridor: 'Koridor tambahan SIJEMPOL',
      dot:     _dot5,
      aktif:   false,
      stops: [
        'Titik Awal',
        'Pasar Ngrampal',
        'SD N 1 Ngrampal',
        'SMP N 1 Ngrampal',
        'Simpang Ngrampal',
        'SMK Ngrampal',
        'Puskesmas Ngrampal',
        'SMP N 7 Sragen',
        'Titik Akhir',
      ],
      stopAktif: 2,
    ),
  ];

  static const List<_StatusInfo> _statusPerJalur = [
    _StatusInfo(nama: 'SMK N2/SMA N 3 Sragen', jarak: '0.76 km', progress: 0.74, label: 'Progress 74%'),
    _StatusInfo(nama: 'Alfamidi Sukowati',       jarak: '0.76 km', progress: 0.74, label: 'Progress 74%'),
    _StatusInfo(nama: 'Masjid Raya Sragen', jarak: '1.12 km', progress: 0.50, label: 'Progress 50%'),
    _StatusInfo(nama: 'SMA N 1 Tangen',     jarak: '11.94 km', progress: 1.00, label: 'Progress 100%'),
    _StatusInfo(nama: 'Pasar Ngrampal',     jarak: '1.05 km', progress: 0.25, label: 'Progress 25%'),
  ];

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBg,
      // BottomNavBar dari Figma: blur glass effect
      bottomNavigationBar: _buildBottomNav(),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                _buildTopAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Main content dengan padding 16px + gap 16px antar section
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Section header info
                              _buildSectionHeaderInfo(),
                              const SizedBox(height: 16),

                              // Section route selector
                              _buildRouteSelector(),
                              const SizedBox(height: 12),

                              // Map controls
                              _buildMapControls(),
                              const SizedBox(height: 16),

                              // Map view
                              _buildMapView(),
                              const SizedBox(height: 16),

                              // Current status card
                              _buildStatusCard(),
                              const SizedBox(height: 16),

                              // Timeline stops
                              _buildStopsSection(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ====================================================
          // PUSAT BANTUAN — FIXED DI KANAN BAWAH
          // ====================================================
          Positioned(
            right: 26,
            bottom: 14,
            child: _buildHelpButton(),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TOP APP BAR — dari Figma #241:921
  // height:64, bg #F9F9FF, border-bottom #BFC7D2
  // ============================================================

  Widget _buildTopAppBar() {
    return Container(
      width: double.infinity,
      height: 66,
      decoration: const BoxDecoration(
        color: _pageBg,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 0.7,
          ),
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
              color: _blue,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Bus Sekolah',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _blue,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION HEADER INFO — #241:932
  // ============================================================

  Widget _buildSectionHeaderInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // "LAYANAN TRANSPORTASI PELAJAR" — Bold 12px #006098 uppercase
        const Text(
          'LAYANAN TRANSPORTASI PELAJAR',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: _blue,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 4),
        // Subtitle — Regular 14px #404851
        const Text(
          'Pantau posisi rute bus sekolah secara real-time.',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: _textMid,
            height: 20 / 14,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ROUTE SELECTOR — horizontal scroll #241:938
  // ============================================================

  Widget _buildRouteSelector() {
    return SizedBox(
      height: 82,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        itemCount: _jalurs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (ctx, i) {
          final j      = _jalurs[i];
          final bool s = _sel == i;

          return GestureDetector(
            onTap: () => setState(() => _sel = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 240,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: s ? _blue : _white,
                borderRadius: BorderRadius.circular(12),
                border: s
                    ? null
                    : Border.all(color: _border, width: 1),
                boxShadow: s
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.10),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8, height: 8,
                        decoration: BoxDecoration(
                          color: s ? _white : j.dot,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        j.nama,
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: s ? _white : _textDark,
                          height: 20 / 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (s)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _aktifBg,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: const Text(
                            'Aktif',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: _aktifText,
                              height: 15 / 10,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    j.koridor,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: s ? _white.withValues(alpha: 0.85) : _textMid,
                      height: 16 / 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // MAP CONTROLS — #241:969
  // ============================================================

  Widget _buildMapControls() {
    return Row(
      children: [
        // Auto-follow — bg #7BF8A1, text #007239, borderRadius 8px
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
          decoration: BoxDecoration(
            color: _autoFollowBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.gps_fixed_rounded,
                size: 14,
                color: _autoFollowText,
              ),
              const SizedBox(width: 6),
              const Text(
                'Auto-follow',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: _autoFollowText,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Muat ulang — bg #E7EEFF, border #BFC7D2
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _reloadBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _border, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.refresh_rounded, size: 12, color: _textMid),
              const SizedBox(width: 6),
              const Text(
                'Muat ulang',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: _textMid,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        // GPS tersambung
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Baris: dot hijau + "GPS tersambung"
            AnimatedBuilder(
              animation: _pulseAnim,
              builder: (_, __) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6, height: 6,
                    decoration: BoxDecoration(
                      color: Color.lerp(
                        _gpsDot,
                        const Color(0xFF4ADE80),
                        _pulseAnim.value,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'GPS tersambung',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: _gpsText,
                      height: 15 / 10,
                    ),
                  ),
                ],
              ),
            ),
            // "0.0 km/jam • 11.38.44"
            const Text(
              '0.0 km/jam • 11.38.44',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: _textMid,
                height: 15 / 10,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // MAP VIEW — #241:986
  // height:300, bg #F0F3FF, border #BFC7D2, borderRadius 16px
  // ============================================================

  Widget _buildMapView() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: _mapBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Peta background yang didownload dari Figma
          Positioned.fill(
            child: Image.asset(
              'assets/images/bus_sekolah/map_bg-3e98e6.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFFE8EDF4),
                child: const Center(
                  child: Icon(Icons.map_outlined, size: 48, color: Color(0xFFBFC7D2)),
                ),
              ),
            ),
          ),

          // Bus Marker — di posisi seperti Figma (215.24, 86.69)
          Positioned(
            left: (215.24 / 390) * (MediaQuery.of(context).size.width - 32),
            top: (86.69 / 300) * 300,
            child: Column(
              children: [
                // Lingkaran biru dengan icon bus
                Container(
                  width: 29, height: 38,
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 14),
                  decoration: BoxDecoration(
                    color: _blue,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _blue.withValues(alpha: 0.20),
                        blurRadius: 15,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.directions_bus_rounded,
                    size: 11,
                    color: _white,
                  ),
                ),
                const SizedBox(height: 4),
                // Label BUS-01 — bg putih, text biru
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Text(
                    'BUS-01',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: _blue,
                      height: 15 / 10,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Zoom controls — kanan atas, #241:997
          Positioned(
            right: 12, top: 12,
            child: Column(
              children: [
                _zoomBtn(Icons.add),
                const SizedBox(height: 4),
                _zoomBtn(Icons.remove),
              ],
            ),
          ),

          // Route Label Overlay — kanan bawah, #241:1004
          Positioned(
            bottom: 12,
            right: 12,
            child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _mapLabelBg,
                  borderRadius: BorderRadius.circular(9999),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.10),
                      blurRadius: 15,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Text(
                  _jalurs[_sel].koridor,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: _white,
                    height: 15 / 10,
                  ),
                ),
              ),
            ),
          ],
      ),
    );
  }

  Widget _zoomBtn(IconData icon) {
    return Container(
      width: 32, height: 32,
      decoration: BoxDecoration(
        color: _white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Icon(icon, size: 12, color: _textDark),
    );
  }

  // ============================================================
  // CURRENT STATUS CARD — #241:1007
  // bg #F0F3FF, border #BFC7D2, borderRadius 16px, padding 16px
  // ============================================================

  Widget _buildStatusCard() {
    final s = _statusPerJalur[_sel];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _mapBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Terdekat dari bus',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _blue,
                        height: 20 / 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      s.nama,
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _textDark,
                        height: 22 / 16,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    s.jarak,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _blue,
                      height: 21 / 14,
                    ),
                  ),
                  Text(
                    s.label,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: _textMid,
                      height: 15 / 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (_, box) => Stack(
              children: [
                Container(
                  height: 8,
                  width: box.maxWidth,
                  decoration: BoxDecoration(
                    color: _progressTrack,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                Container(
                  height: 8,
                  width: box.maxWidth * s.progress,
                  decoration: BoxDecoration(
                    color: _blue,
                    borderRadius: BorderRadius.circular(9999),
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
  // TIMELINE / BUS STOPS — #241:1021
  // bg putih, border #BFC7D2, borderRadius 16px, padding 16px
  // ============================================================

  Widget _buildStopsSection() {
    final stops     = _jalurs[_sel].stops;
    final int aktif = _jalurs[_sel].stopAktif;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border, width: 1),
      ),
      child: Column(
        children: [
          // Header: icon + "Pemberhentian" + "X titik"
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 16,
                color: _blue,
              ),
              const SizedBox(width: 8),
              const Text(
                'Pemberhentian',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _textDark,
                  height: 20 / 14,
                ),
              ),
              const Spacer(),
              Text(
                '${stops.length} titik',
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _textMid,
                  height: 16 / 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Timeline dengan garis vertikal
          Stack(
            children: [
              // Garis vertikal
              Positioned(
                left: 13,
                top: 16,
                bottom: 16,
                child: Container(
                  width: 2,
                  color: _stopLine,
                ),
              ),

              // List stop
              Column(
                children: List.generate(stops.length, (i) {
                  final bool isAktif = i == aktif;
                  return _buildStopRow(
                    nomor: i + 1,
                    nama:  stops[i],
                    isAktif: isAktif,
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStopRow({
    required int    nomor,
    required String nama,
    required bool   isAktif,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Nomor bulat — 28×28
          // aktif: #007ABE, biasa: #96989A
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(
              color: isAktif ? _stopAktif : _stopGrey,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$nomor',
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: _white,
                  height: 16.5 / 11,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Nama stop — Bold 14px #000000, opacity 0.7
          Expanded(
            child: Opacity(
              opacity: 0.70,
              child: Text(
                nama,
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF000000),
                  height: 20 / 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PUSAT BANTUAN — identik dengan home_screen
  // ============================================================

  Widget _buildHelpButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BantuanScreen(),
            ),
          );
        },
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: _blue,
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
            color: Colors.white,
            size: 29,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAV — identik dengan home_screen
  // height:95, borderRadius 22, icon 22, font 9, pill 95×52
  // ============================================================

  Widget _buildBottomNav() {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(22),
        ),
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
            // Beranda
            Expanded(
              child: _navItem(
                icon:       Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                label:      'Beranda',
                active:     false,
                onTap:      () => Navigator.popUntil(context, (route) => route.isFirst),
              ),
            ),
            // Layanan — aktif
            Expanded(
              child: _navItem(
                icon:       Icons.grid_view_rounded,
                activeIcon: Icons.grid_view_rounded,
                label:      'Layanan',
                active:     true,
                onTap:      () {},
              ),
            ),
            // Agenda — navigasi ke AgendaScreen
            Expanded(
              child: _navItem(
                icon:       Icons.calendar_month_outlined,
                activeIcon: Icons.calendar_month_rounded,
                label:      'Agenda',
                active:     false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AgendaScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem({
    required IconData     icon,
    required IconData     activeIcon,
    required String       label,
    required bool         active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width:  95,
          height: 52,
          decoration: BoxDecoration(
            color: active ? _tealLight : Colors.transparent,
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
                  color: active ? _navyDark : const Color(0xFF374151),
                ),
                const SizedBox(height: 1),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                    color: active ? _navyDark : const Color(0xFF374151),
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
// DATA MODEL
// ================================================================
// DATA MODELS
// ================================================================

class _JalurInfo {
  final String       nama;
  final String       koridor;
  final Color        dot;
  final bool         aktif;
  final List<String> stops;
  final int          stopAktif;
  const _JalurInfo({
    required this.nama,
    required this.koridor,
    required this.dot,
    required this.aktif,
    required this.stops,
    required this.stopAktif,
  });
}


class _StatusInfo {
  final String nama;
  final String jarak;
  final double progress;
  final String label;
  const _StatusInfo({
    required this.nama,
    required this.jarak,
    required this.progress,
    required this.label,
  });
}
