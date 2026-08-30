// ================================================================
// DATA LOWONGAN KETENAGAKERJAAN (Portal Disnaker Sragen)
// ================================================================

class JobItem {
  final int id;
  final String title;
  final bool aktif;
  final String awal;
  final String akhir;
  final String posted;
  final String description;
  final List<String> requirements;
  final String email;

  const JobItem({
    required this.id,
    required this.title,
    required this.aktif,
    required this.awal,
    required this.akhir,
    required this.posted,
    required this.description,
    this.requirements = const [],
    this.email = 'dyp.sragen@gmail.com',
  });

  /// Ringkasan singkat untuk kartu (baris deskripsi dipangkas).
  String get summary {
    final clean = description.replaceAll('\n', ' ').trim();
    return clean;
  }
}

const List<String> kDefaultRequirements = [
  'KTP asli',
  'KK asli',
  'Akte lahir asli',
  'Ijazah SD–terakhir asli',
  'Buku nikah asli (jika sudah menikah)',
  'Akte cerai asli (jika pernah bercerai)',
  'Paspor asli beserta paspor lama (jika pernah ke luar negeri)',
  'Kartu BPJS Kesehatan asli',
];

const List<JobItem> kJobList = [
  JobItem(
    id: 46,
    title: 'Konstruksi - Taiwan',
    aktif: true,
    awal: '1 Desember 2025',
    akhir: '31 Desember 2026',
    posted: '2025-12-03',
    description:
        'Deskripsi Pekerjaan – Job Konstruksi Taiwan\n'
        'Lowongan kerja konstruksi Taiwan untuk proyek pembangunan seperti '
        'gedung, pabrik, perumahan, jembatan, dan infrastruktur. Cocok bagi '
        'kandidat yang kuat secara fisik dan berpengalaman di dunia bangunan.\n\n'
        '🛠️ Tugas & Tanggung Jawab\n'
        '- Mengangkat dan memindahkan material bangunan.\n'
        '- Membantu tukang (helper) dalam pekerjaan dasar bangunan.\n'
        '- Membersihkan area kerja dan menjaga kerapihan proyek.\n'
        '- Mengoperasikan alat kerja sederhana.\n'
        '- Membantu pekerjaan formwork, besi, bata, atau beton jika dibutuhkan.\n'
        '- Mengikuti arahan mandor/supervisor proyek.\n'
        '- Siap bekerja outdoor sesuai kondisi proyek.\n\n'
        '👷 Kualifikasi\n'
        '- Pria usia 23–35 tahun.\n'
        '- Sehat jasmani dan kuat.\n'
        '- Diutamakan memiliki pengalaman kerja konstruksi/bangunan.\n'
        '- Disiplin, rajin, dan siap kerja berat.\n'
        '- Bersedia kontrak 3 tahun.\n\n'
        '💰 Gaji & Benefit\n'
        '- Gaji pokok mengikuti UMR Taiwan (NT\$ 27.470 – 30.000).\n'
        '- Overtime tersedia sesuai kebutuhan proyek.\n'
        '- Mess/akomodasi disediakan majikan.\n'
        '- Tunjangan makan (tergantung perusahaan).\n'
        '- Lingkungan kerja dengan standar keselamatan konstruksi.\n'
        '- Kontrak kerja 3 tahun.\n\n'
        '🧱 Jenis Proyek Konstruksi\n'
        '- Pembangunan gedung & apartemen.\n'
        '- Proyek pabrik & gudang.\n'
        '- Proyek jembatan dan infrastruktur.\n'
        '- Pemasangan formwork, besi, dan beton.\n'
        '- Pekerjaan finishing sederhana.\n\n'
        '📞 CP Pendaftaran\n'
        '+62 812-1501-305 / +62 812-7723-3027 / +62 812-2934-0059',
    requirements: kDefaultRequirements,
  ),
  JobItem(
    id: 45,
    title: 'Formal Manufacture - Taiwan',
    aktif: true,
    awal: '1 Desember 2025',
    akhir: '30 November 2026',
    posted: '2025-12-03',
    description:
        '🏭 Deskripsi Pekerjaan – Job Pabrik Taiwan\n'
        'Lowongan kerja pabrik Taiwan terbuka untuk kandidat yang siap bekerja '
        'di lingkungan industri seperti elektronik, komponen mesin, plastik, '
        'makanan, metal, dan manufaktur umum.\n\n'
        '🔧 Tugas & Tanggung Jawab\n'
        '- Mengoperasikan mesin produksi sesuai instruksi.\n'
        '- Melakukan perakitan (assembly) komponen.\n'
        '- Menjaga kebersihan area kerja & standar keselamatan.\n'
        '- Melakukan pengecekan kualitas (QC) sederhana.\n'
        '- Mengemas produk sebelum pengiriman.\n'
        '- Mengikuti SOP pabrik dan instruksi supervisor.\n'
        '- Siap bekerja sistem shift jika dibutuhkan.\n\n'
        '👤 Kualifikasi\n'
        '- Pria/Wanita (usia mengikuti regulasi Taiwan).\n'
        '- Sehat jasmani & rohani.\n'
        '- Mampu berdiri lama dan melakukan pekerjaan berulang (repetitif).\n'
        '- Teliti, disiplin, dan bertanggung jawab.\n'
        '- Bersedia kontrak 3 tahun.\n'
        '- Diutamakan yang memiliki pengalaman terkait manufaktur/pabrik.\n\n'
        '💰 Gaji & Benefit\n'
        '- Gaji pokok NT\$ 27.470 – 30.000/bulan (sesuai regulasi).\n'
        '- Lembur tersedia banyak, terutama pabrik elektronik.\n'
        '- Mess/akomodasi disediakan (menyesuaikan majikan).\n'
        '- Makan disediakan atau tunjangan (tergantung pabrik).\n'
        '- Kontrak kerja 3 tahun.\n\n'
        '🏢 Jenis Pabrik di Taiwan\n'
        '- Elektronik – perakitan komponen, chip, panel, sensor.\n'
        '- Plastik & Kemasan – produksi moulding, botol, kemasan makanan.\n'
        '- Metal & Mesin – fabrikasi, stamping, alat industri.\n'
        '- Pabrik Makanan – roti, minuman, frozen food.\n'
        '- Manufaktur Umum – berbagai lini produksi.\n\n'
        '📞 CP Pendaftaran\n'
        '+62 812-1501-305 / +62 812-7723-3027 / +62 812-2934-0059',
    requirements: kDefaultRequirements,
  ),
  JobItem(
    id: 41,
    title: 'Perkebunan - Taiwan',
    aktif: true,
    awal: '1 Desember 2025',
    akhir: '3 Desember 2026',
    posted: '2025-12-03',
    description:
        '🌱 Deskripsi Pekerjaan – Job Perkebunan Taiwan\n'
        'Lowongan kerja perkebunan Taiwan terbuka bagi kandidat yang memiliki '
        'pengalaman pertanian apa pun, seperti berkebun, bercocok tanam, '
        'sayuran, buah, tanaman hias, atau bekerja di ladang/sawah.\n\n'
        '🌿 Tugas & Tanggung Jawab\n'
        '1. Menanam, merawat, dan memanen berbagai hasil perkebunan.\n'
        '2. Melakukan penyiraman, pemupukan, dan perawatan tanaman rutin.\n'
        '3. Membersihkan area kebun dan peralatan kerja.\n'
        '4. Membantu proses pengemasan hasil panen.\n'
        '5. Mengoperasikan alat pertanian sederhana.\n'
        '6. Bekerja sesuai kondisi cuaca dan kebutuhan kebun.\n'
        '7. Bekerja sama dalam tim dan mengikuti instruksi majikan.\n\n'
        '🍀 Kualifikasi\n'
        '1. Pria/Wanita (usia sesuai syarat Taiwan).\n'
        '2. Diutamakan berpengalaman pertanian apa pun.\n'
        '3. Sehat jasmani & kuat bekerja outdoor.\n'
        '4. Rajin, jujur, disiplin.\n'
        '5. Bersedia kontrak 3 tahun.\n\n'
        '💰 Gaji & Benefit\n'
        '- Gaji pokok NT\$ 27.470 – 30.000/bulan.\n'
        '- Overtime tersedia sesuai kebutuhan majikan.\n'
        '- Mess/akomodasi disediakan.\n'
        '- Tunjangan makan (tergantung majikan).\n'
        '- Fasilitas kerja lengkap.\n'
        '- Kontrak kerja 3 tahun.\n\n'
        '🌾 Keunggulan Job Perkebunan\n'
        '- Cocok bagi yang punya pengalaman bertani.\n'
        '- Lingkungan kerja luas & tidak monoton.\n'
        '- Banyak peluang lembur terutama saat panen.\n'
        '- Menambah skill pertanian modern di Taiwan.\n\n'
        '📞 CP Pendaftaran\n'
        '+62 812-1501-305 / +62 812-7723-3027 / +62 812-2934-0059',
    requirements: kDefaultRequirements,
  ),
  JobItem(
    id: 39,
    title: 'Panti Jompo (Caregiver / Perawat Lansia) - Taiwan',
    aktif: true,
    awal: '1 Desember 2025',
    akhir: '31 Desember 2026',
    posted: '2025-12-03',
    description:
        '📘 Deskripsi Pekerjaan\n'
        '1. Merawat dan mendampingi lansia di panti jompo.\n'
        '2. Membantu aktivitas harian lansia: makan, mandi, berpakaian, dan '
        'mobilitas.\n'
        '3. Mengukur tanda-tanda vital seperti tekanan darah, suhu tubuh, atau '
        'kondisi kesehatan harian (sesuai SOP panti).\n'
        '4. Membersihkan dan merapikan kamar serta area pasien.\n'
        '5. Mengganti popok dan membantu ke toilet bagi lansia yang '
        'membutuhkan.\n'
        '6. Menemani lansia berjalan, berolahraga ringan, atau terapi '
        'sederhana.\n'
        '7. Mengatur jadwal makan/minum obat sesuai instruksi '
        'perawat/pembimbing.\n'
        '8. Melaporkan kondisi kesehatan lansia kepada supervisor panti atau '
        'perawat senior.\n'
        '9. Mengikuti aturan dan standar kerja panti jompo Taiwan.\n\n'
        '🧑‍⚕️ Kualifikasi\n'
        '1. Pria/wanita usia 20–40 tahun (tergantung kebijakan panti).\n'
        '2. Sehat jasmani & rohani.\n'
        '3. Sabar, telaten, dan memiliki empati tinggi.\n'
        '4. Siap bekerja sistem shift.\n'
        '5. Tidak takut merawat lansia yang sakit atau tidak bisa bergerak.\n'
        '6. Pengalaman merawat orang tua/lansia menjadi nilai tambah.\n'
        '7. Bersedia mengikuti pelatihan caregiving sebelum berangkat.\n\n'
        '💰 Gaji & Benefit (Umum Panti Jompo Taiwan)\n'
        '1. Gaji basic NTD 28.590 – 29.000 (sesuai regulasi pemerintah '
        'Taiwan).\n'
        '2. Overtime tersedia (lembur tambahan setiap bulan). Total pendapatan '
        'bisa mencapai NTD 30.000 – 40.000+ tergantung lembur.\n'
        '3. Disediakan tempat tinggal (asrama panti).\n'
        '4. Makan disediakan atau mendapatkan uang makan (tergantung panti).\n'
        '5. Asuransi kesehatan & asuransi kerja.\n'
        '6. Kontrak kerja 3 tahun, dapat diperpanjang.\n\n'
        '📍 Tempat Penempatan\n'
        'Panti jompo & pusat perawatan lansia di seluruh Taiwan:\n'
        '1. Taipei\n2. Taichung\n3. Tainan\n4. Kaohsiung\n5. Hsinchu dan '
        'wilayah lainnya\n\n'
        '📞 Kontak Pendaftaran\n'
        '+62 812-1501-305\n+62 812-7723-3027\n+62 812-2934-0059',
    requirements: kDefaultRequirements,
  ),
  JobItem(
    id: 30,
    title: 'Domestik Worker (Asisten Rumah Tangga) - Taiwan',
    aktif: true,
    awal: '1 Desember 2025',
    akhir: '31 Desember 2026',
    posted: '2025-12-02',
    description:
        '📌 DESKRIPSI PEKERJAAN Asisten Rumah Tangga (ART) – Taiwan\n\n'
        '📍 Lokasi Kerja\n'
        'Penempatan di rumah majikan wilayah Taiwan, berdasarkan kebutuhan dan '
        'ketentuan agensi/perusahaan.\n\n'
        '🛠️ Tugas & Tanggung Jawab\n'
        '1. Membersihkan rumah: menyapu, mengepel, merapikan kamar, dan '
        'menjaga kebersihan seluruh ruangan.\n'
        '2. Mencuci & menyetrika pakaian.\n'
        '3. Memasak dan menyiapkan makanan sesuai instruksi majikan.\n'
        '4. Mengurus kebutuhan rumah tangga, termasuk belanja harian dan '
        'menjaga kerapian rumah.\n'
        '5. Merawat anak atau lansia (sesuai kontrak penempatan).\n'
        '6. Menjalankan tugas tambahan yang ditugaskan majikan.\n'
        '7. Menjaga sikap jujur, sopan, dan bertanggung jawab.\n\n'
        '💼 Kualifikasi\n'
        '1. Perempuan, usia sesuai ketentuan (umumnya 23–45 tahun).\n'
        '2. Sehat jasmani & rohani.\n'
        '3. Sabar, rajin, dan mampu bekerja mandiri.\n'
        '4. Pengalaman diutamakan, non pengalaman diterima setelah pelatihan.\n'
        '5. Mampu beradaptasi dan mengikuti aturan kerja di Taiwan.\n\n'
        '💰 Gaji & Fasilitas Gaji ART Taiwan\n'
        'Gaji pokok: NT\$ 20.000 – 26.000 / bulan (mengikuti standar terbaru '
        'dan jenis pekerjaan: ART rumah biasa, ART jaga anak, jaga lansia).\n'
        '1. Makan & tempat tinggal disediakan majikan.\n'
        '2. Ada lembur sesuai kebutuhan majikan.\n'
        '3. Libur sesuai regulasi Taiwan.\n'
        '4. Asuransi kesehatan & tenaga kerja.\n'
        '5. Kontrak kerja 3 tahun, dapat diperpanjang.\n\n'
        '📲 Contact Person Pendaftaran\n'
        '+62 812-1501-305\n+62 812-7723-3027\n+62 812-2934-0059',
    requirements: kDefaultRequirements,
  ),
];
