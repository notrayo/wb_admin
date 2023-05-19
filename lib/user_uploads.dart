import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UserUploads extends StatefulWidget {
  const UserUploads({Key? key}) : super(key: key);

  @override
  State<UserUploads> createState() => _UserUploadsState();
}

class _UserUploadsState extends State<UserUploads> {
  bool _hasChanges = false;
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    listenToStorageChanges();
  }

  @override
  void dispose() {
    // Cleanup code
    super.dispose();
  }

  void listenToStorageChanges() {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;

    firebase_storage.Reference reference = storage.ref().child('images');

    reference.listAll().then((result) {
      if (mounted) {
        setState(() {
          _imageUrls.clear();
          result.items.forEach((firebase_storage.Reference ref) {
            ref.getDownloadURL().then((url) {
              if (mounted) {
                setState(() {
                  _imageUrls.add(url);
                  _hasChanges = true;
                });
              }
            });
          });
        });
      }
    });

    // Listen for changes in the Storage bucket
    reference.list().then((firebase_storage.ListResult result) {
      if (mounted) {
        setState(() {
          _hasChanges = true;
        });
      }
    });
  }

  Widget buildButtonOrText() {
    if (_hasChanges) {
      return ElevatedButton(
        onPressed: () {
          // Handle button press, such as navigating to a screen to view the images
        },
        child: const Text('View Images'),
      );
    } else {
      return const Text('No Changes in Storage');
    }
  }

  Widget buildImage(String imageUrl) {
    return Image.network(
      imageUrl,
      errorBuilder: (context, error, stackTrace) {
        return const Text('Failed to load image');
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const CircularProgressIndicator();
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          child: child,
          opacity: frame == null ? 0 : 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Image Uploads'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            buildButtonOrText(),
            const SizedBox(height: 20),
            if (_imageUrls.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                itemCount: _imageUrls.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return buildImage(_imageUrls[index]);
                },
              ),
          ],
        ),
      ),
    );
  }
}
