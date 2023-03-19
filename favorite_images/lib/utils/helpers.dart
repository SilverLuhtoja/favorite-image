import 'dart:convert';
import 'package:image_picker/image_picker.dart';
//
// finishes executing, Android will restart the application. Since the data
// is never returned to the original call use the ImagePicker.retrieveLostData()
// method to retrieve the lost data. For example:
//
// Future<void> getLostData() async {
//   final LostDataResponse response = await picker.retrieveLostData();
//   if (response.isEmpty) {
//     return;
//   }
//   if (response.files != null) {
//     for (final XFile file in response.files) {
//       _handleFile(file);
//     }
//   } else {
//     _handleError(response.exception);
//   }
// }