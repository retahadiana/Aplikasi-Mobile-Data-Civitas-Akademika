class MahasiswaModel {
  final String nama;
  final String nim;
  final String programStudi;
  final int angkatan;
  final double ipk;
  final String status; // 'Aktif' atau 'Cuti'

  MahasiswaModel({
    required this.nama,
    required this.nim,
    required this.programStudi,
    required this.angkatan,
    required this.ipk,
    required this.status,
  });

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaModel(
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      programStudi: json['programStudi'] ?? '',
      angkatan: json['angkatan'] ?? 0,
      ipk: (json['ipk'] ?? 0.0).toDouble(),
      status: json['status'] ?? 'Aktif',
    );
  }
}