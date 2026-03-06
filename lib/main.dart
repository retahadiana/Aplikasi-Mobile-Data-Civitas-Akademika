import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// PENTING: Sesuaikan 'd4tivokasi' dengan nama project kamu yang ada di pubspec.yaml
import 'package:aplikasimobile/core/constants/constants.dart';
import 'package:aplikasimobile/features/dashboard/presentation/pages/dashboard_page.dart';

void main() {
  // ProviderScope wajib ada agar semua Provider Riverpod di dalam aplikasi bisa berjalan
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      // Menghilangkan pita tulisan "DEBUG" di pojok kanan atas layar
      debugShowCheckedModeBanner: false,

      // Pengaturan tema global aplikasi agar terlihat modern dan rapi
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[700],
        scaffoldBackgroundColor: Colors.grey[50], // Latar belakang abu-abu sangat terang
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
        ),
      ),

      // Halaman pertama yang akan dimuat saat aplikasi dibuka
      home: const DashboardPage(),
    );
  }
}