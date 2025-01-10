// report.dart
import 'package:flutter/material.dart';
import 'logic.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  // State variables
  List<Report> reports = [];
  bool isLoading = false;
  bool isNewestFirst = true;

  // Controllers
  final _titleController = TextEditingController();
  final _loanAmountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedInsuranceType = 'Asuransi Jiwa';

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _loanAmountController.dispose();
    super.dispose();
  }

  // Data loading
  Future<void> _loadReports() async {
    try {
      setState(() {
        isLoading = true;
      });

      final fetchedReports = await fetchReports();

      setState(() {
        reports = fetchedReports;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil laporan: $error')),
      );
    }
  }

  // Dialog methods
  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.sort),
                title: const Text('Terbaru'),
                onTap: () {
                  setState(() {
                    isNewestFirst = true;
                    reports.sort((a, b) => b.date.compareTo(a.date));
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.sort),
                title: const Text('Terlama'),
                onTap: () {
                  setState(() {
                    isNewestFirst = false;
                    reports.sort((a, b) => a.date.compareTo(b.date));
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddReportDialog() {
    _titleController.clear();
    _loanAmountController.clear();
    final senderNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tambah Laporan Baru'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: senderNameController,
                    decoration: const InputDecoration(
                        labelText: 'Nama Pembuat Laporan'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama pengirim tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _titleController,
                    decoration:
                        const InputDecoration(labelText: 'Judul Laporan'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Judul tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _loanAmountController,
                    decoration:
                        const InputDecoration(labelText: 'Jumlah Pinjaman'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Jumlah pinjaman tidak boleh kosong';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Masukkan angka yang valid';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedInsuranceType,
                    decoration:
                        const InputDecoration(labelText: 'Jenis Asuransi'),
                    items: [
                      'Asuransi Jiwa',
                      'Asuransi Kesehatan',
                      'Asuransi Kendaraan'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedInsuranceType = newValue;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    final newReport = Report(
                      title: _titleController.text,
                      date: DateTime.now(),
                      loanAmount: double.parse(_loanAmountController.text),
                      insuranceType: _selectedInsuranceType,
                      status: 'Pending',
                      senderName: senderNameController.text,
                    );

                    await addReport(newReport);

                    setState(() {
                      isLoading = true;
                    });

                    await _loadReports();

                    Navigator.of(context).pop();

                    // Tampilkan notifikasi sukses
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Laporan berhasil ditambahkan')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gagal menambahkan laporan: $e')),
                    );
                  }
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _showReportDetail(Report report) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Detail Laporan'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Pembuat Laporan:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(report.senderName),
                const SizedBox(height: 10),
                const Text(
                  'Judul Laporan:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(report.title),
                const SizedBox(height: 10),
                const Text(
                  'Tanggal:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(DateFormat('dd/MM/yyyy HH:mm').format(report.date)),
                const SizedBox(height: 10),
                const Text(
                  'Jumlah Pinjaman:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Rp ${NumberFormat('#,###').format(report.loanAmount)}'),
                const SizedBox(height: 10),
                const Text(
                  'Jenis Asuransi:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(report.insuranceType),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
              ),
              child: const Text('Tutup'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await updateReportStatus(report, 'Ditolak');
                  Navigator.of(context).pop();
                  _loadReports();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Laporan ditolak')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal mengubah status: $e')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Tolak'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await updateReportStatus(report, 'Disetujui');
                  Navigator.of(context).pop();
                  _loadReports();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Laporan disetujui')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal mengubah status: $e')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Setuju'),
            ),
          ],
        );
      },
    );
  }

  // Build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : reports.isEmpty
              ? const Center(child: Text('Tidak ada laporan.'))
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: reports.length,
                  itemBuilder: (context, index) {
                    final report = reports[index];
                    return Dismissible(
                      key: Key(report.title + report.date.toString()),
                      background: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.red.shade400,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerLeft,
                        child: const Icon(
                          Icons.delete_sweep_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Konfirmasi'),
                              content: const Text(
                                  'Apakah Anda yakin ingin menghapus laporan ini?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text('Batal'),
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('Hapus'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      onDismissed: (direction) async {
                        try {
                          await deleteReport(report);
                          setState(() {
                            reports.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Laporan berhasil dihapus')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Gagal menghapus laporan: $e')),
                          );
                          _loadReports();
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.green.shade50,
                              Colors.white,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => _showReportDetail(report),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.primaries[
                                        index % Colors.primaries.length],
                                    child: Text(
                                      report.senderName[0].toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                report.senderName,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey.shade800,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          report.title,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today_rounded,
                                              size: 14,
                                              color: Colors.grey.shade600,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              DateFormat('dd MMM yyyy')
                                                  .format(report.date),
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Icon(
                                              Icons.access_time_rounded,
                                              size: 14,
                                              color: Colors.grey.shade600,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              DateFormat('HH:mm')
                                                  .format(report.date),
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade100,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            'Rp ${NumberFormat('#,###').format(report.loanAmount)}',
                                            style: TextStyle(
                                              color: Colors.green.shade700,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 16,
                                    color: Colors.grey.shade400,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green.shade400, Colors.green.shade600],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        margin: const EdgeInsets.only(right: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton.small(
              heroTag: 'filter',
              onPressed: _showFilterDialog,
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: const Icon(Icons.filter_list_rounded, size: 20),
            ),
            const SizedBox(width: 8),
            FloatingActionButton.small(
              heroTag: 'add',
              onPressed: _showAddReportDialog,
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: const Icon(Icons.add_rounded, size: 20),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
