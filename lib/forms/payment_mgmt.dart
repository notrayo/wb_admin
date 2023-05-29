import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentManagementScreen extends StatefulWidget {
  const PaymentManagementScreen({Key? key}) : super(key: key);

  @override
  _PaymentManagementScreenState createState() =>
      _PaymentManagementScreenState();
}

class _PaymentManagementScreenState extends State<PaymentManagementScreen> {
  int _selectedIndex = 0; // Track the selected section index

  final List<Widget> _sections = [
    const MpesaPaymentSection(),
    const CashPaymentSection(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PAYMENTS MANAGEMENT SCREEN'),
      ),
      body: SingleChildScrollView(
        child: _sections[_selectedIndex], // Show the selected section
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.mobile_friendly),
            label: 'M-Pesa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Cash',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}

class MpesaPaymentSection extends StatefulWidget {
  const MpesaPaymentSection({Key? key}) : super(key: key);

  @override
  _MpesaPaymentSectionState createState() => _MpesaPaymentSectionState();
}

class _MpesaPaymentSectionState extends State<MpesaPaymentSection> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedEmail;
  List<String> _availableEmails = [];
  String? _mpesaCode;
  int? _paidAmount;
  int? _phoneNumber;

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

  void _submitMpesaForm() {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance.collection('mpesa_payments').add({
        'email': _selectedEmail,
        'mpesaCode': _mpesaCode,
        'paidAmount': _paidAmount,
        'phoneNumber': _phoneNumber,
        'timePaid': DateTime.now(),
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mpesa Transaction Added Successfully')),
        );
        _formKey.currentState!.reset();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('An error occurred. Please try again later.')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'UPDATE PAYMENT INFO FOR FARMERS WHO PAID VIA M-PESA:',
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
                items: _availableEmails
                    .map((email) => DropdownMenuItem<String>(
                          value: email,
                          child: Text(email),
                        ))
                    .toList(),
                decoration: const InputDecoration(
                  labelText: 'Select Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MPESA Code',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the MPESA code';
                  }
                  return null;
                },
                onChanged: (value) {
                  _mpesaCode = value;
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Paid Amount',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the paid amount';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _paidAmount = int.tryParse(value);
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the phone number';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _phoneNumber = int.tryParse(value);
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 3, 98, 11)!),
                ),
                onPressed: _submitMpesaForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CashPaymentSection extends StatefulWidget {
  const CashPaymentSection({Key? key}) : super(key: key);

  @override
  _CashPaymentSectionState createState() => _CashPaymentSectionState();
}

class _CashPaymentSectionState extends State<CashPaymentSection> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedEmail;
  List<String> _availableEmails = [];
  int? _paidAmount;

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

  void _submitCashForm() {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance.collection('cash_payments').add({
        'email': _selectedEmail,
        'timePaid': DateTime.now(),
        'paidAmount': _paidAmount
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cash Transaction Added Successfully')),
        );
        _formKey.currentState!.reset();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('An error occurred. Please try again later.')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'UPDATE PAYMENT INFO FOR FARMERS WHO PAID VIA CASH:',
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
                items: _availableEmails
                    .map((email) => DropdownMenuItem<String>(
                          value: email,
                          child: Text(email),
                        ))
                    .toList(),
                decoration: const InputDecoration(
                    labelText: 'Select Email', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Paid Amount',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the paid amount';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _paidAmount = int.tryParse(value);
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue[900]!),
                ),
                onPressed: _submitCashForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
