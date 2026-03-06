class ProfileModel {
  final String nama;
  final String nim;
  final String email;
  final String programStudi;
  final String noHp;

  ProfileModel({
    required this.nama,
    required this.nim,
    required this.email,
    required this.programStudi,
    required this.noHp,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      email: json['email'] ?? '',
      programStudi: json['programStudi'] ?? '',
      noHp: json['noHp'] ?? '',
    );
  }
}