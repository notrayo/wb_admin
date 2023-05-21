import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserUploads extends StatefulWidget {
  const UserUploads({Key? key}) : super(key: key);

  @override
  State<UserUploads> createState() => _UserUploadsState();
}

class _UserUploadsState extends State<UserUploads> {
  //bool _hasChanges = false;
  //List<String> _imageUrls = [];
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Image Uploads'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [Text('images uploaded to appear here ...')],
        ),
      ),
    );
  }
}
