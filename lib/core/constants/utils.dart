import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}

Future<File?> pickSingleImage() async {
  File? images;
  try {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null ) {
    

      images = File(result.files.single.path!);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}

class Success {
  int? code;
  Object? response;

  Success({this.code, this.response});
}

class Failure {
  int? code;
  Object? errorResponse;

  Failure({this.code, this.errorResponse});
}

class UserError {
  int? code;
  Object? message;

  UserError({this.code, this.message});
}
