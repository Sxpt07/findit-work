import 'dart:io';
import 'package:flutter/material.dart';
import '../models/found_item_model.dart';

Future<void> showFoundItemDetail(
    BuildContext context, {
      required FoundItemModel item,
      required VoidCallback onMarkClaimed,
    }) {
  const navy = Color(0xFF1E3A8A);
  final isClaimed = item.status == FoundItemStatus.claimed;

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      return DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: ListView(
              controller: scrollController,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                const SizedBox(height: 16),
                if (item.photoPath != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.file(File(item.photoPath!), height: 160, width: double.infinity, fit: BoxFit.cover),
                  ),
                const SizedBox(height: 14),
                Text(item.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(label: Text(item.category.label), backgroundColor: navy.withValues(alpha: 0.08)),
                    Chip(label: Text(item.color), backgroundColor: Colors.grey.shade100),
                  ],
                ),
                const SizedBox(height: 16),
                _detailRow(Icons.location_on_outlined, 'Lokasi Ditemukan', item.location),
                const SizedBox(height: 12),
                _detailRow(Icons.notes_outlined, 'Deskripsi', item.description),
                const SizedBox(height: 20),
                if (!isClaimed)
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 14)),
                      onPressed: () {
                        onMarkClaimed();
                        Navigator.pop(ctx);
                      },
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('Tandai Sudah Diambil Tamu'),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 18),
                        SizedBox(width: 8),
                        Text('Barang sudah diambil tamu', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _detailRow(IconData icon, String label, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, size: 18, color: const Color(0xFF1E3A8A)),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 11, color: Colors.black54)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    ],
  );
}