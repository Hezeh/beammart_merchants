import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/image_upload_provider.dart';

Future<bool> onWillPop(context) async {
  return (await (showDialog(
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
      ) as FutureOr<bool>?)) ??
      false;
}

Future<bool> onCategoryWillPop(context) async {
  final _imagesProvider = Provider.of<ImageUploadProvider>(context, listen: false);
  return (await (showDialog(
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
      ) as FutureOr<bool>?)) ??
      false;
}
