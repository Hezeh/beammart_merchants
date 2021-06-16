import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/image_upload_provider.dart';

onWillPop(context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Discard Changes?'),
      content: Text(
        'Do you want to exit this page without saving the changes?',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: new Text('Yes'),
        ),
      ],
    ),
  );
}

onCategoryWillPop(context) {
  final _imagesProvider =
      Provider.of<ImageUploadProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Discard Changes?'),
      content: Text(
        'Do you want discard changes already made?',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('No'),
        ),
        TextButton(
          onPressed: () {
            _imagesProvider.deleteImageUrls();
            Navigator.of(context).pop(true);
          },
          child: new Text('Yes'),
        ),
      ],
    ),
  );
}
