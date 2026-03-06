import 'package:aplikasimobile/features/profile/data/models/profile_model.dart';

class ProfileRepository {
  Future<ProfileModel> getUserProfile() async {
    // Simulasi loading
    await Future.delayed(const Duration(milliseconds: 800));

    // Data dummy profil
    return ProfileModel(
      nama: 'Reta',
      nim: '21041110005',
      email: 'reta@mahasiswa.d4ti.ac.id',
      programStudi: 'D4 Teknik Informatika',
      noHp: '+62 812-3456-7890',
    );
  }
}