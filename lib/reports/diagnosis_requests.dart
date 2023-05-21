import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

class UserUploads extends StatefulWidget {
  const UserUploads({Key? key}) : super(key: key);

  @override
  State<UserUploads> createState() => _UserUploadsState();
}

class ImageItem {
  final String email;
  final String imageLink;
  final Timestamp timestamp;

  ImageItem({
    required this.email,
    required this.imageLink,
    required this.timestamp,
  });

  factory ImageItem.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return ImageItem(
      email: data['email'] ?? '',
      imageLink: data['imageUrl'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}

class ImageTable {
  final DateTime date;
  final List<ImageItem> items;

  ImageTable({
    required this.date,
    required this.items,
  });
}

class _UserUploadsState extends State<UserUploads> {
  //bool _hasChanges = false;
  //List<String> _imageUrls = [];
  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ImageItem>> getImageItems() async {
    List<ImageItem> imageItems = [];

    QuerySnapshot querySnapshot = await _firestore
        .collection('images') // Replace with your Firestore collection name
        .orderBy('timestamp', descending: true)
        .get();

    querySnapshot.docs.forEach((doc) {
      imageItems.add(ImageItem.fromSnapshot(doc));
    });

    return imageItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis Requests Report'),
      ),
      body: FutureBuilder<List<ImageItem>>(
        future: getImageItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ImageItem> imageItems = snapshot.data!;
            List<ImageTable> tables = [];

            if (imageItems.isEmpty) {
              return const Center(child: Text('No data available'));
            }

            DateTime? currentDate;

            for (int i = 0; i < imageItems.length; i++) {
              ImageItem item = imageItems[i];

              DateTime itemDate = item.timestamp.toDate();
              DateTime? previousDate =
                  i > 0 ? imageItems[i - 1].timestamp.toDate() : null;

              if (currentDate == null || itemDate.day != currentDate.day) {
                tables.add(ImageTable(date: itemDate, items: [item]));
                currentDate = itemDate;
              } else if (previousDate != null &&
                  itemDate.day != previousDate.day) {
                tables.add(ImageTable(date: itemDate, items: [item]));
              } else {
                tables.last.items.add(item);
              }
            }

            return ListView(
              children: tables.map((table) {
                return _buildTable(table.date, table.items);
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildTable(DateTime date, List<ImageItem> items) {
    return Table(
      children: [
        TableRow(
          children: [
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Text(
                  ' -------------------------------  Date: ${date.toString()} ---------------------------',
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
                      //decoration: TextDecoration.underline,
                      ),
                ),
              ),
            ),
          ],
        ),
        ...items.map((item) {
          return TableRow(
            children: [
              TableCell(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Email  :      ${item.email}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Image.network(
                        item.imageLink,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }
}
