import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/new_manifest/new_manifest_controller.dart';

class NewManifest extends StatelessWidget {
  NewManifest({Key? key}) : super(key: key);
  final TextEditingController _cargoDescriptionController =
      TextEditingController();
  final TextEditingController _vesselController = TextEditingController();
  final TextEditingController _voyageController = TextEditingController();
  String manifestLength = '0';
  List<List<dynamic>> rows = [];

  @override
  Widget build(BuildContext context) {
    final NewManifestController _newManifestController =
        Get.put(NewManifestController());
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 110.h,
                // margin: EdgeInsets.only(bottom: 10.h),
                width: double.infinity,
                padding: EdgeInsets.only(right: 35.w, left: 5.w),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 4,
                      offset: const Offset(1, 3),
                      spreadRadius: 0.5)
                ]),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.menu_outlined,
                          size: 45.sp,
                          color: Colors.black,
                        ),
                        onTap: () {
                          //_scaffoldKey.currentState!.openDrawer();
                        },
                      ),
                      Image.asset(
                        "assets/newAppassets/images/AppBar_logo_banner.png",
                        height: 250.h,
                        width: 250.w,
                      ),
                    ],
                  ),
                ),
              ),
              //////////////////////////////////////////////////
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Import Request',
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: "poppins_semiBold",
                              fontSize: 21.sp,
                              fontWeight: FontWeight.w500),
                        ).paddingOnly(top: 20.h, bottom: 10.h),
                        Text(
                          'Add a new manifest',
                          style: TextStyle(
                              color: Colors.black45,
                              //fontFamily: "poppins_semiBold",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400),
                        ).paddingOnly(bottom: 10.h),
                        textFieldTags(
                          title: "Cargo Description",
                        ).paddingOnly(bottom: 10.h, top: 10.h),
                        TextField(
                          controller: _cargoDescriptionController,
                          autofocus: false,
                          obscureText: false,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black26,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black26,
                                width: 1,
                              ),
                            ),
                          ),
                        ).paddingOnly(bottom: 10.h),
                        textFieldTags(
                          title: "Vessel",
                        ).paddingOnly(bottom: 10.h, top: 10.h),
                        TextField(
                          controller: _vesselController,
                          autofocus: false,
                          obscureText: false,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black26,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black26,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        textFieldTags(
                          title: "Voyage",
                        ).paddingOnly(bottom: 10.h, top: 10.h),
                        TextField(
                          controller: _voyageController,
                          autofocus: false,
                          obscureText: false,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black26,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black26,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          return TextButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.green),
                            ),
                            onPressed: _newManifestController.isUploading.value
                                ? null
                                : () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles();
                                    if (result != null) {
                                      File file =
                                          File(result.files.single.path!);

                                      if (file.path
                                              .split('/')
                                              .last
                                              .split('.')
                                              .last !=
                                          'csv') {
                                        Get.snackbar('Error',
                                            'Please select csv file only',
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.redAccent);
                                        return;
                                      }

                                      final bytes = await file.readAsString();
                                      rows = const CsvToListConverter()
                                          .convert(bytes);
                                      _newManifestController.isAdded.value =
                                          true;
                                      _newManifestController.fileName.value =
                                          file.path.split('/').last;
                                    } else {
                                      Get.snackbar(
                                          'Error', 'Please select file',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.redAccent);
                                    }
                                  },
                            child: Text("Upload CSV"),
                          );
                        }),
                        Obx(() {
                          return Visibility(
                            visible: _newManifestController.isUploading.value,
                            child: SizedBox(
                              height: 10,
                              child: LinearProgressIndicator(
                                value:
                                    (_newManifestController.uploadedData.value /
                                        rows.length),
                                backgroundColor: Colors.grey[200],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.black),
                              ),
                            ),
                          );
                        }),
                        Obx(() {
                          return Visibility(
                            visible: _newManifestController.isAdded.value,
                            child: SizedBox(
                              height: 50.h,
                              child: Row(
                                children: [
                                  Icon(Icons.file_copy_outlined,
                                      color: Colors.black, size: 30.sp),
                                  Text(_newManifestController.fileName.value)
                                ],
                              ),
                            ),
                          );
                        }),
                        Row(
                          children: [
                            Expanded(
                              child: Obx(() {
                                return _newManifestController.isUploading.value
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      )
                                    : TextButton(
                                        style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.green),
                                        ),
                                        onPressed: () async {
                                          if (_cargoDescriptionController
                                              .text.isEmpty) {
                                            Get.snackbar("Error",
                                                "Please enter cargo description",
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                backgroundColor:
                                                    Colors.redAccent);
                                            return;
                                          }
                                          if (_vesselController.text.isEmpty) {
                                            Get.snackbar("Error",
                                                "Please enter vessel name",
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                backgroundColor:
                                                    Colors.redAccent);
                                            return;
                                          }
                                          if (_voyageController.text.isEmpty) {
                                            Get.snackbar("Error",
                                                "Please enter voyage number",
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                backgroundColor:
                                                    Colors.redAccent);
                                            return;
                                          }

                                          if (_newManifestController
                                              .isAdded.value) {
                                            await addImportData();
                                            await uploadCSVFile(
                                                rows, _newManifestController);
                                            // Get.to(() =>
                                            //     const ShipmentInfoScreen());
                                          } else {
                                            Get.snackbar(
                                                "Error", "Please add File",
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                backgroundColor:
                                                    Colors.redAccent);
                                          }
                                        },
                                        child: Text("Submit"),
                                      );
                              }),
                            ),
                            Expanded(
                              child: TextButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.green),
                                ),
                                onPressed: () {
                                  Get.back();
                                  // Get.to(() => const ShipmentInfoScreen());
                                },
                                child: Text("Cancel"),
                              ),
                            ),
                          ],
                        ).paddingOnly(top: 50.h, bottom: 5.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFieldTags({required String title, double? height}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.green,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          height: height,
          fontFamily: "poppins_semiBold",
        ),
      ),
    );
  }

  Future<void> uploadCSVFile(
      List<List<dynamic>> rows, NewManifestController controller) async {
    controller.isUploading.value = true;

    final dbRef = FirebaseDatabase.instance
        .ref()
        .child('manifest/$manifestLength/vehicle/');

    int i = 0;

    await Future.forEach(rows, (List element) async {
      if (i == 0) {
        i++;
        return;
      }

      await dbRef
          .child('${element[0]}')
          .update({'vin': element[0], 'model': element[2], "scanned": false});

      i++;
      controller.uploadedData.value = i;
    });
    controller.isUploading.value = false;
  }

  Future<bool> addImportData() async {
    bool isSuccess = true;
    try {
      await FirebaseDatabase.instance
          .ref()
          .child('manifest')
          .once()
          .then((value) {
        manifestLength =
            (value.snapshot.value as List<dynamic>).length.toString();
      });
      await FirebaseDatabase.instance
          .ref()
          .child('manifest/$manifestLength')
          .set({
        'cargo_desc': _cargoDescriptionController.text,
        'vessel': _vesselController.text,
        'voyage': _voyageController.text,
        'vehicle': ""
      });
    } catch (e) {
      isSuccess = false;
      Get.snackbar("Error", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent);
    }

    return isSuccess;
  }
}
