import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryReportScreen extends StatefulWidget {
  const InventoryReportScreen({super.key});

  @override
  State<InventoryReportScreen> createState() => _InventoryReportScreenState();
}

class MedicineItem {
  final String title;
  final double price;
  final String type;
  final bool inStock;

  MedicineItem({
    required this.title,
    required this.price,
    required this.type,
    required this.inStock,
  });

  factory MedicineItem.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return MedicineItem(
      title: data['title'] ?? '',
      price: data['price'] ?? 0,
      type: data['type'] ?? '',
      inStock: data['inStock'] ?? false,
    );
  }
}

class _InventoryReportScreenState extends State<InventoryReportScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<MedicineItem>> getMedicineItems() async {
    List<MedicineItem> medicineItems = [];

    QuerySnapshot querySnapshot = await _firestore.collection('medicine').get();

    querySnapshot.docs.forEach((doc) {
      medicineItems.add(MedicineItem.fromSnapshot(doc));
    });

    return medicineItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Report'),
      ),
      body: FutureBuilder<List<MedicineItem>>(
        future: getMedicineItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MedicineItem> medicineItems = snapshot.data!;
            List<MedicineItem> inStockItems = [];
            List<MedicineItem> outOfStockItems = [];

            // Separate items into in stock and out of stock lists
            for (var item in medicineItems) {
              if (item.inStock) {
                inStockItems.add(item);
              } else {
                outOfStockItems.add(item);
              }
            }

            return ListView(
              children: [
                if (inStockItems.isNotEmpty)
                  _buildTable('Items in Stock', inStockItems),
                if (outOfStockItems.isNotEmpty)
                  _buildTable('Items Out of Stock', outOfStockItems),
              ],
            );
          } else if (snapshot.hasError) {
            return const Text('Error fetching inventory');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildTable(String title, List<MedicineItem> items) {
    Color titleColor = items.isNotEmpty && items.first.inStock
        ? const Color.fromARGB(255, 3, 49, 87)
        : const Color.fromARGB(255, 136, 9, 0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: titleColor,
                decoration: TextDecoration.underline),
          ),
        ),
        DataTable(
          columns: const [
            DataColumn(
                label: Text(
              'Title',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            )),
            DataColumn(
                label: Text('Price',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
            DataColumn(
                label: Text('Type',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
            // Add more columns as necessary
          ],
          rows: items.map((item) {
            return DataRow(cells: [
              DataCell(Text(
                item.title,
                style: const TextStyle(fontSize: 17),
              )),
              DataCell(Text(item.price.toString(),
                  style: const TextStyle(fontSize: 17))),
              DataCell(Text(item.type, style: const TextStyle(fontSize: 17))),
              // Add more cells as necessary
            ]);
          }).toList(),
        ),
        const Divider(),
      ],
    );
  }
  
}
