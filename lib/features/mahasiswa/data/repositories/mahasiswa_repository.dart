import 'package:aplikasimobile/features/mahasiswa/data/models/mahasiswa_model.dart';

class MahasiswaRepository {
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    // Simulasi loading 1 detik
    await Future.delayed(const Duration(seconds: 1));

    return [
      MahasiswaModel(
        nama: 'Budi Santoso',
        nim: '21041110001',
        programStudi: 'D4 Teknik Informatika',
        angkatan: 2021,
        ipk: 3.85,
        status: 'Aktif',
      ),
      MahasiswaModel(
        nama: 'Siti Aminah',
        nim: '21041110002',
        programStudi: 'D4 Teknik Informatika',
        angkatan: 2021,
        ipk: 3.92,
        status: 'Aktif',
      ),
      MahasiswaModel(
        nama: 'Andi Wijaya',
        nim: '20041110003',
        programStudi: 'D4 Teknik Informatika',
        angkatan: 2020,
        ipk: 3.45,
        status: 'Cuti',
      ),
      MahasiswaModel(
        nama: 'Diana Putri',
        nim: '22041110004',
        programStudi: 'D4 Teknik Informatika',
        angkatan: 2022,
        ipk: 3.78,
        status: 'Aktif',
      ),
    ];
  }
}