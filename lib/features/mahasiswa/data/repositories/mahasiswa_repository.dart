import 'package:aplikasimobile/core/network/dio_client.dart';
import 'package:aplikasimobile/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:dio/dio.dart';

class MahasiswaRepository {
  final DioClient _dioClient;

  MahasiswaRepository({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  Future<List<MahasiswaModel>> getMahasiswaList() async {
    try {
      // Menggunakan endpoint /comments sesuai Modul 5
      final Response response = await _dioClient.dio.get(
        '/comments',
        queryParameters: {'_limit': 30},
      );
      final List<dynamic> data = response.data;
      return data.map((json) => MahasiswaModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Gagal memuat data mahasiswa: ${e.response?.statusCode} - ${e.message}');
    }
  }
}