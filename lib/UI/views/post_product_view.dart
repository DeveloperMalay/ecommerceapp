import 'dart:io';

import 'package:ecommerceapp/UI/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PostProductView extends StatefulWidget {
  const PostProductView({Key? key}) : super(key: key);

  @override
  State<PostProductView> createState() => _PostProductViewState();
}

class _PostProductViewState extends State<PostProductView> {
  File? imageFile;

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      cropImage(pickedFile);
    }
  }

  void cropImage(XFile file) async {
    File? croppedImage = (await ImageCropper.platform.cropImage(
      sourcePath: file.path,
      maxWidth: null,
      maxHeight: null,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: const [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      cropStyle: CropStyle.rectangle,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 20,
      uiSettings: null,
    )) as File?;

    if (croppedImage != null) {
      setState(() {
        imageFile = croppedImage;
      });
    }
  }

  void showPhotesOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Upload Profile Picture"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  selectImage(ImageSource.gallery);
                },
                leading: const Icon(Icons.photo_album),
                title: const Text('Select from Gallery'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  selectImage(ImageSource.camera);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
              ),
            ],
          ),
        );
      },
    );
  }

  void checkValues() {
    if (imageFile == null) {
      const Text('please all the fields');
    } else {
      uploadData();
    }
  }

  void uploadData() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Your Product'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              color: theme.scaffoldBackgroundColor,
              child: const Text('Image'),
              // child: Image.file(imageFile!),
            ),
            const SizedBox(
              height: 20,
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
              color: Theme.of(context).colorScheme.secondary,
              child: const Text('Submit'),
              onPressed: () {
                checkValues();
              },
            )
          ],
        ),
      ),
    );
  }
}
