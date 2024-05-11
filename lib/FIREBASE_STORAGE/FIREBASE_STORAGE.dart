import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Firebase_Storage_Provider = Provider(
  (ref) => COMMON_FIREBASE_STORAGE(firebaseStorage: FirebaseStorage.instance),
);

class COMMON_FIREBASE_STORAGE {
  final FirebaseStorage firebaseStorage;
  const COMMON_FIREBASE_STORAGE({required this.firebaseStorage});

  Future<String> SAVE_PROFILE_PIC_TO_FIREBASE_STORAGE(
      {required File profile_pic, required String path}) async {
    UploadTask uploadTask =
        firebaseStorage.ref().child(path).putFile(profile_pic);
    TaskSnapshot snapshot = await uploadTask;
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
