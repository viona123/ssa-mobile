import 'package:flutter/material.dart';

import 'service_catalog.dart';

// ============================================================
// SEARCH DELEGATE — pencarian layanan pemerintah
// ============================================================
class LayananSearchDelegate extends SearchDelegate<ServiceItem?> {
  LayananSearchDelegate()
    : super(
        searchFieldLabel: 'Cari layanan pemerintah...',
        textInputAction: TextInputAction.search,
      );

  static const Color _primaryBlue = Color(0xFF007EA7);
  static const Color _darkText = Color(0xFF202124);
  static const Color _greyText = Color(0xFF737B86);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final base = Theme.of(context);
    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: _darkText,
        elevation: 0,
        iconTheme: IconThemeData(color: _primaryBlue),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(color: _greyText, fontSize: 15),
      ),
      textTheme: base.textTheme.copyWith(
        titleLarge: const TextStyle(color: _darkText, fontSize: 16),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          tooltip: 'Hapus',
          icon: const Icon(Icons.clear_rounded),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Kembali',
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildList(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildList(context);

  // ----------------------------------------------------------
  // DAFTAR HASIL / SARAN
  // ----------------------------------------------------------
  Widget _buildList(BuildContext context) {
    if (query.trim().isEmpty) {
      return _buildEmptyState(
        icon: Icons.search_rounded,
        title: 'Cari layanan',
        message:
            'Ketik nama layanan atau instansi, misalnya "pajak", "MPP", '
            'atau "kesehatan".',
      );
    }

    final results = ServiceCatalog.search(query);

    if (results.isEmpty) {
      return _buildEmptyState(
        icon: Icons.search_off_rounded,
        title: 'Layanan tidak ditemukan',
        message: 'Tidak ada layanan yang cocok dengan "$query".',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: results.length,
      separatorBuilder: (_, __) =>
          const Divider(height: 1, color: Color(0xFFEEF1F5)),
      itemBuilder: (context, index) {
        final service = results[index];
        return ListTile(
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: service.iconBackground.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(service.icon, size: 20, color: service.iconBackground),
          ),
          title: Text(
            service.title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _darkText,
            ),
          ),
          subtitle: Text(
            service.subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: _greyText),
          ),
          trailing: const Icon(
            Icons.chevron_right_rounded,
            color: _primaryBlue,
          ),
          onTap: () {
            // Tutup search lalu buka layanan dari konteks halaman induk.
            final navigator = Navigator.of(context);
            close(context, service);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (navigator.mounted) {
                ServiceCatalog.openService(navigator.context, service);
              }
            });
          },
        );
      },
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 54, color: _greyText.withValues(alpha: 0.6)),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _darkText,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: _greyText,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
