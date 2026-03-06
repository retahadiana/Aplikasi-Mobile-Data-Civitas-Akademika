import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../theme/app_theme.dart';

// 1. Loading Widget - Ditampilkan saat data sedang dimuat
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    ); // Center
  }
}

// 2. Error Widget - Ditampilkan saat terjadi kesalahan [cite: 351]
class CustomErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const CustomErrorWidget({
    Key? key,
    required this.message,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppTheme.errorColor,
            ), // Icon [cite: 364]
            const SizedBox(height: AppConstants.paddingMedium),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ), // Text [cite: 369]
            if (onRetry != null) ...[
              const SizedBox(height: AppConstants.paddingLarge),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ), // ElevatedButton.icon [cite: 375]
            ],
          ],
        ), // Column [cite: 376]
      ), // Padding [cite: 377]
    ); // Center [cite: 378]
  }
}

// 3. Empty Widget - Ditampilkan jika data kosong
class EmptyWidget extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyWidget({
    Key? key,
    required this.message,
    this.icon = Icons.inbox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: AppTheme.textSecondaryColor,
          ), // Icon [cite: 391]
          const SizedBox(height: AppConstants.paddingMedium),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textSecondaryColor,
            ),
          ), // Text [cite: 397]
        ],
      ), // Column
    ); // Center
  }
}

// 4. Card Widget - Komponen kartu standar untuk UI yang konsisten [cite: 400]
class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const CustomCard({
    Key? key,
    required this.child,
    this.padding,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppConstants.paddingMedium),
          child: child,
        ), // Padding [cite: 415]
      ), // InkWell [cite: 416]
    ); // Card [cite: 417]
  }
}