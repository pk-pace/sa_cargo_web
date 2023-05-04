import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class NewManifestController extends GetxController {
  final RxInt uploadedData = 0.obs;
  final RxBool isUploading = false.obs;
  final RxBool isAdded = false.obs;
  final RxBool isSubmitted = false.obs;
  final RxString fileName = ''.obs;
}
