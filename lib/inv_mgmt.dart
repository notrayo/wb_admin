import 'package:flutter/material.dart';

class InventoryManagementScreen extends StatefulWidget {
  const InventoryManagementScreen({super.key});

  @override
  State<InventoryManagementScreen> createState() =>
      _InventoryManagementScreenState();
}

class _InventoryManagementScreenState extends State<InventoryManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MEDICINE INVENTORY MANAGEMENT SCREEN'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [Text('Add drugs here ...')],
        ),
      ),
    );
  }
}
