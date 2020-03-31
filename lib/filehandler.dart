import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class FileHandler {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    String fileName = await getFileName();
    return File(fileName);
  }

  Future<File> writeMyLocationToFile(String locationString) async {
    final file = await _localFile;
    // Write the file.
    return file.writeAsString('$locationString', mode: FileMode.append);
  }

  Future<String> readMyLocationFromFile() async {
    try {
      final file = await _localFile;

      // Read the file.
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0.
      return null;
    }
  }

  Future uploadInfectedFileToServer(BuildContext buildContext) async{
    try {
      final File file = await _localFile;
      final fileName = await getFileName();
      StorageReference firebaseStorage = FirebaseStorage.instance.ref().child("infectedPeople").child("infected_user");
      StorageUploadTask uploadTask = firebaseStorage.putFile(file);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      print("File uploaded to server");

    } catch (e) {
      // If encountering an error, return 0.
    }

  }

  Future<String> getFileName() async{
    final path = await _localPath;
    String fileName = '$path.txt';
    return fileName;
  }
}