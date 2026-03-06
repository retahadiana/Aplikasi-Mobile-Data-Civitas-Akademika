import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aplikasimobile/features/profile/data/models/profile_model.dart';
import 'package:aplikasimobile/features/profile/data/repositories/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

class ProfileNotifier extends StateNotifier<AsyncValue<ProfileModel>> {
  final ProfileRepository _repository;

  ProfileNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getUserProfile();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    await loadProfile();
  }
}

final profileNotifierProvider = StateNotifierProvider.autoDispose<
    ProfileNotifier, AsyncValue<ProfileModel>>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return ProfileNotifier(repository);
});