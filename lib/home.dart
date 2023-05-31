import 'package:flutter/material.dart';
import 'package:countup/countup.dart';
import 'package:wb_admin/analytics/statistics.dart';
import 'package:wb_admin/analytics/test.dart';
import 'package:wb_admin/forms/diagnosis_results.dart';
import 'package:wb_admin/forms/inv_mgmt.dart';
import 'package:wb_admin/reports/inv_report.dart';
import 'package:wb_admin/forms/payment_mgmt.dart';
import 'package:wb_admin/reports/payment_report.dart';
//import 'package:wb_admin/user_uploads.dart';
import './analytics/analytics.dart';
import 'reports/orders.dart';
import 'reports/users.dart';
import './drawer.dart';
import 'reports/diagnosis_requests.dart';

import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  //drawer config

  void _selectScreenFromDrawer(String identifier) {
    if (identifier == 'Home') {
      Navigator.of(context).pop();
      setState(() {
        _selectedPageIndex = 0;
      });
      //favourites...
    } else if (identifier == 'Users') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const UsersScreen(),
      ));
      //Cart
    } else if (identifier == 'User-Uploads') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const UserUploads(),
      ));
    } else if (identifier == 'Orders') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const OrdersScreen(),
      ));
    } else if (identifier == 'Analytics') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const AnalyticsScreen(),
      ));
    } else if (identifier == 'DiagnosisResults') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const DiagnosisResultsScreen(),
      ));
    } else if (identifier == 'DiagnosisAnalytics') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const DiagnosisAnalyticsScreen(),
      ));
    } else if (identifier == 'InventoryMGMT') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const InventoryManagementScreen(),
      ));
    } else if (identifier == 'InventoryReport') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const InventoryReportScreen(),
      ));
    } else if (identifier == 'PaymentMGMT') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const PaymentManagementScreen(),
      ));
    } else if (identifier == 'PaymentReport') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const PaymentsReportScreen(),
      ));
    } else if (identifier == 'test') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const testStats(),
      ));
    } else {
      Navigator.of(context).pop();
    }
    //set state
    setState(() {});
  }

  //url launcher
  final Uri _url = Uri.parse('https://087c-41-90-179-242.ngrok-free.app/');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WARU BORA ADMIN PANEL'),
      ),
      drawer: DrawerScreen(onSelectScreenFromDrawer: _selectScreenFromDrawer),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text('.... in partnership with ...'),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              height: 200,
              child: FractionallySizedBox(
                  heightFactor: 0.8,
                  child: Image.asset('assets/cropped-Organix-logo-edit.png')),
            ),
            const SizedBox(
              height: 45,
            ),
            Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey[300],
            ),
            const SizedBox(
              height: 55,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'TO VISIT MACHINE LEARNING SERVER FOR DIAGNOSIS, CLICK HERE',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 38, 38, 38),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                SizedBox(
                  width: 400,
                  child: ElevatedButton(
                    onPressed: _launchUrl,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900],
                        minimumSize: const Size(
                            300, 60) // Set the button's background color
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('VISIT ML SERVER'),
                        SizedBox(
                            width: 30), // Add spacing between the text and logo
                        Icon(Icons
                            .preview), // Replace "logo" with the desired icon
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        )),
      ),
    );
  }
}
