import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiagnosisResultsScreen extends StatefulWidget {
  const DiagnosisResultsScreen({super.key});

  @override
  State<DiagnosisResultsScreen> createState() => _DiagnosisResultsScreenState();
}

class _DiagnosisResultsScreenState extends State<DiagnosisResultsScreen> {
  final _formKey = GlobalKey<FormState>();
  //final _emailController = TextEditingController();
  //final _diagnosisController = TextEditingController();
  double _selectedPercentage = 0;

  String? _selectedEmail;
  List<String> _availableEmails = [];
  String? _selectedDiagnosis;
  final List<String> _diagnosisOptions = [
    'Early Blight',
    'Late Blight',
    'Healthy'
  ];

  @override
  void initState() {
    super.initState();
    _fetchAvailableEmails();
  }

  void _fetchAvailableEmails() async {
    final usersSnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    setState(() {
      _availableEmails =
          usersSnapshot.docs.map((doc) => doc['email'] as String).toList();
    });
  }

  @override
  void dispose() {
    //_emailController.dispose();
    //_diagnosisController.dispose();
    //_percentageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      //final email = _emailController.text;
      //final diagnosis = _diagnosisController.text;
      //final percentage = _percentageController.text;

      // Save the data to Firebase collection
      FirebaseFirestore.instance.collection('diagnosis_results').add({
        'email': _selectedEmail,
        'diagnosis': _selectedDiagnosis,
        'ML_Accuracy': _selectedPercentage,
        'timeStamp': DateTime.now(),
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Feedback captured successfully')),
        );
        _formKey.currentState!.reset();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('An error occurred. Please try again later.')),
        );
      });

      // Reset the form
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DIAGNOSIS RESULTS FORM'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Update the results of the diagnosis you did for the farmer request:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 35),
              DropdownButtonFormField<String>(
                value: _selectedEmail,
                onChanged: (value) {
                  setState(() {
                    _selectedEmail = value;
                  });
                },
                items: _availableEmails.map((email) {
                  return DropdownMenuItem<String>(
                    value: email,
                    child: Text(email),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              DropdownButtonFormField<String>(
                value: _selectedDiagnosis,
                onChanged: (value) {
                  setState(() {
                    _selectedDiagnosis = value;
                  });
                },
                items: _diagnosisOptions.map((diagnosis) {
                  return DropdownMenuItem<String>(
                    value: diagnosis,
                    child: Text(diagnosis),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Diagnosis',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a diagnosis';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Text(
                'Prediction Accuracy as % : ${_selectedPercentage.round()}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 15,
              ),
              Slider(
                value: _selectedPercentage,
                onChanged: (value) {
                  setState(() {
                    _selectedPercentage = value;
                  });
                },
                min: 0,
                max: 100,
                divisions: 100,
                label: '${_selectedPercentage.round()}',
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitForm,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue[900]!),
                  minimumSize: MaterialStateProperty.all<Size>(
                      const Size(double.infinity, 50)),
                ),
                child: const Text('Submit to Database'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
