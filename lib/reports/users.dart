import 'package:flutter/material.dart';

//firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class User {
  final String id;
  final String first_name;
  final String last_name;
  final String email;
  final String phoneNumber;
  final String county;

  User(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.email,
      required this.phoneNumber,
      required this.county});

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return User(
        id: snapshot.id,
        first_name: data['first_name'] ?? '',
        last_name: data['last_name'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        county: data['county'] ?? '');
  }
}

class _UsersScreenState extends State<UsersScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //authenticated users

  Future<List<User>> getAuthenticatedUsers() async {
    List<User> authenticatedUsers = [];

    QuerySnapshot querySnapshot = await _firestore
        .collection(
            'users') // Assuming you have a 'users' collection in Firestore
        .get();

    querySnapshot.docs.forEach((doc) {
      authenticatedUsers.add(User.fromSnapshot(doc));
    });

    return authenticatedUsers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Users '),
      ),
      body: FutureBuilder<List<User>>(
        future: getAuthenticatedUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User> users = snapshot.data!;
            return DataTable(
              columns: const [
                //DataColumn(label: Text('ID')),
                DataColumn(
                    label: Text('First Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15))),
                DataColumn(
                    label: Text('Last Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15))),
                DataColumn(
                    label: Text('Email',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15))),
                DataColumn(
                    label: Text('Phone Number',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15))),
                DataColumn(
                    label: Text('County',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15))),
              ],
              rows: users.map((user) {
                return DataRow(cells: [
                  //DataCell(Text(user.id)),
                  DataCell(Text(user.first_name,
                      style: const TextStyle(fontSize: 17))),
                  DataCell(Text(user.last_name,
                      style: const TextStyle(fontSize: 17))),
                  DataCell(
                      Text(user.email, style: const TextStyle(fontSize: 17))),
                  DataCell(Text(user.phoneNumber,
                      style: const TextStyle(fontSize: 17))),
                  DataCell(
                      Text(user.county, style: const TextStyle(fontSize: 17))),
                ]);
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return const Text('Error fetching users');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

//widget

