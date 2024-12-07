// Halaman Transaksi
import 'package:flutter/material.dart';

class TransaksiTab extends StatelessWidget {
  const TransaksiTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Foto Random
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://source.unsplash.com/random/100x100/?transaction,$index",
                    ),
                    radius: 30,
                  ),
                  const SizedBox(width: 12),
                  // Informasi Transaksi
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Transaksi ${index + 1}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Tanggal: ${DateTime.now().subtract(Duration(days: index)).toString().split(' ')[0]}",
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Status: ${index % 2 == 0 ? "Berhasil" : "Pending"}",
                          style: TextStyle(
                            color:
                                index % 2 == 0 ? Colors.green : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
