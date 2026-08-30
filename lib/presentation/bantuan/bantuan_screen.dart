import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BantuanScreen extends StatefulWidget {
  const BantuanScreen({super.key});

  @override
  State<BantuanScreen> createState() => _BantuanScreenState();
}

class _BantuanScreenState extends State<BantuanScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  int? expandedIndex;

  final Color primaryBlue = const Color(0xFF0066B3);
  final Color darkText = const Color(0xFF202020);
  final Color greyText = const Color(0xFF6D7680);
  final Color background = const Color(0xFFF8FAFC);

  final List<Map<String, String>> faqList = [
    {
      'question': 'Bagaimana cara cetak E-Tiket?',
      'answer':
          'Buka menu Agenda, pilih agenda yang ingin diikuti, kemudian lakukan reservasi. E-Tiket dapat dilihat setelah reservasi berhasil.',
    },
    {
      'question': 'Bagaimana jika NIK tidak terverifikasi?',
      'answer':
          'Pastikan NIK yang dimasukkan sudah benar dan sesuai dengan data kependudukan. Jika masih mengalami kendala, silakan hubungi pusat bantuan.',
    },
    {
      'question': 'Bagaimana cara menggunakan layanan?',
      'answer':
          'Pilih menu Layanan pada navigasi bagian bawah, kemudian pilih layanan yang ingin digunakan.',
    },
    {
      'question': 'Bagaimana cara melihat agenda kota?',
      'answer':
          'Pilih menu Agenda atau geser bagian Agenda Kota pada halaman Beranda.',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  24,
                  22,
                  24,
                  110,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearch(),

                    const SizedBox(height: 32),

                    _buildHelpBanner(),

                    const SizedBox(height: 36),

                    _buildContactSection(),

                    const SizedBox(height: 36),

                    _buildFaqSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: background,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),

          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 32,
              color: Color(0xFF0066B3),
            ),
          ),

          const SizedBox(width: 5),

          Text(
            'Pusat Bantuan',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SEARCH
  // ============================================================

  Widget _buildSearch() {
    return Container(
      height: 76,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFB9C5D4),
          width: 1.4,
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),

          const Icon(
            Icons.search_rounded,
            size: 36,
            color: Color(0xFF006A9E),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari bantuan atau topik...',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 17,
                  color: greyText,
                ),
                border: InputBorder.none,
              ),
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: darkText,
              ),
            ),
          ),

          const SizedBox(width: 15),
        ],
      ),
    );
  }

  // ============================================================
  // BANNER BANTUAN
  // ============================================================

  Widget _buildHelpBanner() {
    return Container(
      width: double.infinity,
      height: 408,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0788BE),
            Color(0xFF168CC2),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 35,
            top: 100,
            child: Icon(
              Icons.support_agent_rounded,
              size: 115,
              color: Colors.white.withValues(alpha: 0.20),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(
              28,
              52,
              25,
              25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Butuh Bantuan?',
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: 250,
                  child: Text(
                    'Hubungi PPID Kabupaten '
                    'Sragen untuk bantuan '
                    'langsung.',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      height: 1.45,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 26),

                GestureDetector(
                  onTap: () {
                    _showMessage('Hubungi PPID');
                  },
                  child: Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF007E72),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Hubungi PPID',
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(width: 12),

                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 25,
                        ),
                      ],
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

  // ============================================================
  // HUBUNGI KAMI
  // ============================================================

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hubungi Kami',
          style: GoogleFonts.poppins(
            fontSize: 23,
            fontWeight: FontWeight.w600,
            color: darkText,
          ),
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: _buildContactCard(
                icon: Icons.chat_bubble_outline_rounded,
                title: 'WhatsApp',
                iconColor: const Color(0xFF20C76A),
                backgroundColor: const Color(0xFFE5F9ED),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: _buildContactCard(
                icon: Icons.phone_outlined,
                title: 'Call Center',
                iconColor: const Color(0xFF0066B3),
                backgroundColor: const Color(0xFFE8F0F8),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: _buildContactCard(
                icon: Icons.email_outlined,
                title: 'Email',
                iconColor: const Color(0xFF5557A6),
                backgroundColor: const Color(0xFFECECF7),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // CONTACT CARD
  // ============================================================

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required Color iconColor,
    required Color backgroundColor,
  }) {
    return GestureDetector(
      onTap: () {
        _showMessage(title);
      },
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFB9C5D4),
            width: 1.2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: iconColor,
              ),
            ),

            const SizedBox(height: 14),

            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FAQ
  // ============================================================

  Widget _buildFaqSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tanya Jawab Umum',
          style: GoogleFonts.poppins(
            fontSize: 23,
            fontWeight: FontWeight.w600,
            color: darkText,
          ),
        ),

        const SizedBox(height: 20),

        ...List.generate(
          faqList.length,
          (index) {
            final faq = faqList[index];
            final bool isExpanded =
                expandedIndex == index;

            return Padding(
              padding: const EdgeInsets.only(
                bottom: 12,
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (expandedIndex == index) {
                      expandedIndex = null;
                    } else {
                      expandedIndex = index;
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(17),
                    border: Border.all(
                      color: const Color(0xFFB9C5D4),
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              faq['question']!,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: darkText,
                              ),
                            ),
                          ),

                          Icon(
                            isExpanded
                                ? Icons
                                    .keyboard_arrow_up_rounded
                                : Icons
                                    .keyboard_arrow_down_rounded,
                            size: 30,
                            color: greyText,
                          ),
                        ],
                      ),

                      if (isExpanded) ...[
                        const SizedBox(height: 14),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            faq['answer']!,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              height: 1.5,
                              color: greyText,
                            ),
                          ),
                        ),
                      ],
                    ],
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
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNavigation() {
    return Container(
      height: 86,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            label: 'Beranda',
            active: false,
            onTap: () {
              Navigator.pop(context);
            },
          ),

          _buildNavItem(
            icon: Icons.apps_outlined,
            activeIcon: Icons.apps_rounded,
            label: 'Layanan',
            active: true,
            onTap: () {
              _showMessage('Layanan');
            },
          ),

          _buildNavItem(
            icon: Icons.calendar_month_outlined,
            activeIcon: Icons.calendar_month_rounded,
            label: 'Agenda',
            active: false,
            onTap: () {
              _showMessage('Agenda');
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // NAV ITEM
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
      child: Container(
        width: 105,
        height: 58,
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFF55D9EE)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              active ? activeIcon : icon,
              size: 25,
              color: active
                  ? const Color(0xFF315278)
                  : const Color(0xFF343C45),
            ),

            const SizedBox(height: 2),

            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: active
                    ? const Color(0xFF315278)
                    : const Color(0xFF343C45),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String title) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Fitur ini akan tersedia pada '
                  'tahap berikutnya.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: greyText,
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}