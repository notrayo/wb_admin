import 'package:flutter/material.dart';

class InventoryReportScreen extends StatefulWidget {
  const InventoryReportScreen({super.key});

  @override
  State<InventoryReportScreen> createState() => _InventoryReportScreenState();
}

class _InventoryReportScreenState extends State<InventoryReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MEDICINE INVENTORY REPORT'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [Text('Available drugs to be displayed here ...')],
        ),
      ),
    );
  }
}
