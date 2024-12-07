import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mob3_uas_klp_05/ui/admin/product/add_product.dart';
import 'package:mob3_uas_klp_05/ui/admin/widget/ansuransi_card.dart';
import 'package:mob3_uas_klp_05/widget/background_widget.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  void _filterInsuranceData(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: TextField(
            controller: _searchController,
            onChanged: _filterInsuranceData,
            decoration: InputDecoration(
              hintText: 'Cari Produk Asuransi',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              prefixIcon: const Icon(Icons.search),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Produk Asuransi',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('insurance').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Terjadi kesalahan saat memuat data"),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text("Tidak ada produk asuransi ditemukan"),
                        );
                      }

                      final insuranceData = snapshot.data!.docs
                          .map((doc) => doc.data() as Map<String, dynamic>)
                          .toList();

                      final filteredData = _searchQuery.isEmpty
                          ? insuranceData
                          : insuranceData
                              .where((insurance) => insurance['name']
                                  .toString()
                                  .toLowerCase()
                                  .contains(_searchQuery))
                              .toList();

                      return ListView.separated(
                        itemCount: filteredData.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 15),
                        itemBuilder: (context, index) {
                          final insurance = filteredData[index];
                          return InsuranceCard(
                            name: insurance['name'] ?? 'Tidak ada nama',
                            price: insurance['price'] ?? 'Tidak ada harga',
                            description: insurance['description'] ??
                                'Tidak ada deskripsi',
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddAnsuransiPage()),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
