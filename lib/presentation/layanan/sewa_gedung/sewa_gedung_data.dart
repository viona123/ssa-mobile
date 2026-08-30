import 'package:flutter/material.dart';

// ================================================================
// DATA SEWA GEDUNG / AREA TERBUKA — Disperkimtaru Kab. Sragen
// ================================================================

class Gedung {
  final String nama;
  final String alamat;
  final String kapasitas;
  final String luas;
  final String tarif;
  final String deskripsi;
  final List<String> fasilitas;
  final bool tersedia;
  final String pengelola;
  final String telepon;

  /// Path aset foto dokumentasi (opsional). Bila kosong, carousel
  /// menampilkan slide placeholder bergradien yang tetap bisa digeser.
  final List<String> foto;

  const Gedung({
    required this.nama,
    required this.alamat,
    required this.kapasitas,
    required this.luas,
    required this.tarif,
    required this.deskripsi,
    required this.fasilitas,
    this.tersedia = true,
    this.pengelola = 'Disperkimtaru Sragen',
    this.telepon = '0821 3848 9984',
    this.foto = const [],
  });
}

const List<Gedung> kGedungList = [
  Gedung(
    nama: 'Alun Alun Sasono Langen Putro',
    alamat:
        'Jl. Sukowati No.2, Mageru, Sragen Tengah, Kec. Sragen, Kabupaten '
        'Sragen, Jawa Tengah 57211',
    kapasitas: '10.000 orang',
    luas: '2.745 m²',
    tarif: 'Rp 2.500.000',
    deskripsi:
        'Alun-Alun Sasono Langen Putro Kabupaten Sragen adalah ruang terbuka '
        'Kabupaten Sragen yang menjadi ikon Bumi Sukowati sekaligus titik nol '
        'Kota Sragen. Sebagai salah satu ruang publik utama, alun-alun ini '
        'menjadi pusat berbagai kegiatan masyarakat, seperti destinasi wisata '
        'keluarga, tempat berkumpul warga, sarana rekreasi, olahraga jogging, '
        'panggung terbuka pertunjukan seni budaya, bazar UMKM, upacara hari '
        'besar, hingga tempat pelaksanaan ibadah hari raya seperti Salat Idul '
        'Adha dan Idul Fitri.',
    fasilitas: ['Area parkir', 'Kamar mandi', 'Mushola'],
    pengelola: 'Mbak Enik',
    telepon: '0895401234586',
  ),
  Gedung(
    nama: 'Gedung Kartini',
    alamat: 'Jl. Raya Sukowati No. 160 Sine, Sragen Kulon, Sragen',
    kapasitas: '600 orang',
    luas: '432 m²',
    tarif: 'Rp 4.000.000',
    deskripsi:
        'Koordinator gedung: Kasiman (082340750580). Kapasitas 600 kursi '
        '(untuk di dalam gedung saja).',
    fasilitas: ['Kamar Mandi', 'Ruang Catering', 'Ruang Transit/MUA', 'Panggung'],
    pengelola: 'Kasiman',
    telepon: '082340750580',
  ),
  Gedung(
    nama: 'Gedung Sasana Manggala Sukowati (SMS)',
    alamat:
        'Jl. Dr. Sutomo, Sine, Sragen Kulon, Kec. Sragen, Kabupaten Sragen, '
        'Jawa Tengah 57213',
    kapasitas: '2.000 orang',
    luas: '123 m²',
    tarif: 'Rp 10.000.000',
    deskripsi: 'Hanya gedung saja.',
    fasilitas: ['AC Sentral', 'Toilet', 'Panggung'],
  ),
  Gedung(
    nama: 'Gedung SBS (Sasana Budaya Sukowati)',
    alamat: 'Jalan Rokan, Mageru, Sragen Tengah, Sragen',
    kapasitas: '200 orang',
    luas: '674 m²',
    tarif: 'Rp 2.000.000',
    deskripsi:
        'Koordinator Gedung: Tugino (085950125762). Harga sewa untuk acara '
        'umum (resepsi, pesta, promosi, pameran) menyesuaikan ketentuan.',
    fasilitas: ['Kamar Mandi', 'Panggung', 'Ruang Transit'],
    pengelola: 'Tugino',
    telepon: '085950125762',
  ),
  Gedung(
    nama: 'Taman Edupark Gemolong',
    alamat:
        'Dusun 2, Gemolong, Kecamatan Gemolong, Kabupaten Sragen, Jawa '
        'Tengah, 57274',
    kapasitas: '800 orang',
    luas: '18.279 m²',
    tarif: 'Rp 1.500.000',
    deskripsi:
        'Taman Edupark Gemolong merupakan ruang terbuka hijau berkonsep '
        'edukatif yang terletak di Dusun 2, Gemolong.',
    fasilitas: [
      'Panggung',
      'Area parkir',
      'Kamar mandi',
      'Permainan anak-anak',
      'Ruang terbuka hijau',
    ],
  ),
  Gedung(
    nama: 'Taman Kridoanggo Sragen',
    alamat:
        'Jalan Sukowati No.488, Dusun Kebayanan, Krajoyok, Sragen Wetan, '
        'Kecamatan Sragen, Kabupaten Sragen, Jawa Tengah 57211',
    kapasitas: '500 orang',
    luas: '5.440 m²',
    tarif: 'Rp 1.500.000',
    deskripsi:
        'Taman Kridoanggo merupakan salah satu ruang publik hijau di Jalan '
        'Sukowati No.488, Dusun Kebayanan, Sragen Wetan.',
    fasilitas: ['Panggung', 'Area parkir', 'Kamar mandi', 'Area Bermain Anak'],
  ),
  Gedung(
    nama: 'Taman Sukowati Sragen',
    alamat: 'Sine, Kecamatan Sragen, Kabupaten Sragen, Jawa Tengah 57213',
    kapasitas: '1.500 orang',
    luas: '65.628 m²',
    tarif: 'Rp 1.500.000',
    deskripsi:
        'Taman Sukowati Sragen merupakan salah satu ruang terbuka hijau milik '
        'Disperkimtaru Kabupaten Sragen.',
    fasilitas: [
      'Embung',
      'Area parkir',
      'Kamar mandi',
      'Permainan anak-anak',
      'Ruang terbuka hijau',
    ],
  ),
];

// ---- Agenda kegiatan ----
class AgendaGedung {
  final String tanggal; // e.g. "30 Agu"
  final String judul;
  final String lokasi;
  final AgendaStatus status;

  const AgendaGedung({
    required this.tanggal,
    required this.judul,
    required this.lokasi,
    required this.status,
  });
}

enum AgendaStatus { terkonfirmasi, menunggu, dibatalkan }

const List<AgendaGedung> kAgendaList = [
  AgendaGedung(
    tanggal: '30 Agu',
    judul: 'Bazar UMKM di Halaman dalam rangka Lomba Layang Layang',
    lokasi: 'Gedung Sasana Manggala Sukowati (SMS)',
    status: AgendaStatus.terkonfirmasi,
  ),
  AgendaGedung(
    tanggal: '30 Agu',
    judul: 'Ekstrakurikuler Fair Tahun 2026',
    lokasi: 'Taman Kridoanggo Sragen',
    status: AgendaStatus.terkonfirmasi,
  ),
  AgendaGedung(
    tanggal: '30 Agu',
    judul: 'Pernikahan',
    lokasi: 'Gedung Sasana Manggala Sukowati (SMS)',
    status: AgendaStatus.menunggu,
  ),
  AgendaGedung(
    tanggal: '30 Agu',
    judul: 'Pernikahan',
    lokasi: 'Gedung Kartini',
    status: AgendaStatus.terkonfirmasi,
  ),
];

// ---- Prosedur penyewaan ----
class ProsedurStep {
  final String judul;
  final String deskripsi;
  const ProsedurStep(this.judul, this.deskripsi);
}

const List<ProsedurStep> kProsedurList = [
  ProsedurStep(
    'Pemeriksaan Ketersediaan Jadwal',
    'Pemohon memeriksa ketersediaan jadwal gedung atau area terbuka melalui '
        'SIGAP SRAGEN untuk memastikan tanggal yang diinginkan masih tersedia.',
  ),
  ProsedurStep(
    'Pengajuan Surat Permohonan',
    'Pemohon mengajukan Surat Permohonan Izin Penggunaan Tempat kepada Kepala '
        'Disperkimtaru Sragen dan menyerahkannya langsung ke kantor '
        'Disperkimtaru Sragen.',
  ),
  ProsedurStep(
    'Verifikasi dan Persetujuan',
    'Disperkimtaru memverifikasi permohonan, dan jika layak akan menerbitkan '
        'Surat Persetujuan Penggunaan Gedung/Area Terbuka Publik.',
  ),
  ProsedurStep(
    'Pembayaran Biaya Sewa',
    'Setelah disetujui, pemohon membayar biaya sewa sesuai ketentuan dan '
        'menyerahkan bukti pembayaran kepada petugas.',
  ),
  ProsedurStep(
    'Serah Terima dan Penggunaan Fasilitas',
    'Setelah administrasi selesai, dilakukan serah terima fasilitas; pemohon '
        'berhak menggunakannya sesuai ketentuan dan wajib menjaga ketertiban. '
        'Setelah selesai, tempat harus dikembalikan dalam kondisi bersih dan baik.',
  ),
];

// ---- Kontak ----
class KontakSewa {
  final IconData icon;
  final String kategori;
  final String nomor;
  const KontakSewa(this.icon, this.kategori, this.nomor);
}

const List<KontakSewa> kKontakList = [
  KontakSewa(Icons.domain_rounded, 'Gedung', '0821 3848 9984 (Bu Win)'),
  KontakSewa(Icons.park_rounded, 'Area Terbuka', '0895 4012 34586 (Enik)'),
];
