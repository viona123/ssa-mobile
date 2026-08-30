/// Model data untuk halaman Detail Inovasi.
class InovasiDetail {
  final String kategoriLabel; // subtitle hijau kecil, mis. "INOVASI SRAGEN HEALTH"
  final String judul;
  final String inisiator;
  final String jenis;
  final String tahapan;
  final String waktuUjiCoba;
  final String waktuPenerapan;
  final String urusanPemerintahan;
  final List<InovasiSection> sections;

  const InovasiDetail({
    required this.kategoriLabel,
    required this.judul,
    required this.inisiator,
    required this.jenis,
    required this.tahapan,
    required this.waktuUjiCoba,
    required this.waktuPenerapan,
    required this.urusanPemerintahan,
    required this.sections,
  });
}

/// Satu section besar (mis. Rancang Bangun, Tujuan, Manfaat, Hasil).
class InovasiSection {
  final String title;
  final List<InovasiBlock> blocks;

  const InovasiSection({required this.title, required this.blocks});
}

/// Jenis blok konten.
enum BlockType {
  heading, // sub-judul dalam section
  banner, // header bar hijau gelap (seperti "1. TUJUAN SEKTOR ...")
  paragraph, // paragraf biasa
  bullets, // daftar berpoin (dot hijau)
  numbered, // daftar bernomor (lingkaran hijau)
  bulletTitled, // daftar berpoin dengan judul tebal + deskripsi
}

/// Satu blok konten dalam sebuah section.
class InovasiBlock {
  final BlockType type;
  final String? text; // untuk heading / banner / paragraph
  final List<String>? items; // untuk bullets / numbered
  final List<TitledItem>? titledItems; // untuk bulletTitled

  const InovasiBlock.heading(this.text)
      : type = BlockType.heading,
        items = null,
        titledItems = null;

  const InovasiBlock.banner(this.text)
      : type = BlockType.banner,
        items = null,
        titledItems = null;

  const InovasiBlock.paragraph(this.text)
      : type = BlockType.paragraph,
        items = null,
        titledItems = null;

  const InovasiBlock.bullets(this.items)
      : type = BlockType.bullets,
        text = null,
        titledItems = null;

  const InovasiBlock.numbered(this.items)
      : type = BlockType.numbered,
        text = null,
        titledItems = null;

  const InovasiBlock.bulletTitled(this.titledItems)
      : type = BlockType.bulletTitled,
        text = null,
        items = null;
}

/// Item untuk bulletTitled: judul tebal + deskripsi.
class TitledItem {
  final String title;
  final String description;
  const TitledItem(this.title, this.description);
}

// ================================================================
// DATA: SIKASEP RISKI BILAR
// ================================================================
const InovasiDetail sikasepRiskiBilar = InovasiDetail(
  kategoriLabel: 'INOVASI SRAGEN HEALTH',
  judul:
      'SIKASEP RISKI BILAR (Sistem Kartu Skor Pencegahan Risiko Tinggi Berat Lahir Rendah)',
  inisiator: 'ASN',
  jenis: 'Non Digital',
  tahapan: 'Penerapan',
  waktuUjiCoba: '13 Agustus 2026',
  waktuPenerapan: '18 Agustus 2026',
  urusanPemerintahan: 'Kesehatan',
  sections: [
    // ==========================================================
    // RANCANG BANGUN
    // ==========================================================
    InovasiSection(
      title: 'Rancang Bangun',
      blocks: [
        InovasiBlock.heading('1. Dasar Hukum Inovasi'),
        InovasiBlock.paragraph(
          'Pelaksanaan inovasi SIKASEP RISKI BILAR berlandaskan pada ketentuan '
          'peraturan perundang-undangan dan kebijakan pembangunan kesehatan, '
          'antara lain:',
        ),
        InovasiBlock.bullets([
          'Undang-Undang Nomor 17 Tahun 2023 tentang Kesehatan, sebagai landasan utama penyelenggaraan kesehatan di Indonesia, termasuk upaya promotif dan preventif serta penguatan pelayanan kesehatan yang bermutu.',
          'Peraturan Pemerintah Nomor 28 Tahun 2024 tentang Peraturan Pelaksanaan UU Nomor 17 Tahun 2023, yang mengatur penyelenggaraan upaya kesehatan secara terpadu dan berkesinambungan.',
          'Peraturan Menteri Kesehatan Nomor 6 Tahun 2024 tentang Standar Teknis Pemenuhan SPM Kesehatan, khususnya pelayanan kesehatan ibu hamil dan bayi baru lahir (deteksi risiko, Hb, LILA, tekanan darah).',
          'Peraturan Menteri Kesehatan Nomor 19 Tahun 2024 tentang Penyelenggaraan Puskesmas sebagai fasilitas pelayanan kesehatan tingkat pertama berbasis wilayah.',
          'Kebijakan dan program nasional, provinsi, dan Kabupaten Sragen terkait peningkatan kesehatan ibu dan anak, penurunan kematian bayi, serta pencegahan BBLR.',
        ]),
        InovasiBlock.paragraph(
          'Dengan demikian, SIKASEP RISKI BILAR merupakan inovasi pelayanan '
          'kesehatan primer yang mendukung deteksi dini faktor risiko kehamilan '
          'serta penguatan intervensi preventif untuk mencegah terjadinya BBLR.',
        ),
        InovasiBlock.heading('2. Permasalahan'),
        InovasiBlock.paragraph(
          'A. Permasalahan Makro — Berat Badan Lahir Rendah (BBLR) adalah bayi '
          'dengan berat lahir kurang dari 2.500 gram. Kondisi ini meningkatkan '
          'risiko masalah kesehatan bayi, sehingga pencegahannya perlu dilakukan '
          'sejak masa kehamilan. Faktor risiko maternal antara lain:',
        ),
        InovasiBlock.bullets([
          'anemia pada ibu hamil',
          'Kekurangan Energi Kronis (KEK)',
          'hipertensi dalam kehamilan',
          'usia ibu terlalu muda atau terlalu tua',
          'jarak kehamilan yang terlalu dekat',
          'riwayat melahirkan BBLR',
          'status gizi ibu yang kurang baik',
          'keteraturan pemeriksaan kehamilan',
          'kondisi sosial ekonomi',
          'faktor kesehatan dan lingkungan lainnya',
        ]),
        InovasiBlock.paragraph(
          'B. Permasalahan Mikro — Di wilayah kerja Puskesmas Tanon I, faktor '
          'risiko BBLR belum teridentifikasi secara sistematis sejak awal '
          'kehamilan, belum ada alat bantu sederhana untuk mengenali tingkat '
          'risiko secara cepat, dan tindak lanjut belum seragam karena tingkat '
          'risiko belum divisualisasikan.',
        ),
        InovasiBlock.heading('3. Isu Strategis'),
        InovasiBlock.bullets([
          'Pencegahan BBLR sejak masa kehamilan melalui identifikasi faktor risiko yang masih dapat dimodifikasi.',
          'Penguatan deteksi dini risiko ibu hamil pada pelayanan antenatal.',
          'Penguatan pelayanan kesehatan primer berbasis wilayah (Puskesmas).',
          'Penguatan pendekatan promotif dan preventif secara kolaboratif.',
          'Peningkatan literasi kesehatan ibu hamil.',
          'Pengambilan keputusan berbasis risiko.',
        ]),
        InovasiBlock.heading('4. Metode Pembaharuan'),
        InovasiBlock.paragraph(
          'SIKASEP RISKI BILAR melakukan pembaharuan melalui sistem: '
          'Skrining → Skoring → Kategorisasi → Kartu Risiko → Edukasi → '
          'Intervensi → Pemantauan → Evaluasi.',
        ),
        InovasiBlock.numbered([
          'Setiap ibu hamil dilakukan skrining faktor risiko BBLR.',
          'Faktor risiko yang ditemukan diberi nilai/skor sesuai instrumen.',
          'Total skor digunakan untuk menentukan kategori risiko.',
          'Ibu hamil diberikan Kartu SIKASEP RISKI BILAR dengan warna sesuai kategori risiko.',
          'Ibu hamil dan keluarga mendapatkan edukasi sesuai faktor risiko.',
          'Ibu hamil risiko sedang/tinggi mendapatkan pemantauan lebih intensif.',
          'Intervensi dilakukan terhadap faktor risiko yang dapat dimodifikasi.',
          'Data risiko menjadi dasar pemetaan ibu hamil yang butuh perhatian khusus.',
        ]),
        InovasiBlock.heading('5. Keunggulan dan Kebaharuan'),
        InovasiBlock.bulletTitled([
          TitledItem('Sederhana',
              'Sistem skor mudah dipahami dan diterapkan dalam pelayanan rutin.'),
          TitledItem('Praktis',
              'Hasil skrining diterjemahkan menjadi kartu yang dapat dibawa ibu hamil.'),
          TitledItem('Visual',
              'Kategori risiko ditampilkan melalui kode warna (Hijau/Kuning/Merah).'),
          TitledItem('Berorientasi pencegahan',
              'Menemukan faktor risiko sedini mungkin selama kehamilan.'),
          TitledItem('Berbasis kolaborasi',
              'Melibatkan dokter, bidan, kader, ahli gizi, promosi kesehatan, ibu, dan keluarga.'),
          TitledItem('Mudah direplikasi',
              'Model kartu dan skoring dapat diterapkan di desa/puskesmas lain.'),
        ]),
        InovasiBlock.paragraph(
          'Kebaruan utama: mengubah hasil skrining menjadi status risiko yang '
          'terlihat dan mudah dipahami, diikuti rencana tindak lanjut — '
          'Data → Skor → Warna → Tindakan → Pemantauan → Evaluasi.',
        ),
        InovasiBlock.heading('6. Tahapan Inovasi'),
        InovasiBlock.numbered([
          'Persiapan: pembentukan tim, penyusunan instrumen skor, kategori risiko, desain kartu, SOP, dan sosialisasi.',
          'Skrining: identifikasi faktor risiko (usia, LILA, Hb, tekanan darah, riwayat BBLR, jarak kehamilan, dll.).',
          'Skoring: setiap faktor risiko diberi nilai; total skor menentukan kategori.',
          'Kategorisasi: Kartu Hijau (rendah), Kuning (sedang), Merah (tinggi).',
          'Pemberian Kartu SIKASEP RISKI BILAR sesuai kategori.',
          'Intervensi sesuai faktor risiko (anemia, KEK, hipertensi, ANC, riwayat BBLR).',
          'Pemantauan berkala oleh petugas puskesmas dan jejaring, dibantu kader.',
          'Evaluasi berkala dengan indikator cakupan skrining, kartu, tindak lanjut, dan kejadian BBLR.',
        ]),
        InovasiBlock.heading('7. Spesifikasi Produk'),
        InovasiBlock.bulletTitled([
          TitledItem('Kartu SIKASEP RISKI BILAR',
              'Identitas dan pemantauan risiko BBLR ibu hamil (data, faktor risiko, skor, kategori, warna).'),
          TitledItem('Sistem Kode Warna',
              'Hijau: risiko rendah; Kuning: risiko sedang; Merah: risiko tinggi.'),
          TitledItem('Lembar Skoring',
              'Untuk menentukan tingkat risiko berdasarkan faktor yang ditetapkan.'),
          TitledItem('SOP Pelaksanaan',
              'Mengatur alur skrining hingga evaluasi.'),
          TitledItem('Media Edukasi',
              'Menjelaskan BBLR, faktor risiko, ANC, gizi, anemia, dan tanda bahaya kehamilan.'),
        ]),
        InovasiBlock.heading('8. Alur Singkat'),
        InovasiBlock.paragraph(
          'Ibu hamil datang → Skrining faktor risiko BBLR → Pengisian kartu & '
          'perhitungan skor → Penentuan kategori risiko → Kartu warna '
          '(Hijau/Kuning/Merah) → Edukasi & intervensi → Pemantauan berkala → '
          'Evaluasi → Pencegahan BBLR.',
        ),
        InovasiBlock.heading('9. Inti Pembaharuan'),
        InovasiBlock.paragraph(
          '"Kenali risikonya, hitung skornya, tandai dengan warnanya, lakukan '
          'intervensinya, dan pantau sampai persalinan." Inovasi ini menempatkan '
          'ibu hamil sebagai subjek aktif dalam pencegahan BBLR, dan puskesmas '
          'sebagai penggerak sistem deteksi dini, intervensi, dan koordinasi.',
        ),
        InovasiBlock.heading('10. Hasil yang Diharapkan'),
        InovasiBlock.bullets([
          'Meningkatnya cakupan skrining faktor risiko BBLR pada ibu hamil.',
          'Meningkatnya kemampuan petugas mengidentifikasi ibu hamil berisiko.',
          'Meningkatnya pemahaman ibu hamil dan keluarga mengenai faktor risiko BBLR.',
          'Meningkatnya kepatuhan ANC dan tindak lanjut.',
          'Meningkatnya kecepatan intervensi terhadap faktor risiko.',
          'Terbentuknya sistem pemantauan ibu hamil berdasarkan tingkat risiko.',
          'Menurunnya angka kejadian BBLR di wilayah kerja Puskesmas Tanon I.',
        ]),
      ],
    ),

    // ==========================================================
    // TUJUAN
    // ==========================================================
    InovasiSection(
      title: 'Tujuan',
      blocks: [
        InovasiBlock.banner('A. TUJUAN UMUM'),
        InovasiBlock.paragraph(
          'Meningkatkan efektivitas pencegahan BBLR melalui deteksi dini, '
          'pengukuran tingkat risiko, pemberian penanda risiko, intervensi, dan '
          'pemantauan ibu hamil secara terintegrasi di wilayah kerja Puskesmas '
          'Tanon I. Mengubah pendekatan dari penanganan setelah BBLR menjadi '
          'preventif sejak masa kehamilan.',
        ),
        InovasiBlock.banner('B. TUJUAN KHUSUS'),
        InovasiBlock.numbered([
          'Meningkatkan cakupan skrining faktor risiko BBLR pada seluruh ibu hamil.',
          'Meningkatkan kemampuan petugas melakukan stratifikasi risiko secara sederhana dan cepat.',
          'Menyediakan Kartu SIKASEP RISKI BILAR sebagai media identifikasi, komunikasi, edukasi, dan pemantauan.',
          'Memberikan penanda visual melalui kode warna.',
          'Meningkatkan keterlibatan ibu hamil dan keluarga.',
          'Mempercepat intervensi terhadap faktor risiko yang dapat dimodifikasi.',
          'Meningkatkan koordinasi antarprofesi.',
          'Meningkatkan pemantauan ibu hamil risiko sedang dan tinggi.',
          'Menurunkan proporsi faktor risiko BBLR yang dapat dimodifikasi.',
          'Berkontribusi menurunkan angka kejadian BBLR di Puskesmas Tanon I.',
        ]),
        InovasiBlock.heading('C. Target Capaian'),
        InovasiBlock.bullets([
          'Skrining risiko BBLR: ≥95%',
          'Kategorisasi tingkat risiko: ≥95%',
          'Pemberian Kartu SIKASEP RISKI BILAR: ≥95%',
          'Tindak lanjut risiko sedang/tinggi: ≥95%',
          'Edukasi sesuai faktor risiko: ≥95%',
          'Pemantauan intensif risiko tinggi: ≥95%',
          'Keterlibatan kader: ≥90%',
          'Evaluasi faktor risiko berkala: 100% ibu hamil berisiko',
          'Penurunan faktor risiko yang dapat dimodifikasi: ≥10%',
          'Penurunan kejadian BBLR: menurun dibandingkan baseline',
        ]),
      ],
    ),

    // ==========================================================
    // MANFAAT
    // ==========================================================
    InovasiSection(
      title: 'Manfaat',
      blocks: [
        InovasiBlock.banner('A. BAGI IBU HAMIL'),
        InovasiBlock.bullets([
          'Mengetahui faktor risiko BBLR sejak dini.',
          'Memperoleh informasi tingkat risiko melalui skor dan kode warna.',
          'Mendapatkan edukasi spesifik sesuai faktor risiko.',
          'Lebih terdorong melakukan ANC secara teratur.',
          'Mendapatkan intervensi lebih cepat terhadap faktor risiko.',
          'Kartu menjadi pengingat pemeriksaan dan tindak lanjut.',
        ]),
        InovasiBlock.banner('B. BAGI KELUARGA'),
        InovasiBlock.bullets([
          'Mengetahui bahwa ibu hamil memiliki faktor risiko tertentu.',
          'Memberikan dukungan terhadap kepatuhan ANC, tablet tambah darah, dan gizi.',
          'Membantu memastikan ibu risiko sedang/tinggi memperoleh tindak lanjut.',
          'Meningkatkan keterlibatan keluarga dalam pencegahan komplikasi.',
        ]),
        InovasiBlock.banner('C. BAGI KADER KESEHATAN'),
        InovasiBlock.bullets([
          'Memudahkan mengenali ibu hamil yang membutuhkan perhatian lebih.',
          'Memudahkan komunikasi dengan bidan atau petugas puskesmas.',
          'Memperkuat fungsi pemantauan ibu hamil di masyarakat.',
        ]),
        InovasiBlock.banner('D. BAGI PETUGAS KESEHATAN'),
        InovasiBlock.bullets([
          'Memudahkan identifikasi ibu hamil berdasarkan tingkat risiko.',
          'Mempermudah penentuan prioritas pemantauan.',
          'Memperkuat komunikasi antarprofesi.',
          'Menyediakan instrumen sederhana untuk pelayanan rutin.',
        ]),
        InovasiBlock.banner('E. BAGI PEMERINTAH / PUSKESMAS'),
        InovasiBlock.bullets([
          'Meningkatkan kualitas pelayanan kesehatan ibu dan anak.',
          'Memperkuat upaya promotif dan preventif di pelayanan primer.',
          'Membantu pemetaan ibu hamil berdasarkan tingkat risiko.',
          'Menyediakan data terstruktur untuk monitoring dan evaluasi program KIA.',
          'Mendukung pencapaian target pembangunan kesehatan daerah.',
        ]),
      ],
    ),

    // ==========================================================
    // HASIL
    // ==========================================================
    InovasiSection(
      title: 'Hasil',
      blocks: [
        InovasiBlock.heading('A. Sebelum Inovasi (Before)'),
        InovasiBlock.bullets([
          'Identifikasi faktor risiko BBLR hanya melalui ANC rutin.',
          'Data faktor risiko tersebar pada berbagai dokumen pelayanan.',
          'Belum ada sistem skor khusus yang menggabungkan faktor risiko.',
          'Tingkat risiko belum divisualisasikan melalui penanda warna.',
          'Ibu hamil belum memiliki kartu khusus tingkat risiko BBLR.',
          'Pemantauan ibu hamil berisiko belum menggunakan sistem penanda seragam.',
        ]),
        InovasiBlock.heading('B. Sesudah Inovasi (After)'),
        InovasiBlock.bullets([
          'Ibu hamil mendapatkan skrining faktor risiko secara sistematis.',
          'Faktor risiko dihitung menggunakan sistem skor SIKASEP RISKI BILAR.',
          'Ibu hamil dikelompokkan berdasarkan tingkat risiko.',
          'Setiap kategori risiko memiliki penanda warna yang mudah dikenali.',
          'Ibu hamil mendapatkan Kartu SIKASEP RISKI BILAR.',
          'Petugas menentukan prioritas pemantauan berdasarkan kategori risiko.',
          'Intervensi terhadap faktor risiko dapat dilakukan lebih dini.',
          'Tersedia data terstruktur mengenai distribusi risiko ibu hamil.',
        ]),
        InovasiBlock.heading('C. Produk / Output'),
        InovasiBlock.bullets([
          'Kartu SIKASEP RISKI BILAR sebagai media penanda dan pemantauan risiko.',
          'Instrumen Skoring Risiko BBLR.',
          'Sistem Kategori Risiko Berbasis Warna.',
          'SOP Pelaksanaan SIKASEP RISKI BILAR.',
          'Pemetaan ibu hamil berdasarkan kategori risiko.',
          'Data monitoring dan evaluasi faktor risiko BBLR.',
        ]),
        InovasiBlock.heading('D. Kesimpulan'),
        InovasiBlock.paragraph(
          'SIKASEP RISKI BILAR mengintegrasikan skrining, skoring, kategorisasi, '
          'kartu risiko, edukasi, intervensi, pemantauan, dan evaluasi dalam satu '
          'sistem pencegahan BBLR. Inovasi ini mengubah pendekatan "mencatat '
          'faktor risiko" menjadi "mengidentifikasi risiko, memberikan penanda, '
          'melakukan intervensi, dan memantau hasilnya" — untuk menurunkan '
          'kejadian BBLR di wilayah kerja Puskesmas Tanon I Kabupaten Sragen.',
        ),
      ],
    ),
  ],
);
