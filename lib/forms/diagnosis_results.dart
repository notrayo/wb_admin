import 'package:flutter/material.dart';

class DiagnosisResultsScreen extends StatefulWidget {
  const DiagnosisResultsScreen({super.key});

  @override
  State<DiagnosisResultsScreen> createState() => _DiagnosisResultsScreenState();
}

class _DiagnosisResultsScreenState extends State<DiagnosisResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DIAGNOSIS RESULTS FORM'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Text('Update the results of the diagnosis you did for farmer')
          ],
        ),
      ),
    );
  }
}
