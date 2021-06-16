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

Future<bool> onCategoryWillPop(
  BuildContext context,
  GlobalKey<NavigatorState> _screenKey,
) async {
  final _imagesProvider =
      Provider.of<ImageUploadProvider>(context, listen: false);
  bool? canExit;
  await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Discard Changes?'),
      content: Text(
        'Do you want discard changes already made?',
      ),
      actions: <Widget>[
        TextButton(
          // onPressed: () => Navigator.of(context).pop(false),
          onPressed: () {
            canExit = false;
          },
          child: Text('No'),
        ),
        TextButton(
          onPressed: () {
            print("Exit");
            _imagesProvider.deleteImageUrls();
            // Navigator.of(context).pop(true);
            // if (_screenKey.currentState != null) {
            //   _screenKey.currentState!.pop();
            // }
            canExit = true;
          },
          child: new Text('Yes'),
        ),
      ],
    ),
  );
  // return Future.value(false);
  return Future.value(canExit);
}
