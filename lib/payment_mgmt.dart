import 'package:flutter/material.dart';

class PaymentManagementScreen extends StatefulWidget {
  const PaymentManagementScreen({super.key});

  @override
  State<PaymentManagementScreen> createState() =>
      _PaymentManagementScreenState();
}

class _PaymentManagementScreenState extends State<PaymentManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PAYMENTS MANAGEMENT SCREEN'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Text(
                'Update farmers who have paid for drugs in cash / mpesa here ...')
          ],
        ),
      ),
    );
  }
}
