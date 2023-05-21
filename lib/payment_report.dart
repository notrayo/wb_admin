import 'package:flutter/material.dart';

class PaymentsReportScreen extends StatefulWidget {
  const PaymentsReportScreen({super.key});

  @override
  State<PaymentsReportScreen> createState() => _PaymentsReportScreenState();
}

class _PaymentsReportScreenState extends State<PaymentsReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PAYMENTS REPORT '),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Text('Report farmers who have completed payment ...')
          ],
        ),
      ),
    );
  }
}
