import 'package:flutter/material.dart';
import 'package:aplikasimobile/features/mahasiswa/data/models/mahasiswa_model.dart';

class ModernMahasiswaCard extends StatelessWidget {
  final MahasiswaModel mahasiswa;
  final VoidCallback? onTap;

  const ModernMahasiswaCard({
    super.key,
    required this.mahasiswa,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isEvenId = mahasiswa.id % 2 == 0;
    final Color primaryColor = isEvenId ? const Color(0xFF4facfe) : Colors.orange[400]!;
    final Color secondaryColor = isEvenId ? const Color(0xFF00f2fe) : Colors.orange[300]!;

    // SAFEGUARD 1: Ambil huruf pertama dengan super aman agar tidak crash
    String inisial = 'M';
    if (mahasiswa.name.trim().isNotEmpty) {
      inisial = mahasiswa.name.trim().substring(0, 1).toUpperCase();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04), // SAFEGUARD 2: Gunakan withOpacity
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap ?? () {},
          borderRadius: BorderRadius.circular(16),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Aksen garis vertikal di sebelah kiri
                Container(
                  width: 6,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [primaryColor, secondaryColor],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                ),

                // Konten Utama Kartu
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Avatar Inisial dengan Gradient
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: isEvenId
                                      ? [
                                          primaryColor.withOpacity(0.2),
                                          secondaryColor.withOpacity(0.2),
                                        ]
                                      : [Colors.grey[200]!, Colors.grey[300]!],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  inisial, // Menggunakan variabel inisial yang aman
                                  style: TextStyle(
                                    color: isEvenId ? primaryColor : Colors.grey[700],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Info Utama (Name & ID)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mahasiswa.name.isNotEmpty ? mahasiswa.name : 'Tanpa Nama',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.3,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'ID: ${mahasiswa.id} • Post: ${mahasiswa.postId}',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Badge Status
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: isEvenId
                                    ? primaryColor.withOpacity(0.1)
                                    : Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isEvenId
                                      ? primaryColor.withOpacity(0.2)
                                      : Colors.orange.withOpacity(0.2),
                                ),
                              ),
                              child: Text(
                                isEvenId ? 'Aktif' : 'Review',
                                style: TextStyle(
                                  color: isEvenId ? primaryColor : Colors.orange[700],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
                        ),

                        // Info Tambahan (Email & Body)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(Icons.email_outlined, size: 16, color: Colors.grey[400]),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      mahasiswa.email.isNotEmpty ? mahasiswa.email : '-',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star_rounded, size: 16, color: Color(0xFFFFB300)),
                                const SizedBox(width: 4),
                                Text(
                                  '#${mahasiswa.id}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.comment_outlined, size: 16, color: Colors.grey[400]),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                // SAFEGUARD 3: Hapus "Enter" (\n) dari API agar layout text tidak rusak
                                mahasiswa.body.replaceAll('\n', ' '), 
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}