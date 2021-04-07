import 'dart:io';

import 'package:beammart_merchants/screens/camera_photo_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/image_upload_provider.dart';

import 'pick_category_screen.dart';

class AddImagesScreen extends StatefulWidget {
  @override
  _AddImagesScreenState createState() => _AddImagesScreenState();
}

class _AddImagesScreenState extends State<AddImagesScreen> {
  String? fileName;
  PickedFile? pickedImageFile;
  final picker = ImagePicker();
  List<File> _images = [];

  galleryImage(context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  cameraImage(context) {}

  void _removeImage(int index) {
    setState(() {
      _images = List.from(_images)..removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _imageUploadProvider = Provider.of<ImageUploadProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Images'),
        actions: [
          (_images.length != 0)
              ? TextButton(
                  onPressed: () {
                    _imageUploadProvider.uploadImages(_images);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PickCategory(
                                images: _images,
                              ),
                          settings: RouteSettings(name: 'PickCategoryScreen')),
                    );
                  },
                  child: Text(
                    'NEXT',
                    style: TextStyle(color: Colors.pink),
                  ),
                )
              : Container()
        ],
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  final File? _newCameraPhoto =
                      await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CameraPhotoScreen(),
                    ),
                  );
                  if (_newCameraPhoto != null) {
                    print(_newCameraPhoto.path);
                    setState(() {
                      _images.add(_newCameraPhoto);
                    });
                  }
                },
                label: Text('Camera'),
                icon: Icon(
                  Icons.camera_outlined,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  galleryImage(context);
                },
                label: Text('Gallery'),
                icon: Icon(
                  Icons.collections_outlined,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          (_images.length != 0)
              ? GridView.builder(
                  itemCount: _images.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GridTile(
                        child: Image.file(
                          _images[index],
                          fit: BoxFit.cover,
                        ),
                        footer: GridTileBar(
                          backgroundColor: Colors.black38,
                          leading: IconButton(
                            color: Colors.red,
                            icon: Icon(
                              Icons.delete_outline_outlined,
                            ),
                            onPressed: () => _removeImage(index),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                child: Text(
                    'Please select an image from gallery or take one',
                  ),
              ),
        ],
      ),
    );
  }
}
