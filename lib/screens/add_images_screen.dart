import 'dart:io';

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
  String fileName;
  PickedFile pickedImageFile;
  final picker = ImagePicker();
  List<File> _images = [];

  getImage(context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

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
              ? FlatButton(
                  onPressed: () {
                    _imageUploadProvider.uploadImages(_images);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PickCategory(
                          images: _images,
                        ),
                      ),
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
      body: Center(
        child: Container(
          child: (_images.length != 0)
              ? GridView.builder(
                  itemCount: _images.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return GridTile(
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
                    );
                  },
                )
              : Text(
                  'Please select an item image',
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: (_images.length > 1) ? Text(
          'Add Another One',
        ) : Text('Select a photo'),
        icon: Icon(
          Icons.add_a_photo_outlined,
          // color: Colors.white,
        ),
        onPressed: () => getImage(context),
        backgroundColor: Theme.of(context).accentColor,
        tooltip: 'Select a photo',
      ),
    );
  }
}