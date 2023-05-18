import 'package:flutter/material.dart';

class UserUploads extends StatefulWidget {
  const UserUploads({super.key});

  @override
  State<UserUploads> createState() => _UserUploadsState();
}

class _UserUploadsState extends State<UserUploads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer Image Uploads'),
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Text('Images uploaded by farmer to be shown here'),
        ),
      ),
    );
  }
}
