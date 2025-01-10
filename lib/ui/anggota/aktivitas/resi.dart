import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReceiptPage extends StatelessWidget {
  final Map<String, dynamic> receiptDetails;

  const ReceiptPage({super.key, required this.receiptDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Detail Resi', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Status Transfer
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.green,
                    child: Icon(Icons.receipt, size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Status Transfer',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Status transaksi Anda BERHASIL',
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text('IDR ${receiptDetails['amount']}',
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const Divider(),

            // Bagian Rincian Transfer
            const Text('Rincian Transfer',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('RRN', style: TextStyle(fontWeight: FontWeight.w600)),
                Text('00007864'),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Waktu',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text(receiptDetails['date']),
              ],
            ),
            const SizedBox(height: 5),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dari Rekening',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text('014********273 - BISMI ABIANSYAH'),
              ],
            ),
            const SizedBox(height: 5),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bank Tujuan',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text('BNI'),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Jumlah Transfer',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text('IDR ${receiptDetails['amount']}'),
              ],
            ),
            const Spacer(),

            // Tombol Selesai
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
              child: const Text('Selesai'),
            ),
          ],
        ),
      ),
    );
  }
}
