import 'dart:io';

import 'package:flutter/foundation.dart';
import '../utils/upload_files_util.dart';

class ImageUploadProvider with ChangeNotifier {
  List<String> _imageUrls = [];

  List<String> get imageUrls {
    return _imageUrls;
  }

  uploadImages(List<File> files) {
    files.forEach((image) async {
      String _imageUrl = await uploadFile(image);
      _imageUrls.add(_imageUrl);
    });
    notifyListeners();
  }

  deleteImageUrls() {
    _imageUrls.clear();
    notifyListeners();
  }
}
