import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageManager {
  Reference referenceRoot = FirebaseStorage.instance.ref();

  late String _imageUrl;

  String get imageUrl => _imageUrl;

  Future uploadImage(XFile file) async {
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload =
        referenceDirImages.child(DateTime.now().millisecond.toString());
    await referenceImageToUpload.putFile(File(file.path));
    _imageUrl = await referenceImageToUpload.getDownloadURL();
  }
}
