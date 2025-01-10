// logic.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String title;
  final DateTime date;
  final double loanAmount;
  final String insuranceType;
  final String status;
  final String senderName;

  Report({
    required this.title,
    required this.date,
    required this.loanAmount,
    required this.insuranceType,
    required this.status,
    required this.senderName,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': Timestamp.fromDate(date),
      'loanAmount': loanAmount,
      'insuranceType': insuranceType,
      'status': status,
      'senderName': senderName,
    };
  }

  // Konversi dari Firestore ke Report
  factory Report.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Report(
      title: data['title'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      loanAmount: (data['loanAmount'] ?? 0).toDouble(),
      insuranceType: data['insuranceType'] ?? '',
      status: data['status'] ?? 'Pending',
      senderName: data['senderName'] ?? 'Unknown',
    );
  }
}

Future<List<Report>> fetchReports() async {
  try {
    print('Fetching reports from Firestore...'); // Debug print
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('reports')
        .orderBy('date', descending: true)
        .get();

    print('Fetched ${snapshot.docs.length} reports'); // Debug print
    return snapshot.docs.map((doc) => Report.fromDocument(doc)).toList();
  } catch (e) {
    print('Error fetching reports: $e'); // Debug print
    throw e;
  }
}

Future<void> addReport(Report report) async {
  try {
    print('Adding report to Firestore...'); // Debug print
    await FirebaseFirestore.instance.collection('reports').add(report.toMap());
    print('Report added successfully'); // Debug print
  } catch (e) {
    print('Error adding report: $e'); // Debug print
    throw e;
  }
}

Future<void> updateReportStatus(Report report, String newStatus) async {
  try {
    print('Updating report status...');

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('reports')
        .where('title', isEqualTo: report.title)
        .where('date', isEqualTo: Timestamp.fromDate(report.date))
        .get();

    if (snapshot.docs.isNotEmpty) {
      await snapshot.docs.first.reference.update({'status': newStatus});
      print('Report status updated successfully'); // Debug print
    } else {
      throw Exception('Report not found');
    }
  } catch (e) {
    print('Error updating report status: $e'); // Debug print
    throw e;
  }
}

Future<void> deleteReport(Report report) async {
  try {
    print('Deleting report...'); // Debug print
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('reports')
        .where('title', isEqualTo: report.title)
        .where('date', isEqualTo: Timestamp.fromDate(report.date))
        .get();

    if (snapshot.docs.isNotEmpty) {
      await snapshot.docs.first.reference.delete();
      print('Report deleted successfully'); // Debug print
    } else {
      throw Exception('Report not found');
    }
  } catch (e) {
    print('Error deleting report: $e'); // Debug print
    throw e;
  }
}
