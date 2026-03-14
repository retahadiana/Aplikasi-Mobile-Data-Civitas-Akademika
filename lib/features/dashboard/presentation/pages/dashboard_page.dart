import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aplikasimobile/core/constants/constants.dart';
import 'package:aplikasimobile/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:aplikasimobile/features/dashboard/presentation/widgets/dashboard_widget.dart';
import 'package:aplikasimobile/features/mahasiswa/presentation/pages/mahasiswa_page.dart';
import 'package:aplikasimobile/features/mahasiswa_aktif/presentation/pages/mahasiswa_aktif_page.dart';
import 'package:aplikasimobile/features/dosen/presentation/pages/dosen_page.dart';
import 'package:aplikasimobile/features/profile/presentation/pages/profile_page.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  // get icon
  IconData _getIconForStat(String title) {
    switch (title) {
      case 'Total Mahasiswa':
        return Icons.school_rounded;
      case 'Mahasiswa Aktif':
        return Icons.person_outline_rounded;
      case 'Mahasiswa Lulus':
      case 'Profile': // Menyesuaikan dengan data dummy
        return Icons.workspace_premium_rounded;
      case 'Dosen':
        return Icons.people_outline_rounded;
      default:
        return Icons.analytics_outlined;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: dashboardState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ), // Disederhanakan untuk menghindari error CustomWidget
        error: (error, stack) =>
            Center(child: Text('Gagal memuat data: ${error.toString()}')),
        data: (dashboardData) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(dashboardNotifierProvider);
            },
            child: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.primaryColor,
                        theme.primaryColor.withBlue(220),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: theme.primaryColor.withValues(alpha: 0.28),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Selamat datang',
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.9),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      dashboardData.userName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.35),
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.notifications_none_rounded,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.16),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.24),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.schedule_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Update: ${_formatDate(dashboardData.lastUpdate)}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Statistik',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF202734),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          ref.invalidate(dashboardNotifierProvider);
                        },
                        icon: const Icon(Icons.refresh_rounded, size: 18),
                        label: const Text('Refresh'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth > 650 ? 3 : 2;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 1.05,
                        ),
                        itemCount: dashboardData.stats.length,
                        itemBuilder: (context, index) {
                          final stat = dashboardData.stats[index];
                          return ModernStatCard(
                            stats: stat,
                            icon: _getIconForStat(stat.title),
                            gradientColors: AppConstants.dashboardGradients[
                                index % AppConstants.dashboardGradients.length],
                            onTap: () {
                              ref
                                  .read(selectedStatIndexProvider.notifier)
                                  .state = index;

                              final statTitle = stat.title;
                              Widget? targetPage;

                              switch (statTitle) {
                                case 'Total Mahasiswa':
                                  targetPage = const MahasiswaPage();
                                  break;
                                case 'Mahasiswa Aktif':
                                  targetPage = const MahasiswaAktifPage();
                                  break;
                                case 'Dosen':
                                  targetPage = const DosenPage();
                                  break;
                                case 'Profile':
                                  targetPage = const ProfilePage();
                                  break;
                              }

                              if (targetPage != null) {
                                Navigator.push(context, _createRoute(targetPage));
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Animasi transisi waktu pindah page
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  // Format tanggal update
  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Ags',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}, ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
