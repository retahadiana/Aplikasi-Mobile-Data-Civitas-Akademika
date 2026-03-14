import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aplikasimobile/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';
import 'package:aplikasimobile/features/mahasiswa_aktif/data/repositories/mahasiswa_aktif_repository.dart';

final mahasiswaAktifRepositoryProvider = Provider<MahasiswaAktifRepository>((ref) {
  return MahasiswaAktifRepository();
});

class MahasiswaAktifNotifier
    extends StateNotifier<AsyncValue<List<MahasiswaAktifModel>>> {
  final MahasiswaAktifRepository _repository;

  MahasiswaAktifNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadMahasiswaAktif();
  }

  Future<void> loadMahasiswaAktif() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getMahasiswaAktifList();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getMahasiswaAktifList(forceRefresh: true);
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final mahasiswaAktifNotifierProvider = StateNotifierProvider<
    MahasiswaAktifNotifier, AsyncValue<List<MahasiswaAktifModel>>>((ref) {
  final repository = ref.watch(mahasiswaAktifRepositoryProvider);
  return MahasiswaAktifNotifier(repository);
});