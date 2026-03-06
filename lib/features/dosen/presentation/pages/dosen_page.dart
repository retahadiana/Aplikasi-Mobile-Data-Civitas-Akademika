import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aplikasimobile/features/dosen/presentation/providers/dosen_provider.dart';
import 'package:aplikasimobile/features/dosen/presentation/widgets/dosen_widget.dart';

class DosenPage extends ConsumerWidget {
  const DosenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dosenState = ref.watch(dosenNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Dosen', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(dosenNotifierProvider),
          ),
        ],
      ),
      body: dosenState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: ${error.toString()}')),
        data: (dosenList) {
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(dosenNotifierProvider),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: dosenList.length,
              itemBuilder: (context, index) {
                return ModernDosenCard(dosen: dosenList[index]);
              },
            ),
          );
        },
      ),
    );
  }
}