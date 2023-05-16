import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Users '),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Text('Authenticated users to be displayed here ...')
          ],
        ),
      ),
    );
  }
}
