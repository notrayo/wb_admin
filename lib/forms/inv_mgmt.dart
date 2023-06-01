import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/inventory.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class InventoryManagementScreen extends StatefulWidget {
  const InventoryManagementScreen({super.key});

  @override
  State<InventoryManagementScreen> createState() =>
      _InventoryManagementScreenState();
}

class _InventoryManagementScreenState extends State<InventoryManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  String? _imagePath;
  final _benefitsController = TextEditingController();
  final _howToUseController = TextEditingController();
  final _inStockController = TextEditingController();
  String? _inStockValue;

  //image picker
  Future<void> _selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  void _addItemToFirestore() async {
    if (_formKey.currentState!.validate()) {
      final newItem = MedicineItem(
        name: _nameController.text,
        category: _categoryController.text,
        price: double.parse(_priceController.text),
        imageLink: '', // We'll update this with the Firestore URL later
        benefits: _benefitsController.text,
        howToUse: _howToUseController.text,
        inStock: _inStockController.text.toLowerCase() == 'true',
      );

      try {
        final CollectionReference itemsRef =
            FirebaseFirestore.instance.collection('medicine');

        // Upload the image file to Firestore
        if (_imagePath != null) {
          final file = File(_imagePath!);
          final imageName = DateTime.now().millisecondsSinceEpoch.toString();
          final storageRef =
              FirebaseStorage.instance.ref().child('inv_images/$imageName');
          final uploadTask = storageRef.putFile(file);
          final snapshot = await uploadTask;
          final downloadUrl = await snapshot.ref.getDownloadURL();
          newItem.imageLink = downloadUrl;
        }

        // Add the item to Firestore
        await itemsRef.add({
          'title': newItem.name,
          'type': newItem.category,
          'price': newItem.price,
          'imageLink': newItem.imageLink,
          'benefits': newItem.benefits,
          'howToUse': newItem.howToUse,
          'inStock': newItem.inStock,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item added successfully')),
        );

        // Clear form fields and selected image
        _nameController.clear();
        _categoryController.clear();
        _priceController.clear();
        setState(() {
          _imagePath = null;
        });
        _benefitsController.clear();
        _howToUseController.clear();
        _inStockController.clear();
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add item: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MEDICINE INVENTORY MANAGEMENT SCREEN'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 255, 255, 255),
          ],
        )),
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _nameController,
                    decoration:
                        const InputDecoration(labelText: 'Medicine Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an item name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _categoryController,
                    decoration:
                        const InputDecoration(labelText: 'Medicine Type'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter type medicine';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(labelText: 'Item Price'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an item name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _benefitsController,
                    decoration:
                        const InputDecoration(labelText: 'Medicine Benefits'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the medicine benefits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _howToUseController,
                    decoration:
                        const InputDecoration(labelText: 'How to Use details'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter details';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<bool>(
                    value: _inStockValue == 'true',
                    decoration:
                        const InputDecoration(labelText: 'Is Item in stock'),
                    onChanged: (newValue) {
                      setState(() {
                        _inStockValue = newValue.toString();
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                    items: const [
                      DropdownMenuItem<bool>(
                        value: true,
                        child: Text('Yes'),
                      ),
                      DropdownMenuItem<bool>(
                        value: false,
                        child: Text('No'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Add other form fields here (category, price, benefits, howToUse, inStock)
                  ElevatedButton(
                    onPressed: _selectImage,
                    child: const Text('Select Image'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _imagePath != null
                      ? Image.file(
                          File(_imagePath!),
                          height: 100,
                        )
                      : Container(),
                  ElevatedButton(
                    onPressed: _addItemToFirestore,
                    child: const Text('Save to Database'),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
