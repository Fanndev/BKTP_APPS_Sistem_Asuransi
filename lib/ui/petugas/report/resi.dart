import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReceiptPage extends StatelessWidget {
  final Map<String, dynamic> receiptDetails;

  ReceiptPage({required this.receiptDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Detail Resi', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.green,
                    child: Icon(Icons.receipt, size: 40, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Status Transfer',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Status transaksi Anda BERHASIL',
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text('IDR ${receiptDetails['amount']}',
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Divider(),
            Text('Rincian Transfer',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('RRN', style: TextStyle(fontWeight: FontWeight.w600)),
                Text('00007864'),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Waktu', style: TextStyle(fontWeight: FontWeight.w600)),
                Text(receiptDetails['date']),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dari Rekening',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text('014********273 - BISMI ABIANSYAH'),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bank Tujuan',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text('BNI'),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Jumlah Transfer',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text('IDR ${receiptDetails['amount']}'),
              ],
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {},
              child: Text('Selesai'),
            ),
          ],
        ),
      ),
    );
  }
}
