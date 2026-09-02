import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'geospasial/geospasial_screen.dart';
import 'inovasi/inovasi_screen.dart';
import 'kegawatdaruratan/kegawatdaruratan_screen.dart';
import 'poli_rsud/poli_rsud_screen.dart';
import 'puskesmas/puskesmas_screen.dart';
import 'ketenagakerjaan/ketenagakerjaan_screen.dart';
import 'sewa_gedung/sewa_gedung_screen.dart';
import 'kemiskinan/kemiskinan_screen.dart';
import 'keuangan/keuangan_screen.dart';
import 'perdagangan/perdagangan_screen.dart';
import 'pajak/pajak_screen.dart';
import 'bus_sekolah/bus_sekolah_screen.dart';
import 'pariwisata/pariwisata_screen.dart';
import 'pengaduan/pengaduan_screen.dart';
import 'pendidikan/pendidikan_screen.dart';
import 'layanan_mpp/layanan_mpp_screen.dart';

// ============================================================
// MODEL CLASSES
// ============================================================
class ServiceCategory {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final List<ServiceItem> services;

  const ServiceCategory({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.services,
  });
}

class ServiceItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBackground;
  final String url;

  const ServiceItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBackground,
    required this.url,
  });
}

// ============================================================
// SERVICE CATALOG — sumber tunggal data & navigasi layanan
// ============================================================
class ServiceCatalog {
  const ServiceCatalog._();

  // ----------------------------------------------------------
  // DATA KATEGORI
  // ----------------------------------------------------------
  static const List<ServiceCategory> categories = [
    ServiceCategory(
      title: 'DPMPTSP Kabupaten Sragen',
      subtitle: 'Portal utama, perizinan, pengaduan, SKM...',
      icon: Icons.account_balance_outlined,
      iconColor: Color(0xFF315579),
      iconBackground: Color(0xFFE8F0F7),
      services: [
        ServiceItem(
          title: 'Website DPMPTSP',
          subtitle: 'DPMPTSP Kabupaten Sragen',
          icon: Icons.language_outlined,
          iconBackground: Color(0xFF315579),
          url: 'https://dpmptsp.sragenkab.go.id/portal/',
        ),
        ServiceItem(
          title: 'SIPONER',
          subtitle: 'Sistem Perizinan Online Sragen',
          icon: Icons.gavel_outlined,
          iconBackground: Color(0xFF1779B8),
          url: 'https://sipioner.sragenkab.go.id/index',
        ),
        ServiceItem(
          title: 'SKM Online',
          subtitle: 'Survei Kepuasan Masyarakat',
          icon: Icons.rate_review_outlined,
          iconBackground: Color(0xFF2E9E6B),
          url: 'https://dpmptsp.sragenkab.go.id/skm',
        ),
        ServiceItem(
          title: 'SIAP',
          subtitle: 'Sistem Informasi Administrasi Perizinan',
          icon: Icons.assignment_outlined,
          iconBackground: Color(0xFFA26B16),
          url: 'https://dpmptsp.sragenkab.go.id/pengaduan',
        ),
        ServiceItem(
          title: 'SIPELANGI',
          subtitle: 'Sistem Pelayanan Langsung Jadi',
          icon: Icons.flash_on_outlined,
          iconBackground: Color(0xFF7B2D8B),
          url: 'https://sipelangi.sragenkab.go.id/',
        ),
        ServiceItem(
          title: 'PASTIOL',
          subtitle: 'Pelayanan Administrasi Satu Pintu Online',
          icon: Icons.verified_outlined,
          iconBackground: Color(0xFF278CA9),
          url: 'https://pastiol.sragenkab.go.id/beranda',
        ),
      ],
    ),
    ServiceCategory(
      title: 'Mal Pelayanan Publik',
      subtitle: 'Website MPP dan antrean online',
      icon: Icons.business_outlined,
      iconColor: Color(0xFF315579),
      iconBackground: Color(0xFFE8F0F7),
      services: [
        ServiceItem(
          title: 'Layanan MPP',
          subtitle: 'Mal Pelayanan Publik Sragen',
          icon: Icons.apartment_rounded,
          iconBackground: Color(0xFF315579),
          url: '',
        ),
        ServiceItem(
          title: 'Website MPP',
          subtitle: 'Mal Pelayanan Publik Sragen',
          icon: Icons.web_outlined,
          iconBackground: Color(0xFF315579),
          url: 'https://mpp.sragenkab.go.id/web/',
        ),
        ServiceItem(
          title: 'Antrean Online',
          subtitle: 'Ambil nomor antrean online',
          icon: Icons.event_available_outlined,
          iconBackground: Color(0xFF1779B8),
          url: 'https://mpp.sragenkab.go.id/antrian/',
        ),
      ],
    ),
    ServiceCategory(
      title: 'Kesehatan & Keselamatan',
      subtitle: 'Layanan darurat medis dan informasi kes...',
      icon: Icons.local_hospital_outlined,
      iconColor: Color(0xFFD92D2D),
      iconBackground: Color(0xFFFDE8E8),
      services: [
        ServiceItem(
          title: 'Kegawatdaruratan',
          subtitle: 'Layanan Darurat Kabupaten Sragen',
          icon: Icons.emergency_outlined,
          iconBackground: Color(0xFFD92D2D),
          url: '',
        ),
        ServiceItem(
          title: 'Layanan Poli RSUD',
          subtitle: 'RSUD Kabupaten Sragen',
          icon: Icons.medical_services_outlined,
          iconBackground: Color(0xFF2E9E6B),
          url: '',
        ),
        ServiceItem(
          title: 'Layanan Puskesmas',
          subtitle: 'Dinas Kesehatan Kabupaten Sragen',
          icon: Icons.add_box_outlined,
          iconBackground: Color(0xFF1B8A5A),
          url: '',
        ),
      ],
    ),
    ServiceCategory(
      title: 'Kependudukan & Sosial',
      subtitle: 'Layanan administrasi kependudukan dan ...',
      icon: Icons.people_outlined,
      iconColor: Color(0xFFA26B16),
      iconBackground: Color(0xFFFFF3E0),
      services: [
        ServiceItem(
          title: 'Layanan Kependudukan',
          subtitle: 'Disdukcapil Kabupaten Sragen',
          icon: Icons.badge_outlined,
          iconBackground: Color(0xFFA26B16),
          url: 'https://pandu-online.sragenkab.go.id/signin.html',
        ),
        ServiceItem(
          title: 'Data Kemiskinan',
          subtitle: 'Dinas Sosial Kabupaten Sragen',
          icon: Icons.insert_chart_outlined,
          iconBackground: Color(0xFF315579),
          url: '',
        ),
      ],
    ),
    ServiceCategory(
      title: 'Ekonomi, Keuangan & Pajak',
      subtitle: 'Pajak daerah, harga pasar, dan keuangan',
      icon: Icons.account_balance_wallet_outlined,
      iconColor: Color(0xFF2E9E6B),
      iconBackground: Color(0xFFE6F7EF),
      services: [
        ServiceItem(
          title: 'Keuangan',
          subtitle: 'BPKAD Kabupaten Sragen',
          icon: Icons.payments_outlined,
          iconBackground: Color(0xFF2E9E6B),
          url: '',
        ),
        ServiceItem(
          title: 'Perdagangan',
          subtitle: 'Dinas Perdagangan Kabupaten Sragen',
          icon: Icons.storefront_outlined,
          iconBackground: Color(0xFFA26B16),
          url: '',
        ),
        ServiceItem(
          title: 'Pajak',
          subtitle: 'Bapenda Kabupaten Sragen',
          icon: Icons.receipt_long_outlined,
          iconBackground: Color(0xFF315579),
          url: '',
        ),
      ],
    ),
    ServiceCategory(
      title: 'Pendidikan & Transportasi',
      subtitle: 'Layanan operasional bus sekolah dan pen...',
      icon: Icons.school_outlined,
      iconColor: Color(0xFF1779B8),
      iconBackground: Color(0xFFE3F2FD),
      services: [
        ServiceItem(
          title: 'Bus Sekolah',
          subtitle: 'Dinas Perhubungan Kabupaten Sragen',
          icon: Icons.directions_bus_outlined,
          iconBackground: Color(0xFF1779B8),
          url: '',
        ),
        ServiceItem(
          title: 'Pendidikan',
          subtitle: 'Dinas Pendidikan Kabupaten Sragen',
          icon: Icons.school_outlined,
          iconBackground: Color(0xFF1779B8),
          url: '',
        ),
      ],
    ),
    ServiceCategory(
      title: 'Pariwisata & Budaya',
      subtitle: 'Destinasi wisata, agenda budaya, dan eko...',
      icon: Icons.explore_outlined,
      iconColor: Color(0xFF7B2D8B),
      iconBackground: Color(0xFFF3E5F5),
      services: [
        ServiceItem(
          title: 'Pariwisata',
          subtitle: 'Disporapar Kabupaten Sragen',
          icon: Icons.terrain_outlined,
          iconBackground: Color(0xFF7B2D8B),
          url: '',
        ),
      ],
    ),
    ServiceCategory(
      title: 'Tata Kelola & Inovasi',
      subtitle: 'Inovasi daerah, portal geospatial, dan kan...',
      icon: Icons.hub_outlined,
      iconColor: Color(0xFFA26B16),
      iconBackground: Color(0xFFFFF8E1),
      services: [
        ServiceItem(
          title: 'Inovasi',
          subtitle: 'Bapperida Kabupaten Sragen',
          icon: Icons.lightbulb_outline,
          iconBackground: Color(0xFFA26B16),
          url: '',
        ),
        ServiceItem(
          title: 'Pengaduan',
          subtitle: 'Pemerintah Kabupaten Sragen',
          icon: Icons.campaign_outlined,
          iconBackground: Color(0xFFD92D2D),
          url: '',
        ),
        ServiceItem(
          title: 'Geospasial',
          subtitle: 'Diskominfo Kabupaten Sragen',
          icon: Icons.map_outlined,
          iconBackground: Color(0xFF2E9E6B),
          url: '',
        ),
        ServiceItem(
          title: 'Sewa Gedung / Area Terbuka',
          subtitle: 'Disperkimtaru Kabupaten Sragen',
          icon: Icons.meeting_room_outlined,
          iconBackground: Color(0xFF0E4C7A),
          url: '',
        ),
        ServiceItem(
          title: 'Layanan Ketenagakerjaan',
          subtitle: 'Disnaker Kabupaten Sragen',
          icon: Icons.work_outline,
          iconBackground: Color(0xFF007EA7),
          url: '',
        ),
      ],
    ),
  ];

  // ----------------------------------------------------------
  // SEMUA LAYANAN — daftar datar dari seluruh kategori
  // ----------------------------------------------------------
  static List<ServiceItem> get allServices => categories
      .expand((category) => category.services)
      .toList(growable: false);

  // ----------------------------------------------------------
  // PENCARIAN — filter berdasarkan judul & subtitle layanan
  // ----------------------------------------------------------
  static List<ServiceItem> search(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return const [];

    return allServices.where((service) {
      return service.title.toLowerCase().contains(q) ||
          service.subtitle.toLowerCase().contains(q);
    }).toList(growable: false);
  }

  // ----------------------------------------------------------
  // NAVIGASI — buka layanan (halaman internal / URL / snackbar)
  // ----------------------------------------------------------
  static void openService(
    BuildContext context,
    ServiceItem service, {
    bool fromSheet = false,
    @Deprecated('Gunakan fromSheet') bool popFirst = false,
  }) {
    final bool openedFromSheet = fromSheet || popFirst;

    // Saat dibuka dari bottom sheet "Semua Layanan", gunakan root navigator
    // supaya halaman layanan dibuka DI ATAS sheet (sheet tetap ada di bawah).
    // Dengan begitu, menekan tombol kembali dari halaman layanan akan
    // memunculkan kembali sheet "Semua Layanan", bukan langsung ke Beranda.
    final navigator = Navigator.of(context, rootNavigator: openedFromSheet);
    final messenger = ScaffoldMessenger.of(context);

    // Layanan dengan halaman internal khusus.
    final Widget? screen = internalScreenFor(service.title);
    if (screen != null) {
      navigator.push(MaterialPageRoute(builder: (_) => screen));
      return;
    }

    if (service.url.isNotEmpty) {
      _openExternalUrl(Uri.parse(service.url), messenger);
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: Text('Layanan ${service.title} akan segera hadir.'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  /// Mengembalikan halaman internal untuk sebuah layanan, atau null bila
  /// layanan tersebut dibuka via URL / belum tersedia.
  static Widget? internalScreenFor(String title) {
    switch (title) {
      case 'Geospasial':
        return const GeospasialScreen();
      case 'Inovasi':
        return const InovasiScreen();
      case 'Kegawatdaruratan':
        return const KegawatdaruratanScreen();
      case 'Layanan Poli RSUD':
        return const PoliRsudScreen();
      case 'Layanan Puskesmas':
        return const PuskesmasScreen();
      case 'Layanan Ketenagakerjaan':
        return const KetenagakerjaanScreen();
      case 'Sewa Gedung / Area Terbuka':
        return const SewaGedungScreen();
      case 'Data Kemiskinan':
        return const KemiskinanScreen();
      case 'Keuangan':
        return const KeuanganScreen();
      case 'Perdagangan':
        return const PerdaganganScreen();
      case 'Pajak':
        return const PajakScreen();
      case 'Bus Sekolah':
        return const BusSekolahScreen();
      case 'Pariwisata':
        return const PariwisataScreen();
      case 'Pengaduan':
        return const PengaduanScreen();
      case 'Pendidikan':
        return const PendidikanScreen();
      case 'Layanan MPP':
        return const LayananMppScreen();
      default:
        return null;
    }
  }

  // ----------------------------------------------------------
  // OPEN EXTERNAL URL
  // ----------------------------------------------------------
  static Future<void> _openExternalUrl(
    Uri uri,
    ScaffoldMessengerState messenger,
  ) async {
    final bool launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched && messenger.mounted) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Tidak dapat membuka tautan layanan.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
