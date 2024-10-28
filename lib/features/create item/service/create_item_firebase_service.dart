import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/resources/data_state.dart';
import '../../../core/resources/firebase_utils.dart';
import '../model/create_item_model.dart';

import '../model/field_model.dart';

final class CreateItemFirebaseService extends FirebaseUtils {
  /// This method creates a new item in the database.
  Future<DataState> createItem({
    required String itemName,
    required String image,
    required List<FieldModel> fields,
  }) async {
    try {
      /// Upload image to firebase storage
      /// and get the download url
      ///  to store in the database

      final DataState imageState = await _uploadImageToFirebase(File(image));

      /// If the image upload is successful,
      if (imageState is DataSuccess) {
        if (imageState.data != null) {
          image = imageState.data as String;
        }
      }
      // create a map of the item data
      final Map<String, dynamic> data = CreateItemModel(
        title: itemName,
        imageUrl: image,
        fields: fields,
        createdDate: DateTime.now(),
      ).toMap();

      /// Get the user document reference
      final DocumentReference<Map<String, dynamic>> userDoc =
          await getUserDoc();

      /// Add the item data to the user document
      await userDoc.collection(DatabaseKeys.Items.name).add(data).then(
        (value) {
          /// Update the item id in the database
          value.update({'id': value.id});
        },
      );
      return DataSuccess(null);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState> _uploadImageToFirebase(File? imagePath) async {
    try {
      if (imagePath != null) {
        final ref = storage.ref().child('$uid/images/$imagePath');
        await ref.putFile(imagePath);
        final String url = await ref.getDownloadURL();
        return DataSuccess(url);
      } else {
        return DataSuccess(null);
      }
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
