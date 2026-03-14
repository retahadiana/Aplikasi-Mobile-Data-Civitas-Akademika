import 'dart:convert';

import 'package:aplikasimobile/features/dosen/data/models/dosen_model.dart';
import 'package:http/http.dart' as http;

class DosenRepository {
  /// Mendapatkan daftar dosen
  Future<List<DosenModel>> getDosenList() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
      headers: const {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .map((json) => DosenModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Gagal memuat data dosen: ${response.statusCode}');
    }
  }
}