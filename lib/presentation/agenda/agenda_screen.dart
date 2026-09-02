import 'package:flutter/material.dart';
import '../bantuan/bantuan_screen.dart';
import '../layanan/pariwisata/reservasi_screen.dart';

class AgendaScreen extends StatefulWidget {
  final bool showBottomNav;

  /// Dipanggil saat tombol kembali (panah atas) ditekan.
  ///
  /// Diisi ketika AgendaScreen ditampilkan sebagai konten di dalam HomeScreen
  /// (bukan route yang di-push), sehingga tombol kembali tidak mem-pop
  /// HomeScreen dan menyebabkan layar hitam, melainkan kembali ke tab Beranda.
  final VoidCallback? onBack;

  const AgendaScreen({super.key, this.showBottomNav = true, this.onBack});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
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
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      bottomNavigationBar: widget.showBottomNav ? _buildNavBar() : null,

      // ========================================================
      // BODY
      // ========================================================

      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                // ==================================================
                // HEADER
                // ==================================================

                _buildHeader(),

                // ==================================================
                // CONTENT
                // ==================================================

                Expanded(
                  child: SingleChildScrollView(
                    physics:
                        const BouncingScrollPhysics(),

                    padding: const EdgeInsets.only(
                      bottom: 30,
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        // ==========================================
                        // TITLE
                        // ==========================================

                        _buildTitle(),

                        const SizedBox(height: 18),

                        // ==========================================
                        // AGENDA KOTA
                        // ==========================================

                        _buildAgendaSection(),

                        const SizedBox(height: 20),

                        // ==========================================
                        // CALENDAR
                        // ==========================================

                        _buildCalendar(),

                        const SizedBox(height: 14),

                        // ==========================================
                        // AGENDA BULAN INI 1
                        // ==========================================

                        _buildMonthlyAgenda(
                          month: 'OKT',
                          date: '21',
                          title: 'Festival UMKM Sragen',
                          subtitle: '21 Okt - 25 Okt',
                        ),

                        const SizedBox(height: 10),

                        // ==========================================
                        // AGENDA BULAN INI 2
                        // ==========================================

                        _buildMonthlyAgenda(
                          month: 'OKT',
                          date: '28',
                          title: 'Sumpah Pemuda',
                          subtitle: '28 Okt - 29 Okt',
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ======================================================
          // PUSAT BANTUAN FLOATING
          // ======================================================

          _buildHelpButton(),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  // ============================================================
  // HANDLE BACK (panah atas di header)
  // ============================================================

  void _handleBack() {
    // Jika ditampilkan di dalam HomeScreen, kembali ke tab Beranda
    // lewat callback agar tidak mem-pop HomeScreen (layar hitam).
    if (widget.onBack != null) {
      widget.onBack!();
      return;
    }

    // Jika di-push sebagai route tersendiri, pop seperti biasa.
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 66,

      decoration: const BoxDecoration(
        color: pageBackground,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 0.7,
          ),
        ),
      ),

      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),

      child: Row(
        children: [
          GestureDetector(
            onTap: _handleBack,

            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 22,
              color: primaryBlue,
            ),
          ),

          const SizedBox(width: 16),

          const Text(
            'Kalender Agenda',
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
  // TITLE
  // ============================================================

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        24,
        24,
        24,
        0,
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          // GARIS BIRU

          Container(
            width: 4,
            height: 34,

            decoration: BoxDecoration(
              color: primaryBlue,
              borderRadius:
                  BorderRadius.circular(8),
            ),
          ),

          const SizedBox(width: 10),

          // TEXT

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  'Agenda Kota',
                  style: TextStyle(
                    fontSize: 25,
                    height: 1.1,
                    fontWeight:
                        FontWeight.w700,
                    color: darkText,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  'Temukan rangkaian kegiatan resmi dan pelayanan publik di Kabupaten Sragen.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: greyText,
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
  // AGENDA SECTION
  // HANYA 1 AGENDA
  // ============================================================

  Widget _buildAgendaSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),

      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _openSangiranDetail,
        child: _buildAgendaCard(),
      ),
    );
  }

  // ============================================================
  // BUKA DETAIL / DATA MUSEUM PURBAKALA SANGIRAN
  // ============================================================

  void _openSangiranDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ReservasiScreen(
          namaWisata: 'Museum Purbakala Sangiran',
          lokasi: 'Kalijambe, Sragen',
          deskripsi:
              'Situs prasejarah warisan dunia UNESCO, menyimpan '
              'koleksi fosil manusia purba...',
        ),
      ),
    );
  }

  // ============================================================
  // AGENDA CARD
  // ============================================================

  Widget _buildAgendaCard() {
    return Container(
      width: double.infinity,

      height: 320,

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(17),

        border: Border.all(
          color: const Color(0xFFD9DEE5),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      clipBehavior: Clip.antiAlias,

      child: Column(
        children: [
          // ======================================================
          // GAMBAR
          // ======================================================

          SizedBox(
            width: double.infinity,
            height: 190,

            child: Stack(
              fit: StackFit.expand,

              children: [
                Image.asset(
                  'assets/images/agenda/sangiran.png',

                  fit: BoxFit.cover,

                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return Container(
                      decoration:
                          const BoxDecoration(
                        gradient:
                            LinearGradient(
                          begin:
                              Alignment.topCenter,
                          end:
                              Alignment.bottomCenter,
                          colors: [
                            Color(
                              0xFF65C4D5,
                            ),
                            Color(
                              0xFF0B9DB4,
                            ),
                          ],
                        ),
                      ),

                      child: const Center(
                        child: Icon(
                          Icons
                              .account_balance,
                          size: 54,
                          color:
                              Colors.white70,
                        ),
                      ),
                    );
                  },
                ),

                // =================================================
                // FEATURED
                // =================================================

                Positioned(
                  left: 13,
                  top: 12,

                  child: Container(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    decoration:
                        BoxDecoration(
                      color:
                          const Color(
                        0xFFB57A00,
                      ),

                      borderRadius:
                          BorderRadius
                              .circular(
                        16,
                      ),
                    ),

                    child: const Text(
                      'FEATURED',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ======================================================
          // DETAIL
          // ======================================================

          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.fromLTRB(
                16,
                11,
                16,
                10,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  // =================================================
                  // JUDUL
                  // =================================================

                  const Text(
                    "Pameran 'The Land Of Java Man'",

                    maxLines: 1,

                    overflow:
                        TextOverflow.ellipsis,

                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          FontWeight.w700,
                      color: darkText,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // =================================================
                  // LOKASI
                  // =================================================

                  Row(
                    children: [
                      const Icon(
                        Icons
                            .location_on_outlined,
                        size: 16,
                        color: greyText,
                      ),

                      const SizedBox(width: 4),

                      const Expanded(
                        child: Text(
                          'Museum Sangiran Sragen',

                          maxLines: 1,

                          overflow:
                              TextOverflow
                                  .ellipsis,

                          style: TextStyle(
                            fontSize: 10,
                            color: greyText,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // =================================================
                  // RESERVASI
                  // =================================================

                  Align(
                    alignment:
                        Alignment.centerRight,

                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min,

                      children: [
                        const Text(
                          'Reservasi',

                          style: TextStyle(
                            fontSize: 10,
                            fontWeight:
                                FontWeight.w700,
                            color: darkBlue,
                          ),
                        ),

                        const SizedBox(
                          width: 4,
                        ),

                        const Icon(
                          Icons
                              .confirmation_number_outlined,
                          size: 16,
                          color: darkBlue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CALENDAR
  // ============================================================

  Widget _buildCalendar() {
    return Container(
      width: double.infinity,

      margin:
          const EdgeInsets.symmetric(
        horizontal: 24,
      ),

      padding:
          const EdgeInsets.fromLTRB(
        16,
        14,
        16,
        14,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: const Color(0xFFE1E5E9),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.035,
            ),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        children: [
          // ======================================================
          // CALENDAR HEADER
          // ======================================================

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [
              const Text(
                'Oktober 2026',

                style: TextStyle(
                  fontSize: 21,
                  fontWeight:
                      FontWeight.w700,
                  color: darkText,
                ),
              ),

              Row(
                children: [
                  GestureDetector(
                    onTap: () {},

                    child: const Padding(
                      padding:
                          EdgeInsets.all(5),

                      child: Icon(
                        Icons.chevron_left,
                        size: 23,
                        color: darkText,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {},

                    child: const Padding(
                      padding:
                          EdgeInsets.all(5),

                      child: Icon(
                        Icons.chevron_right,
                        size: 23,
                        color: darkText,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          _buildCalendarGrid(),
        ],
      ),
    );
  }

  // ============================================================
  // CALENDAR GRID
  // ============================================================

  Widget _buildCalendarGrid() {
    const List<String> days = [
      'Sn',
      'Sl',
      'Rb',
      'Km',
      'Jm',
      'Sb',
      'Mg',
    ];

    const List<String> dates = [
      '',
      '',
      '',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25',
      '26',
      '27',
      '28',
      '29',
      '30',
      '31',
    ];

    return Column(
      children: [
        // ========================================================
        // HARI
        // ========================================================

        Row(
          children:
              days.map(
            (day) {
              return Expanded(
                child: Center(
                  child: Text(
                    day,

                    style:
                        const TextStyle(
                      fontSize: 10,
                      color: greyText,
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),

        const SizedBox(height: 5),

        // ========================================================
        // TANGGAL
        // ========================================================

        GridView.builder(
          shrinkWrap: true,

          physics:
              const NeverScrollableScrollPhysics(),

          itemCount: dates.length,

          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisExtent: 34,
          ),

          itemBuilder:
              (context, index) {
            final String date =
                dates[index];

            final bool selected =
                date == '21' ||
                date == '25' ||
                date == '28';

            return Center(
              child: Container(
                width: 30,
                height: 30,

                decoration:
                    BoxDecoration(
                  color: selected
                      ? primaryBlue
                      : Colors.transparent,

                  borderRadius:
                      BorderRadius.circular(
                    8,
                  ),
                ),

                alignment:
                    Alignment.center,

                child: Text(
                  date,

                  style: TextStyle(
                    fontSize: 10,

                    fontWeight: selected
                        ? FontWeight.w700
                        : FontWeight.w400,

                    color: selected
                        ? Colors.white
                        : darkText,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // ============================================================
  // AGENDA BULAN INI
  // ============================================================

  Widget _buildMonthlyAgenda({
    required String month,
    required String date,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,

      margin:
          const EdgeInsets.symmetric(
        horizontal: 24,
      ),

      height: 78,

      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),

      decoration: BoxDecoration(
        color: const Color(0xFFEAF7FC),

        borderRadius:
            BorderRadius.circular(15),

        border: Border.all(
          color: const Color(0xFFD2E9F1),
        ),
      ),

      child: Row(
        children: [
          // ======================================================
          // TANGGAL
          // ======================================================

          Container(
            width: 58,
            height: 62,

            decoration:
                BoxDecoration(
              color: primaryBlue,

              borderRadius:
                  BorderRadius.circular(
                12,
              ),
            ),

            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [
                Text(
                  month,

                  style:
                      const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 1),

                Text(
                  date,

                  style:
                      const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    height: 1,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // ======================================================
          // TEXT
          // ======================================================

          Expanded(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  maxLines: 1,

                  overflow:
                      TextOverflow.ellipsis,

                  style:
                      const TextStyle(
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w700,
                    color: darkText,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  subtitle,

                  maxLines: 1,

                  overflow:
                      TextOverflow.ellipsis,

                  style:
                      const TextStyle(
                    fontSize: 10,
                    color: greyText,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // ======================================================
          // ICON KALENDER
          // ======================================================

          Container(
            width: 46,
            height: 46,

            decoration:
                BoxDecoration(
              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(
                11,
              ),
            ),

            child: const Icon(
              Icons.calendar_month_outlined,
              size: 22,
              color: primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PUSAT BANTUAN
  // ============================================================

  Widget _buildHelpButton() {
    return Positioned(
      right: 26,

      // DITURUNKAN SEDIKIT,
      // TAPI TETAP DI ATAS NAVBAR
      bottom: 14,

      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,

            MaterialPageRoute(
              builder: (context) =>
                  const BantuanScreen(),
            ),
          );
        },

        child: Container(
          width: 58,
          height: 58,

          decoration:
              BoxDecoration(
            color: primaryBlue,

            borderRadius:
                BorderRadius.circular(
              18,
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withValues(
                  alpha: 0.15,
                ),

                blurRadius: 10,

                offset:
                    const Offset(0, 4),
              ),
            ],
          ),

          child: const Icon(
            Icons.support_agent_rounded,

            size: 29,

            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION BAR (identik home & keuangan)
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
            Expanded(
              child: _navItem(
                Icons.home_outlined,
                Icons.home_rounded,
                'Beranda',
                false,
                () => Navigator.popUntil(context, (route) => route.isFirst),
              ),
            ),
            Expanded(
              child: _navItem(
                Icons.grid_view_rounded,
                Icons.grid_view_rounded,
                'Layanan',
                false,
                () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: _navItem(
                Icons.calendar_month_outlined,
                Icons.calendar_month_rounded,
                'Agenda',
                true,
                () {},
              ),
            ),
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
                  active ? on : off,
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