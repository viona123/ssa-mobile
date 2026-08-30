import 'package:flutter/material.dart';
import '../../agenda/agenda_screen.dart';

// ================================================================
// JADWAL DOKTER - RSUD SOEHADI PRIJONEGORO
// Menampilkan jadwal dokter per hari dan per poliklinik
// ================================================================

class JadwalDokterScreen extends StatefulWidget {
  final String hospitalName;
  final String hospitalLocation;

  const JadwalDokterScreen({
    super.key,
    required this.hospitalName,
    required this.hospitalLocation,
  });

  @override
  State<JadwalDokterScreen> createState() => _JadwalDokterScreenState();
}

class _JadwalDokterScreenState extends State<JadwalDokterScreen> {
  // ============================================================
  // COLORS
  // ============================================================

  static const Color primaryGreen = Color(0xFF1B6B5B);
  static const Color mintGreen = Color(0xFFE8F5F1);
  static const Color darkText = Color(0xFF202124);
  static const Color greyText = Color(0xFF737B86);
  static const Color pageBackground = Color(0xFFF8FAFC);
  static const Color cardBorder = Color(0xFFE8ECEF);

  // Navbar colors
  static const Color primaryBlue = Color(0xFF007EA7);
  static const Color lightBlue = Color(0xFF58D8EC);
  static const Color darkBlue = Color(0xFF315579);

  // ============================================================
  // STATE
  // ============================================================

  int _selectedDay = 0; // 0 = Senin
  int _selectedPoli = 0; // index poliklinik

  // ============================================================
  // DATA HARI
  // ============================================================

  final List<String> _days = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  // ============================================================
  // DATA POLIKLINIK (28)
  // ============================================================

  final List<String> _poliklinik = [
    'Anastesi',
    'Hemodialisa',
    'Kemo Terapi',
    'Instalasi Rehabilitasi Medik',
    'Poliklinik Spesialis Dalam',
    'Poliklinik Spesialis Jantung',
    'Poliklinik Spesialis Syaraf',
    'Poliklinik Spesialis Orthopedi',
    'Poliklinik Spesialis Paru-Paru',
    'Poliklinik Spesialis Bedah',
    'Poliklinik Spesialis Urologi',
    'Poliklinik Spesialis Jiwa',
    'Poliklinik Spesialis Gigi',
    'Poliklinik Spesialis Kandungan',
    'Poliklinik Spesialis Oncologi',
    'Poliklinik Spesialis Kulit dan Kelamin',
    'Poliklinik Spesialis Mata',
    'Poliklinik Spesialis THT',
    'Poliklinik Spesialis Anak',
    'Poliklinik Umum',
    'Poliklinik Geriatri',
    'Poliklinik Gizi',
    'Poliklinik VCT',
    'Poliklinik Tumbuh Kembang',
    'Poliklinik Bedah Saraf',
    'Poliklinik Bedah Plastik',
    'Poliklinik Kardiologi',
    'Poliklinik Penyakit Dalam Konsultan',
  ];

  // ============================================================
  // DATA DOKTER PER POLIKLINIK
  // ============================================================

  Map<String, List<_DokterItem>> get _dokterData => {
        'Anastesi': [
          _DokterItem(
            nama: 'dr. Andi Ris Firmansyah, Sp.AN, M.Kes',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
          _DokterItem(
            nama: 'dr. Derajad Bayu Atmawan, Sp.An',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
          _DokterItem(
            nama: 'dr. Hanifa Agung Kurniawan, Sp.An',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
          _DokterItem(
            nama: 'dr. Indrati Tyas Siwi TR., Sp.An',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
        ],
        'Hemodialisa': [
          _DokterItem(
            nama: 'dr. Lulus Budiarto, Sp.PD',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
          _DokterItem(
            nama: 'dr. Nurul Aini, M.Sc., Sp.PD',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
        ],
        'Kemo Terapi': [
          _DokterItem(
            nama: 'dr. Agus Suryanto, Sp.PD',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
        ],
        'Instalasi Rehabilitasi Medik': [
          _DokterItem(
            nama: 'dr. Sri Wahyuni, Sp.KFR',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
        ],
        'Poliklinik Spesialis Dalam': [
          _DokterItem(
            nama: 'dr. Lulus Budiarto, Sp.PD',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
          _DokterItem(
            nama: 'dr. Nurul Aini, M.Sc., Sp.PD',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
          _DokterItem(
            nama: 'dr. Agus Suryanto, Sp.PD',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
        ],
        'Poliklinik Spesialis Jantung': [
          _DokterItem(
            nama: 'dr. Hari Susanto, Sp.JP',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
          _DokterItem(
            nama: 'dr. Bambang Irawan, Sp.JP',
            hari: 'Senin, Rabu, Jumat',
            jam: '08:00 – 12:00',
          ),
        ],
        'Poliklinik Spesialis Syaraf': [
          _DokterItem(
            nama: 'dr. Siti Aminah, Sp.S',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
          _DokterItem(
            nama: 'dr. Wahyu Purnomo, Sp.S',
            hari: 'Senin - Jumat',
            jam: '08:00 – 13:00',
          ),
        ],
        'Poliklinik Spesialis Orthopedi': [
          _DokterItem(
            nama: 'dr. Hendro Cahyono, Sp.OT',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
        ],
        'Poliklinik Spesialis Paru-Paru': [
          _DokterItem(
            nama: 'dr. Rini Hastuti, Sp.P',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
          _DokterItem(
            nama: 'dr. Arif Setiawan, Sp.P',
            hari: 'Senin, Selasa, Kamis',
            jam: '08:00 – 12:00',
          ),
        ],
        'Poliklinik Spesialis Bedah': [
          _DokterItem(
            nama: 'dr. Teguh Santoso, Sp.B',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
          _DokterItem(
            nama: 'dr. Joko Widodo, Sp.B',
            hari: 'Senin - Jumat',
            jam: '08:00 – 13:00',
          ),
        ],
        'Poliklinik Spesialis Urologi': [
          _DokterItem(
            nama: 'dr. Budi Prasetyo, Sp.U',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
        ],
        'Poliklinik Spesialis Jiwa': [
          _DokterItem(
            nama: 'dr. Ratna Dewi, Sp.KJ',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
        ],
        'Poliklinik Spesialis Gigi': [
          _DokterItem(
            nama: 'drg. Endah Puji Rahayu, Sp.BM',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
          _DokterItem(
            nama: 'drg. Santi Wulandari, Sp.Ort',
            hari: 'Senin, Rabu, Jumat',
            jam: '08:00 – 12:00',
          ),
        ],
        'Poliklinik Spesialis Kandungan': [
          _DokterItem(
            nama: 'dr. Eko Haryanto, Sp.OG',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
          _DokterItem(
            nama: 'dr. Maya Sari, Sp.OG',
            hari: 'Senin - Jumat',
            jam: '08:00 – 13:00',
          ),
        ],
        'Poliklinik Spesialis Oncologi': [
          _DokterItem(
            nama: 'dr. Agus Suryanto, Sp.PD',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
        ],
        'Poliklinik Spesialis Kulit dan Kelamin': [
          _DokterItem(
            nama: 'dr. Yuni Astuti, Sp.KK',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
        ],
        'Poliklinik Spesialis Mata': [
          _DokterItem(
            nama: 'dr. Widi Nugroho, Sp.M',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
          _DokterItem(
            nama: 'dr. Putri Handayani, Sp.M',
            hari: 'Selasa, Kamis, Sabtu',
            jam: '08:00 – 12:00',
          ),
        ],
        'Poliklinik Spesialis THT': [
          _DokterItem(
            nama: 'dr. Doni Kurniawan, Sp.THT-KL',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
        ],
        'Poliklinik Spesialis Anak': [
          _DokterItem(
            nama: 'dr. Fitri Rahmawati, Sp.A',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
          _DokterItem(
            nama: 'dr. Ahmad Fauzi, Sp.A',
            hari: 'Senin - Jumat',
            jam: '08:00 – 13:00',
          ),
        ],
        'Poliklinik Umum': [
          _DokterItem(
            nama: 'dr. Hendra Wijaya',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
          _DokterItem(
            nama: 'dr. Rina Susanti',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
        ],
        'Poliklinik Geriatri': [
          _DokterItem(
            nama: 'dr. Sulistyo, Sp.PD',
            hari: 'Senin - Jumat',
            jam: '08:00 – 13:00',
          ),
        ],
        'Poliklinik Gizi': [
          _DokterItem(
            nama: 'dr. Dewi Ratnasari, M.Gizi',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
        ],
        'Poliklinik VCT': [
          _DokterItem(
            nama: 'dr. Andi Pratama',
            hari: 'Senin - Jumat',
            jam: '08:00 – 14:00',
          ),
        ],
        'Poliklinik Tumbuh Kembang': [
          _DokterItem(
            nama: 'dr. Fitri Rahmawati, Sp.A',
            hari: 'Selasa, Kamis',
            jam: '09:00 – 12:00',
          ),
        ],
        'Poliklinik Bedah Saraf': [
          _DokterItem(
            nama: 'dr. Yoga Permana, Sp.BS',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
        ],
        'Poliklinik Bedah Plastik': [
          _DokterItem(
            nama: 'dr. Rendra Kusuma, Sp.BP-RE',
            hari: 'Rabu, Jumat',
            jam: '08:00 – 12:00',
          ),
        ],
        'Poliklinik Kardiologi': [
          _DokterItem(
            nama: 'dr. Hari Susanto, Sp.JP',
            hari: 'Senin - Sabtu',
            jam: '08:00 – 14:00',
          ),
        ],
        'Poliklinik Penyakit Dalam Konsultan': [
          _DokterItem(
            nama: 'dr. Lulus Budiarto, Sp.PD-KGH',
            hari: 'Senin - Jumat',
            jam: '08:00 – 13:00',
          ),
        ],
      };

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
            // HEADER
            _buildHeader(),

            // CONTENT
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // HOSPITAL CARD KECIL
                    _buildHospitalMiniCard(),

                    const SizedBox(height: 22),

                    // TITLE
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Jadwal Dokter',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: darkText,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // PILIH POLI (KIRI) & HARI (KANAN)
                    _buildDropdownRow(),

                    const SizedBox(height: 20),

                    // DAFTAR DOKTER
                    _buildDoctorList(),
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
  // HEADER
  // ============================================================

  Widget _buildHeader() {
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
            'Layanan Poli RSUD',
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
  // HOSPITAL MINI CARD
  // ============================================================

  Widget _buildHospitalMiniCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1F7A68), Color(0xFF145047)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: primaryGreen.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // ICON
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.local_hospital_rounded,
              size: 22,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 14),

          // TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.hospitalName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${widget.hospitalLocation}, Kabupaten Sragen',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.8),
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
  // DROPDOWN ROW (POLI KIRI, HARI KANAN)
  // ============================================================

  Widget _buildDropdownRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // POLI (KIRI) - lebih lebar
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Poliklinik',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: greyText,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: cardBorder, width: 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: _selectedPoli,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: primaryGreen, size: 20),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: darkText,
                      ),
                      items: List.generate(_poliklinik.length, (index) {
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Text(
                            _poliklinik[index],
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedPoli = value;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // HARI (KANAN)
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hari',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: greyText,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: cardBorder, width: 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: _selectedDay,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: primaryGreen, size: 20),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: darkText,
                      ),
                      items: List.generate(_days.length, (index) {
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Text(_days[index]),
                        );
                      }),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedDay = value;
                          });
                        }
                      },
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
  // DOCTOR LIST
  // ============================================================

  Widget _buildDoctorList() {
    final String selectedPoliName = _poliklinik[_selectedPoli];
    final List<_DokterItem> doctors =
        _dokterData[selectedPoliName] ?? [];

    // Filter berdasarkan hari yang dipilih
    final String selectedDayName = _days[_selectedDay];
    final List<_DokterItem> filteredDoctors = doctors.where((doc) {
      return _isDoctorAvailable(doc.hari, selectedDayName);
    }).toList();

    if (filteredDoctors.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.event_busy_rounded,
                size: 56,
                color: greyText.withValues(alpha: 0.4),
              ),
              const SizedBox(height: 12),
              const Text(
                'Tidak ada jadwal dokter\npada hari ini',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: greyText,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // JUMLAH DOKTER
          Text(
            '${filteredDoctors.length} Dokter tersedia',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: greyText,
            ),
          ),
          const SizedBox(height: 12),

          // LIST
          ...filteredDoctors.map((dokter) => _buildDoctorCard(dokter)),
        ],
      ),
    );
  }

  // ============================================================
  // DOCTOR CARD
  // ============================================================

  Widget _buildDoctorCard(_DokterItem dokter) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // NAMA DOKTER
          Row(
            children: [
              // AVATAR
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: mintGreen,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  size: 22,
                  color: primaryGreen,
                ),
              ),
              const SizedBox(width: 12),

              // NAMA & POLI
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dokter.nama,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: darkText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _poliklinik[_selectedPoli],
                      style: const TextStyle(
                        fontSize: 11,
                        color: primaryGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // DIVIDER
          Container(
            width: double.infinity,
            height: 1,
            color: const Color(0xFFF0F2F5),
          ),

          const SizedBox(height: 14),

          // HARI & JAM
          Row(
            children: [
              // HARI
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 15,
                      color: greyText,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hari',
                            style: TextStyle(
                              fontSize: 10,
                              color: greyText,
                            ),
                          ),
                          Text(
                            dokter.hari,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: darkText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // JAM
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 15,
                      color: greyText,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Jam',
                            style: TextStyle(
                              fontSize: 10,
                              color: greyText,
                            ),
                          ),
                          Text(
                            dokter.jam,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: darkText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // BUTTON RESERVASI
          SizedBox(
            width: double.infinity,
            height: 38,
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Navigate to reservasi
              },
              icon: const Icon(Icons.edit_calendar_rounded, size: 16),
              label: const Text(
                'Reservasi',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HELPER - CEK KETERSEDIAAN HARI
  // ============================================================

  bool _isDoctorAvailable(String hariDokter, String hariDipilih) {
    final String lower = hariDokter.toLowerCase();

    // "Senin - Sabtu" berarti hari Minggu libur
    if (lower.contains('senin - sabtu') || lower.contains('senin-sabtu')) {
      return hariDipilih != 'Minggu';
    }

    // "Senin - Jumat"
    if (lower.contains('senin - jumat') || lower.contains('senin-jumat')) {
      return hariDipilih != 'Sabtu' && hariDipilih != 'Minggu';
    }

    // Cek langsung hari tertentu
    return lower.contains(hariDipilih.toLowerCase());
  }

  // ============================================================
  // BOTTOM NAVIGATION (identik home_screen & agenda_screen)
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
              child: _navItem(
                Icons.home_outlined,
                Icons.home_rounded,
                'Beranda',
                false,
                () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
            ),
            Expanded(
              child: _navItem(
                Icons.grid_view_rounded,
                Icons.grid_view_rounded,
                'Layanan',
                true,
                () {},
              ),
            ),
            Expanded(
              child: _navItem(
                Icons.calendar_month_outlined,
                Icons.calendar_month_rounded,
                'Agenda',
                false,
                () {
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

  Widget _navItem(
    IconData offIcon,
    IconData onIcon,
    String label,
    bool active,
    VoidCallback onTap,
  ) {
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
                  active ? onIcon : offIcon,
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
// DOKTER MODEL
// ================================================================

class _DokterItem {
  final String nama;
  final String hari;
  final String jam;

  const _DokterItem({
    required this.nama,
    required this.hari,
    required this.jam,
  });
}
