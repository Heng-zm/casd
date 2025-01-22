import 'dart:io' show File; // Import File only for supported platforms
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.activeBlue,
      ),
      home: CameraApp(),
    );
  }
}

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  XFile? _image;

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('iOS Camera App'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? kIsWeb
                    // For web, display the image using Image.network
                    ? Image.network(
                        _image!.path,
                        height: 300,
                        fit: BoxFit.cover,
                      )
                    // For other platforms, display the image using Image.file
                    : Image.file(
                        File(_image!.path),
                        height: 300,
                        fit: BoxFit.cover,
                      )
                : Text(
                    'No Image Selected',
                    style: CupertinoTheme.of(context).textTheme.textStyle,
                  ),
            SizedBox(height: 20),
            CupertinoButton.filled(
              onPressed: _openCamera,
              child: Text('Open Camera'),
            ),
          ],
        ),
      ),
    );
  }
}
