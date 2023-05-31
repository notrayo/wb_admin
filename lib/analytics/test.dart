//testing the updates of statistics from firebase

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class testStats extends StatefulWidget {
  const testStats({super.key});

  @override
  State<testStats> createState() => _testStatsState();
}

class _testStatsState extends State<testStats> {
  double averageRating = 0.0;

  @override
  void initState() {
    super.initState();
    fetchAverageRating();
  }

  Future<void> fetchAverageRating() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('ratings').get();

    if (snapshot.docs.isNotEmpty) {
      final List<int> ratings =
          snapshot.docs.map((doc) => doc['rating'] as int).toList();
      final int sumOfRatings = ratings.reduce((a, b) => a + b);
      averageRating = sumOfRatings / ratings.length;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('testing averages...'),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              'Average Rating: ${averageRating.toStringAsFixed(1)}',
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
