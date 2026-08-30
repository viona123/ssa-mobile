import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../bantuan/bantuan_screen.dart';
import '../../agenda/agenda_screen.dart';

// ================================================================
// KEUANGAN SCREEN
// Desain 1:1 sesuai gambar context/gambar1.png
// ================================================================

class KeuanganScreen extends StatefulWidget {
  const KeuanganScreen({super.key});

  @override
  State<KeuanganScreen> createState() => _KeuanganScreenState();
}

class _KeuanganScreenState extends State<KeuanganScreen>
    with SingleTickerProviderStateMixin {
  // ============================================================
  // PALETTE  —  diambil pixel-per-pixel dari gambar
  // ============================================================

  // Warna aplikasi (sama home & agenda)
  static const Color _appBlue    = Color(0xFF007EA7);
  static const Color _tealLight  = Color(0xFF58D8EC);
  static const Color _navyDark   = Color(0xFF315579);
  static const Color _ink        = Color(0xFF202124);
  static const Color _smoke      = Color(0xFF737B86);
  static const Color _bg         = Color(0xFFF8FAFC);

  // Kartu DAU  — gradient biru teal gelap sesuai gambar
  static const Color _dauTop    = Color(0xFF1B7FA8);
  static const Color _dauBot    = Color(0xFF0E5C7A);

  // Badge "97.0%" dot hijau teal
  static const Color _dotBadge  = Color(0xFF4ECDC4);

  // Badge "5 jenis dana lainnya"  — teal cerah sesuai gambar
  static const Color _badgeTeal  = Color(0xFF40E0D0);

  // Donut segments  — sesuai gambar
  static const Color _segRed    = Color(0xFFF04438); // DAU SG    53.3%  merah
  static const Color _segPurple = Color(0xFF9B8AFB); // DAK Non   4.4%   ungu
  static const Color _segGreen  = Color(0xFF12B76A); // DBHCHT    25.2%  hijau
  static const Color _segOrange = Color(0xFFF79009); // Pajak     15.4%  oranye
  static const Color _segPink   = Color(0xFFF63D68); // BANKEU    1.7%   pink

  // Legend dots  — sesuai gambar (berbeda dari arc untuk DAU SG)
  static const Color _ldotNavy   = Color(0xFF175CD3); // DAU SG
  static const Color _ldotPurple = Color(0xFF9B8AFB); // DAK Non-Fisik
  static const Color _ldotGreen  = Color(0xFF12B76A); // DBHCHT
  static const Color _ldotRed    = Color(0xFFF04438); // Pajak Rokok
  static const Color _ldotPink   = Color(0xFFF63D68); // BANKEU

  // Progress bars  — sesuai gambar
  static const Color _barBlue   = Color(0xFF1570EF); // DAU
  static const Color _barGreen  = Color(0xFF12B76A); // DAU SG, DAK Fisik, DAK Non-Fisik, DIF
  static const Color _barPink   = Color(0xFFF63D68); // DBHCHT

  // ============================================================
  // ANIMASI
  // ============================================================

  late AnimationController _ctrl;
  late Animation<double>    _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  // ============================================================
  // DATA  —  sesuai angka di gambar
  // ============================================================

  static const double _totalTransfer = 694982122141;

  // Segmen donut  (porsi = persentase di label gambar)
  static const List<_Seg> _segs = [
    _Seg(pct: 53.3, color: _segRed,    label: '53.3%'), // merah  — paling besar
    _Seg(pct:  4.4, color: _segPurple, label: '4.4%' ), // ungu   — kecil
    _Seg(pct: 25.2, color: _segGreen,  label: '25.2%'), // hijau
    _Seg(pct: 15.4, color: _segOrange, label: '15.4%'), // oranye
    _Seg(pct:  1.7, color: _segPink,   label: ''     ), // pink   — terlalu kecil
  ];

  // Legend
  static const List<_Legend> _legends = [
    _Legend('DAU SG',        _ldotNavy),
    _Legend('DAK Non-Fisik', _ldotPurple),
    _Legend('DBHCHT',        _ldotGreen),
    _Legend('Pajak Rokok',   _ldotRed),
    _Legend('BANKEU',        _ldotPink),
  ];

  // Rincian dana  (nama, nominal, warna bar)
  static const List<_Row> _rows = [
    _Row('DAU',                         673836042791, _barBlue),
    _Row('DAU SG (DAU Specific Grant)',    931325036, _barGreen),
    _Row('DAK Fisik',                             0, _barGreen),
    _Row('DAK Non-Fisik',                5320508629, _barGreen),
    _Row('DIF (Dana Insentif Fiskal)',             0, _barGreen),
    _Row('DBHCHT',                       3249892880, _barPink),
  ];

  // ============================================================
  // FORMAT HELPERS
  // ============================================================

  String _rupiah(double v) {
    if (v == 0) return 'Rp 0';
    final s   = v.toStringAsFixed(0);
    final buf = StringBuffer();
    int   c   = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      if (c > 0 && c % 3 == 0) buf.write('.');
      buf.write(s[i]);
      c++;
    }
    return 'Rp ${buf.toString().split('').reversed.join()}';
  }

  String _short(double v) {
    if (v >= 1e12) return '${(v / 1e12).toStringAsFixed(1)}T';
    if (v >= 1e9)  return '${(v / 1e9).toStringAsFixed(1)}M';
    if (v >= 1e6)  return '${(v / 1e6).toStringAsFixed(1)}jt';
    return v.toStringAsFixed(0);
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      bottomNavigationBar: _buildNavBar(),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildHero(),
                        const SizedBox(height: 20),
                        _buildDauCard(),
                        const SizedBox(height: 12),
                        _buildTotalCard(),
                        const SizedBox(height: 12),
                        _buildProporsiCard(),
                        const SizedBox(height: 12),
                        _buildRincianCard(),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Floating help
          Positioned(
            right: 24,
            bottom: 12,
            child: _buildHelp(),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER  —  ← Layanan Keuangan
  // ============================================================

  Widget _buildHeader() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: _bg,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE5E7EB), width: 0.6),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 22,
              color: _appBlue,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Layanan Keuangan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: _appBlue,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HERO TITLE
  // ============================================================

  Widget _buildHero() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
      child: Column(
        children: [
          const Text(
            'Transparansi Keuangan\nDaerah',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: _ink,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Informasi publik mengenai realisasi anggaran\n'
            'dan pendapatan daerah Kabupaten Sragen.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13.5,
              color: _smoke,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // KARTU DAU  —  biru teal gelap
  // ============================================================

  Widget _buildDauCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_dauTop, _dauBot],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _dauBot.withValues(alpha: 0.40),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            // Lingkaran dekorasi kanan atas
            Positioned(
              right: -20,
              top: -20,
              child: _circle(110, 0.09, 16),
            ),
            Positioned(
              right: 25,
              bottom: -28,
              child: _circle(70, 0.07, 11),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label kecil
                const Text(
                  'Dana Alokasi Umum (DAU)',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xCCFFFFFF),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 8),

                // Nominal
                const Text(
                  'Rp 673.836.042.791',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.5,
                    height: 1.1,
                  ),
                ),

                const SizedBox(height: 14),

                // Badge persentase
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8, height: 8,
                        decoration: const BoxDecoration(
                          color: _dotBadge,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 7),
                      const Text(
                        '97.0% dari total Dana Transfer',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _circle(double size, double opacity, double border) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: opacity),
          width: border,
        ),
      ),
    );
  }

  // ============================================================
  // KARTU TOTAL DANA TRANSFER
  // ============================================================

  Widget _buildTotalCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
        decoration: _cardDeco(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Dana Transfer',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Rp 694.982.122.141',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: _ink,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Badge teal cerah sesuai gambar
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _badgeTeal,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '5 jenis dana lainnya',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0A5C6B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // Icon wallet sudut kanan atas
            Container(
              width: 38, height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFFE6F4F8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.account_balance_wallet_outlined,
                size: 20,
                color: _appBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // KARTU PROPORSI  —  full donut
  // ============================================================

  Widget _buildProporsiCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
        decoration: _cardDeco(),
        child: Column(
          children: [
            // Judul
            const Text(
              'Proporsi Dana Transfer (Selain\nDAU)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: _ink,
                height: 1.35,
              ),
            ),

            const SizedBox(height: 22),

            // DONUT
            SizedBox(
              height: 220,
              child: AnimatedBuilder(
                animation: _anim,
                builder: (_, __) => CustomPaint(
                  size: const Size(double.infinity, 220),
                  painter: _DonutPainter(
                    segs:     _segs,
                    progress: _anim.value,
                    line1:    'Total Transfer',
                    line2:    _short(_totalTransfer),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // LEGEND — baris 1: 3 item, baris 2: 2 item
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    Widget dot(Color c) => Container(
      width: 10, height: 10,
      decoration: BoxDecoration(color: c, shape: BoxShape.circle),
    );

    Widget item(_Legend l) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        dot(l.color),
        const SizedBox(width: 5),
        Text(
          l.name,
          style: const TextStyle(
            fontSize: 12,
            color: _ink,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );

    return Column(
      children: [
        // Baris 1 — 3 item
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _legends.take(3).map((l) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: item(l),
          )).toList(),
        ),
        const SizedBox(height: 7),
        // Baris 2 — 2 item
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _legends.skip(3).map((l) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: item(l),
          )).toList(),
        ),
      ],
    );
  }

  // ============================================================
  // KARTU RINCIAN DANA  (tanpa filter sesuai permintaan)
  // ============================================================

  Widget _buildRincianCard() {
    final double maxNom = _rows
        .map((r) => r.nominal)
        .reduce((a, b) => a > b ? a : b);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
        decoration: _cardDeco(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul saja (TANPA filter)
            const Text(
              'Rincian Dana',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _ink,
              ),
            ),

            const SizedBox(height: 10),

            // Garis pemisah tipis
            Container(height: 0.8, color: const Color(0xFFEBEDF0)),

            const SizedBox(height: 4),

            // List baris
            AnimatedBuilder(
              animation: _anim,
              builder: (_, __) => Column(
                children: _rows.map(
                  (r) => _buildRow(r, maxNom, _anim.value),
                ).toList(),
              ),
            ),

            const SizedBox(height: 8),

            // Sumber data
            Center(
              child: Text(
                'Sumber Data: E-POS Sragen',
                style: TextStyle(
                  fontSize: 11.5,
                  color: _smoke,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(_Row r, double maxNom, double prog) {
    final double frac = maxNom > 0 ? (r.nominal / maxNom) * prog : 0;
    final bool isBlue = r.barColor == _barBlue;

    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  r.nama,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _ink,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                _rupiah(r.nominal),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  // Nominal DAU warna biru, lainnya hitam/abu
                  color: isBlue
                      ? _appBlue
                      : (r.nominal > 0 ? _ink : _smoke),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Progress bar
          LayoutBuilder(
            builder: (_, box) {
              final double w = box.maxWidth;
              return Stack(
                children: [
                  Container(
                    height: 5, width: w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF0F3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Container(
                    height: 5,
                    width: (w * frac).clamp(0.0, w),
                    decoration: BoxDecoration(
                      color: r.barColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION  (identik home & agenda)
  // ============================================================

  Widget _buildNavBar() {
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
            Expanded(child: _navItem(Icons.home_outlined,        Icons.home_rounded,           'Beranda', false, () => Navigator.pop(context))),
            Expanded(child: _navItem(Icons.grid_view_rounded,    Icons.grid_view_rounded,      'Layanan', true,  () {})),
            Expanded(child: _navItem(Icons.calendar_month_outlined, Icons.calendar_month_rounded, 'Agenda', false, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AgendaScreen()),
              );
            })),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData off, IconData on, String label, bool active, VoidCallback tap) {
    return GestureDetector(
      onTap: tap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 95, height: 52,
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
                  active ? on : off,
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

  // ============================================================
  // PUSAT BANTUAN
  // ============================================================

  Widget _buildHelp() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const BantuanScreen()),
      ),
      child: Container(
        width: 56, height: 56,
        decoration: BoxDecoration(
          color: _appBlue,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
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
    );
  }

  // ============================================================
  // HELPER  —  dekorasi kartu putih
  // ============================================================

  BoxDecoration _cardDeco() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: const Color(0xFFE8ECEF)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.03),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );
}

// ================================================================
// DATA MODELS  (const)
// ================================================================

class _Seg {
  final double pct;
  final Color  color;
  final String label;
  const _Seg({required this.pct, required this.color, required this.label});
}

class _Legend {
  final String name;
  final Color  color;
  const _Legend(this.name, this.color);
}

class _Row {
  final String nama;
  final double nominal;
  final Color  barColor;
  const _Row(this.nama, this.nominal, this.barColor);
}

// ================================================================
// CUSTOM PAINTER  —  FULL DONUT CHART
// ================================================================

class _DonutPainter extends CustomPainter {
  final List<_Seg> segs;
  final double     progress;
  final String     line1;
  final String     line2;

  const _DonutPainter({
    required this.segs,
    required this.progress,
    required this.line1,
    required this.line2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double cx      = size.width  / 2;
    final double cy      = size.height / 2;
    final double outerR  = math.min(cx, cy) - 4;
    final double innerR  = outerR * 0.57;          // tebal ring sesuai gambar
    final double stroke  = outerR - innerR;
    final double mid     = innerR + stroke / 2;
    const double gap     = 0.022;                   // gap antar segmen

    // Mulai dari atas (jam 12)
    double angle = -math.pi / 2;

    for (final s in segs) {
      final double full  = 2 * math.pi * (s.pct / 100) * progress;
      final double sweep = full - gap * 2;

      if (sweep > 0) {
        // Arc
        canvas.drawArc(
          Rect.fromCircle(center: Offset(cx, cy), radius: mid),
          angle + gap,
          sweep,
          false,
          Paint()
            ..color       = s.color
            ..style       = PaintingStyle.stroke
            ..strokeWidth = stroke
            ..strokeCap   = StrokeCap.butt,
        );

        // Label % — hanya jika cukup besar dan animasi hampir selesai
        if (s.label.isNotEmpty && progress > 0.85) {
          final double midAng = angle + gap + sweep / 2;
          final double lx = cx + mid * math.cos(midAng);
          final double ly = cy + mid * math.sin(midAng);

          final tp = TextPainter(
            text: TextSpan(
              text: s.label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
              ),
            ),
            textDirection: TextDirection.ltr,
          )..layout();

          tp.paint(canvas, Offset(lx - tp.width / 2, ly - tp.height / 2));
        }
      }

      angle += full;
    }

    // ----------------------------------------------------------
    // TEKS TENGAH  —  "Total Transfer" + "21.1M"
    // ----------------------------------------------------------

    final tp1 = TextPainter(
      text: const TextSpan(
        text: 'Total Transfer',
        style: TextStyle(
          color: Color(0xFF737B86),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final tp2 = TextPainter(
      text: TextSpan(
        text: line2,
        style: const TextStyle(
          color: Color(0xFF202124),
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    const double sp = 3;
    final double th = tp1.height + sp + tp2.height;
    final double sy = cy - th / 2;

    tp1.paint(canvas, Offset(cx - tp1.width / 2, sy));
    tp2.paint(canvas, Offset(cx - tp2.width / 2, sy + tp1.height + sp));
  }

  @override
  bool shouldRepaint(_DonutPainter old) => old.progress != progress;
}
