import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentsReportScreen extends StatefulWidget {
  const PaymentsReportScreen({Key? key}) : super(key: key);

  @override
  State<PaymentsReportScreen> createState() => _PaymentsReportScreenState();
}

class UserPayment {
  final String email;
  final String mpesaCode;
  final double paidAmount;
  final String phoneNumber;
  final DateTime timePaid;

  UserPayment({
    required this.email,
    required this.mpesaCode,
    required this.paidAmount,
    required this.phoneNumber,
    required this.timePaid,
  });

  factory UserPayment.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserPayment(
      email: data['email'] ?? '',
      mpesaCode: data['mpesaCode'].toString(), // Convert to string
      paidAmount: (data['paidAmount'] ?? 0).toDouble(),
      phoneNumber: data['phoneNumber'].toString(), // Convert to string
      timePaid: (data['timePaid'] as Timestamp).toDate(),
    );
  }
}

class _PaymentsReportScreenState extends State<PaymentsReportScreen> {
  int _selectedIndex = 0;

  final List<Widget> _reportSections = [
    const MpesaReportSection(),
    const CashReportSection(),
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
        title: const Text('PAYMENTS REPORT'),
      ),
      body: SingleChildScrollView(
        child: _reportSections[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.mobile_friendly),
            label: 'M-Pesa Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Cash Report',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped, // Add this line to handle index change
      ),
    );
  }
}

class MpesaReportSection extends StatefulWidget {
  const MpesaReportSection({Key? key}) : super(key: key);

  @override
  _MpesaReportSectionState createState() => _MpesaReportSectionState();
}

class _MpesaReportSectionState extends State<MpesaReportSection> {
  List<UserPayment> _mpesaPayments = [];

  @override
  void initState() {
    super.initState();
    _fetchMpesaPayments();
  }

  void _fetchMpesaPayments() async {
    final mpesaSnapshot =
        await FirebaseFirestore.instance.collection('mpesa_payments').get();

    setState(() {
      _mpesaPayments = mpesaSnapshot.docs
          .map((doc) => UserPayment.fromSnapshot(doc))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //const Text('Report for farmers who have completed payment via M-Pesa'),
        DataTable(
          columns: const [
            DataColumn(
                label: Text('Email',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
            DataColumn(
                label: Text('Mpesa Code',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
            DataColumn(
                label: Text('Paid Amount',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
            DataColumn(
                label: Text('Phone Number',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
            DataColumn(
                label: Text('Time Paid',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
          ],
          rows: _mpesaPayments
              .map(
                (payment) => DataRow(
                  cells: [
                    DataCell(Text(payment.email,
                        style: const TextStyle(fontSize: 17))),
                    DataCell(Text(payment.mpesaCode,
                        style: const TextStyle(fontSize: 17))),
                    DataCell(Text(payment.paidAmount.toString(),
                        style: const TextStyle(fontSize: 17))),
                    DataCell(Text(payment.phoneNumber,
                        style: const TextStyle(fontSize: 17))),
                    DataCell(Text(payment.timePaid.toString(),
                        style: const TextStyle(fontSize: 17))),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class CashReportSection extends StatefulWidget {
  const CashReportSection({Key? key}) : super(key: key);

  @override
  _CashReportSectionState createState() => _CashReportSectionState();
}

class _CashReportSectionState extends State<CashReportSection> {
  List<UserPayment> _cashPayments = [];

  @override
  void initState() {
    super.initState();
    _fetchCashPayments();
  }

  void _fetchCashPayments() async {
    final cashSnapshot =
        await FirebaseFirestore.instance.collection('cash_payments').get();

    setState(() {
      _cashPayments = cashSnapshot.docs
          .map((doc) => UserPayment.fromSnapshot(doc))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //const Text('Report for farmers who have completed payment via Cash'),
        DataTable(
          columns: const [
            DataColumn(
                label: Text('Email',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
            DataColumn(
                label: Text('Paid Amount',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
            //DataColumn(label: Text('Phone Number')),
            DataColumn(
                label: Text('Time Paid',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
          ],
          rows: _cashPayments
              .map(
                (payment) => DataRow(
                  cells: [
                    DataCell(Text(payment.email,
                        style: const TextStyle(fontSize: 17))),
                    DataCell(Text(payment.paidAmount.toString(),
                        style: const TextStyle(fontSize: 17))),
                    //DataCell(Text(payment.phoneNumber)),
                    DataCell(Text(payment.timePaid.toString(),
                        style: const TextStyle(fontSize: 17))),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
