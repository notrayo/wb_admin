import 'package:flutter/material.dart';
import 'package:countup/countup.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WARU BORA ADMIN PANEL'),
      ),
      drawer: const Drawer(),
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
              height: 25,
            ),
            // Image.asset('assets/cropped-Organix-logo-edit.png'),
            const SizedBox(
              height: 25,
            ),
            Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey[300],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  'About App: ',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 69, 69, 69),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color.fromARGB(255, 7, 7, 7),
                  width: 0.3,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ML',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        'Accuracy',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10.0),
                  Countup(
                    begin: 0,
                    end: 96,
                    duration: const Duration(seconds: 2),
                    separator: ',',
                    suffix: '%',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey[300],
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        )),
      ),
    );
  }
}
