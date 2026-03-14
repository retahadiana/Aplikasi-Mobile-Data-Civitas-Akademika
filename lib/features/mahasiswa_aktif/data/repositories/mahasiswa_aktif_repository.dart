import 'dart:convert';

import 'package:aplikasimobile/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class MahasiswaAktifRepository {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  static const Duration _cacheDuration = Duration(minutes: 5);
  static List<MahasiswaAktifModel>? _cachedMahasiswaAktif;
  static DateTime? _lastFetchAt;
  static Future<List<MahasiswaAktifModel>>? _ongoingRequest;
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 4),
      receiveTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 4),
    ),
  );

  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList({bool forceRefresh = false}) async {
    if (!forceRefresh && _hasFreshCache) {
      return _cachedMahasiswaAktif!;
    }

    final ongoingRequest = _ongoingRequest;
    if (!forceRefresh && ongoingRequest != null) {
      return ongoingRequest;
    }

    final request = _fetchMahasiswaAktifList();
    _ongoingRequest = request;

    try {
      final result = await request;
      _cachedMahasiswaAktif = result;
      _lastFetchAt = DateTime.now();
      return result;
    } finally {
      if (identical(_ongoingRequest, request)) {
        _ongoingRequest = null;
      }
    }
  }

  bool get _hasFreshCache {
    final lastFetchAt = _lastFetchAt;
    final cachedMahasiswaAktif = _cachedMahasiswaAktif;
    if (lastFetchAt == null || cachedMahasiswaAktif == null) {
      return false;
    }

    return DateTime.now().difference(lastFetchAt) < _cacheDuration;
  }

  Future<List<MahasiswaAktifModel>> _fetchMahasiswaAktifList() async {
    try {
      final response = await _dio.get<dynamic>(
        _baseUrl,
        options: Options(
          headers: const <String, String>{'Accept': 'application/json'},
        ),
      );

      if (response.statusCode == 200 && response.data is List<dynamic>) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((json) => MahasiswaAktifModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
    } on DioException {
      // Fallback ke http jika request via dio gagal.
    }

    final response = await http
        .get(
          Uri.parse(_baseUrl),
          headers: const {'Accept': 'application/json'},
        )
        .timeout(const Duration(seconds: 5));

    if (response.statusCode != 200) {
      throw Exception('Gagal memuat data mahasiswa aktif: ${response.statusCode}');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => MahasiswaAktifModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
