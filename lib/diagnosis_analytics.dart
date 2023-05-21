import 'package:flutter/material.dart';

class DiagnosisAnalyticsScreen extends StatefulWidget {
  const DiagnosisAnalyticsScreen({super.key});

  @override
  State<DiagnosisAnalyticsScreen> createState() =>
      _DiagnosisAnalyticsScreenState();
}

class _DiagnosisAnalyticsScreenState extends State<DiagnosisAnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DIAGNOSIS ANALYTICS'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Text('Visualize the diagnosis results in a pie chart / bar chart')
          ],
        ),
      ),
    );
  }
}
