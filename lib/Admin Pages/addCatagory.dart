// ignore: file_names
import 'dart:io';

import 'package:flutter_ecommerce_155e5/Admin%20Pages/app_amdin_helper.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_text.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_widgets.dart';
import 'package:flutter_ecommerce_155e5/modelsPages/loation_model.dart';
import 'package:flutter_ecommerce_155e5/modelsPages/menu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class AddCatagory extends StatefulWidget {
  MenuModelFirebaseSetData? myMenuIteamList;
  LocationModel? myLocations;
  bool enable;
  String? catagoriName;
  AddCatagory(
      {required this.myMenuIteamList,
      required this.enable,
      required this.myLocations,
      this.catagoriName,
      super.key});

  @override
  _AddCatagory createState() => _AddCatagory();
}

class _AddCatagory extends State<AddCatagory> {
  TextEditingController catagoryController = TextEditingController();
  TextEditingController iteamNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountontroller = TextEditingController();
  File? imageFile;
  List<File> _additionalImages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!widget.enable) {
      catagoryController.text = widget.catagoriName!;
    }
    locationLoaderCaller();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _additionalImages.add(File(pickedFile.path));
      });
    }
  }

  Future<String> _uploadFile(File file, String path) async {
    try {
      Reference storage = FirebaseStorage.instance
          .ref()
          .child("Menu Images")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child(const Uuid().v6());

      final uploadTask = storage.putFile(file);
      await uploadTask.whenComplete(() {});
      final downloadUrl = await storage.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to upload file: $e')));
      return "";
    }
  }

  Future<List<String>> _uploadImages(List<File> images) async {
    final imageUrls = <String>[];
    for (File image in images) {
      String path =
          'projects/images/${DateTime.now().millisecondsSinceEpoch}.png';
      String url = await _uploadFile(image, path);
      imageUrls.add(url);
    }
    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customText((!widget.enable) ? "Add a iteam" : "Add a Catagory"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomWidgets.textFormFieldCustom(
                  enabled: widget.enable,
                  text: "Catagory Name",
                  controller: catagoryController),
              const SizedBox(
                height: 10,
              ),
              CustomWidgets.textFormFieldCustom(
                  text: "Iteam Name", controller: iteamNameController),
              const SizedBox(
                height: 10,
              ),
              CustomWidgets.textFormFieldCustom(
                  text: "Description", controller: descriptionController),
              const SizedBox(
                height: 10,
              ),
              CustomWidgets.textFormFieldCustom(
                  text: "Price", controller: priceController),
              const SizedBox(
                height: 10,
              ),
              CustomWidgets.textFormFieldCustom(
                  text: "Discount", controller: discountontroller),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  imageDialogChooser();
                },
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                      color: Colors.yellow.shade50,
                      border: Border.all(color: Colors.yellow),
                      borderRadius: BorderRadius.circular(20)),
                  child: (imageFile != null)
                      ? Image(image: FileImage(imageFile!))
                      : const Center(
                          child: CircleAvatar(
                            radius: 25,
                            child: Icon(Icons.add),
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              const SizedBox(height: 16),
              customText('Additional Images', fontWeigth: FontWeight.bold),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _additionalImages
                    .map((image) => Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 2, color: Colors.black)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(image)),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: IconButton(
                                icon: Icon(Icons.remove_circle,
                                    color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    _additionalImages.remove(image);
                                  });
                                },
                              ),
                            ),
                          ],
                        ))
                    .toList(),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                child: Text('Add Additional Image'),
              ),
              const SizedBox(height: 16),

              CustomWidgets.elevatedButtonCustom(
                  hintText: "Add",
                  onPressedButton: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return const Center(child: CircularProgressIndicator());
                      },
                    );
                    if (catagoryController.text.length > 2 &&
                        iteamNameController.text.length > 2 &&
                        priceController.text.isNotEmpty &&
                        imageFile != null) {
                      const CircularProgressIndicator();

                      try {
                        double? price = double.tryParse(priceController.text);

                        if (price == null) {
                          CustomWidgets.snackBarCustom(context,
                              massage: "invalid price");
                          return;
                        }
                        imageUploadToFirebase(
                          iteamName: iteamNameController.text,
                          catagory: catagoryController.text,
                          description: descriptionController.text,
                          price: price,
                        );
                      } catch (e) {
                        CustomWidgets.snackBarCustom(context,
                            massage: "invalid price");
                      }
                    } else {
                      CustomWidgets.snackBarCustom(context,
                          massage: "Provied All Data");
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              // customText("You can add more locations\non edit panel",
              //     alinment: TextAlign.center, softWrap: true),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  late List<bool> districtEditModes;
  late DistrictModel destrict;
  late UpazilaModel upazila;
  late String area;
  int destrictIndex = 0;
  int upazilaIndex = 0;
  int areaIndex = 0;
  bool isLocationModified = false;

  int doesContainDistrict(String districtName) {
    if (widget.myLocations != null) {
      for (int i = 0; i < widget.myLocations!.destricts.length; i++) {
        if (widget.myLocations!.destricts[i].destrict == districtName) {
          return i;
        }
      }
    }
    return -1;
  }

  int doesContainUpazila(int destrictIndex, String upazilaName) {
    if (widget.myLocations != null) {
      for (int i = 0;
          i < widget.myLocations!.destricts[destrictIndex].upazilas.length;
          i++) {
        if (widget.myLocations!.destricts[destrictIndex].upazilas[i].upazila ==
            upazilaName) {
          return i;
        }
      }
    }
    return -1;
  }

  bool doesContainArea(int destrictIndex, int upazilaIndex, String areatName) {
    if (widget.myLocations != null) {
      for (var area in widget
          .myLocations!.destricts[destrictIndex].upazilas[upazilaIndex].areas) {
        if (area == areatName) {
          return true;
        }
      }
    }
    return false;
  }

  // void addLocation(
  //     {required String district,
  //     required String upazila,
  //     required String area}) {
  //   widget.myLocations ??= LocationModel(destricts: [
  //     DistrictModel(destrict: district, upazilas: [
  //       UpazilaModel(upazila: upazila, areas: [area])
  //     ])
  //   ]);
  //   int localDestrictIndex = doesContainDistrict(district);
  //   if (localDestrictIndex != -1) {
  //     int localUpazilaIndex = doesContainUpazila(localDestrictIndex, upazila);
  //     if (localUpazilaIndex != -1) {
  //       if (doesContainArea(localDestrictIndex, localUpazilaIndex, area)) {
  //         CustomWidgets.snackBarCustom(context,
  //             massage: "this area already exist");
  //       } else {
  //         widget.myLocations!.destricts[localDestrictIndex]
  //             .upazilas[localUpazilaIndex].areas
  //             .add(area);
  //         isLocationModified = true;
  //       }
  //     } else {
  //       widget.myLocations!.destricts[localDestrictIndex].upazilas
  //           .add(UpazilaModel(upazila: upazila, areas: [area]));
  //       isLocationModified = true;
  //     }
  //   } else {
  //     widget.myLocations!.destricts
  //         .add(DistrictModel(destrict: district, upazilas: [
  //       UpazilaModel(upazila: upazila, areas: [area])
  //     ]));
  //     isLocationModified = true;
  //   }
  //   setState(() {
  //     destrictIndex = 0;
  //     upazilaIndex = 0;
  //     areaIndex = 0;
  //     districtEditModes = List.generate(
  //       widget.myLocations!.destricts.length,
  //       (index) => false,
  //     );
  //     locationPickerRefrasher();
  //   });
  // }
  // void removeLocation(
  //     {required int localDistrictIndex,
  //     int? localupazilaIndex,
  //     int? localareaIndex}) {
  //   if (localupazilaIndex != null) {
  //     if (localareaIndex != null) {
  //       if (widget.myLocations!.destricts[localDistrictIndex]
  //               .upazilas[localupazilaIndex].areas.length >
  //           1) {
  //         widget.myLocations!.destricts[localDistrictIndex]
  //             .upazilas[localupazilaIndex].areas
  //             .removeAt(localareaIndex);
  //         isLocationModified = true;
  //       } else {
  //         CustomWidgets.snackBarCustom(context,
  //             massage: "you can't remove last area.remove the upazila");
  //       }
  //     } else {
  //       if (widget.myLocations!.destricts[localDistrictIndex].upazilas.length >
  //           1) {
  //         widget.myLocations!.destricts[localDistrictIndex].upazilas
  //             .removeAt(localupazilaIndex);
  //         isLocationModified = true;
  //       } else {
  //         CustomWidgets.snackBarCustom(context,
  //             massage: "you can't remove last upazila.remove the district");
  //       }
  //     }
  //   } else {
  //     if (widget.myLocations!.destricts.length > 1) {
  //       widget.myLocations!.destricts.removeAt(localDistrictIndex);
  //       isLocationModified = true;
  //       districtEditModes = List.generate(
  //         widget.myLocations!.destricts.length,
  //         (index) => false,
  //       );
  //     } else {
  //       CustomWidgets.snackBarCustom(context,
  //           massage: "you can't remove the last district.");
  //     }
  //   }
  //   setState(() {
  //     destrictIndex = 0;
  //     upazilaIndex = 0;
  //     areaIndex = 0;
  //     locationPickerRefrasher();
  //   });
  // }

  void locationPickerRefrasher() async {
    destrict = FullBDLocations.destricts[destrictIndex];
    upazila = destrict.upazilas[upazilaIndex];
    area = upazila.areas[areaIndex];
    setState(() {});
  }

  void locationLoaderCaller() {
    destrict = FullBDLocations.destricts[destrictIndex];
    destrict = FullBDLocations.destricts[destrictIndex];
    upazila = destrict.upazilas[upazilaIndex];
    area = upazila.areas[areaIndex];

    widget.myLocations = widget.myLocations;

    districtEditModes = List.generate(
      widget.myLocations!.destricts.length,
      (index) => false,
    );
    setState(() {});
  }

  void imageDialogChooser() {
    showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text("Choose from gerally"),
                  onTap: () {
                    Navigator.pop(context);
                    image_picker(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("take a picture"),
                  onTap: () {
                    Navigator.pop(context);
                    image_picker(ImageSource.camera);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void image_picker(ImageSource source) async {
    XFile? file = await ImagePicker().pickImage(source: source);
    if (file != null) {
      String? path = file.path;
      print("image android picked");

      setState(() {
        imageFile = File(path);
      });
    }
  }

  void imageUploadToFirebase(
      {required String iteamName,
      required String catagory,
      String? description,
      double? price}) async {
    // String imageName = imageFile!.path.split('/').last;
    Reference storage = FirebaseStorage.instance
        .ref()
        .child("Menu Images")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(const Uuid().v6());
    try {
      await storage
          .putFile(imageFile!, SettableMetadata(contentType: 'image/jpeg'))
          .then((value) {
        storage.getDownloadURL().then((value) async {
          // Separate local files and URLs
          List<File> localFiles = _additionalImages;
          List<String> uploadedUrls = [];
          try {
            if (localFiles.isNotEmpty) {
              uploadedUrls = await _uploadImages(localFiles);
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Failed to upload additional images: $e')));
          }

          addCatagoryToMenuIteamListAndFirebase(
              catagory: catagory,
              iteamName: iteamName,
              imagePath: value,
              description: description,
              additionalImages: uploadedUrls,
              price: price);
        });
      });
    } on FirebaseException {
      SnackBar(content: customText("An error occoured"));
    }
  }

  void addCatagoryToMenuIteamListAndFirebase(
      {required String iteamName,
      required String catagory,
      String? description,
      double? price,
      List<String>? additionalImages,
      required String imagePath}) {
    bool isCatagoryExist = false;
    if (widget.myMenuIteamList != null &&
        widget.myMenuIteamList!.menuIteamList!.isNotEmpty) {
      for (int i = 0; i < widget.myMenuIteamList!.menuIteamList!.length; i++) {
        if (widget.myMenuIteamList!.menuIteamList![i].menuName == catagory) {
          isCatagoryExist = true;
          bool isIteamExist = false;
          for (int j = 0;
              j < widget.myMenuIteamList!.menuIteamList![i].iteams!.length;
              j++) {
            if (widget
                    .myMenuIteamList!.menuIteamList![i].iteams![j].iteamName ==
                iteamName) {
              isIteamExist = true;
              CustomWidgets.snackBarCustom(context,
                  massage: "This iteam already exist");
            }
          }
          if (isIteamExist == false && widget.myLocations != null) {
            widget.myMenuIteamList!.menuIteamList![i].iteams!.add(
                MenuIteamModel(
                    id: Uuid().v4().toString(),
                    iteamName: iteamName,
                    iteamImagePath: imagePath,
                    description: description,
                    discount: double.tryParse(discountontroller.text) ?? 0.0,
                    price: price));
            FirebaseFirestore.instance
                .collection("Menus")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .set(widget.myMenuIteamList!.toMap())
                .then((value) => Navigator.pop(context));
          }
        }
      }
    }
    if (isCatagoryExist == false) {
      widget.myMenuIteamList ??= MenuModelFirebaseSetData(menuIteamList: []);
      widget.myMenuIteamList!.menuIteamList!
          .add(MenuModel(menuName: catagory, iteams: [
        MenuIteamModel(
            id: Uuid().v4().toString(),
            iteamName: iteamName,
            additionalImages: additionalImages,
            iteamImagePath: imagePath,
            discount: double.tryParse(discountontroller.text) ?? 0.0,
            description: description,
            price: price)
      ]));
      FirebaseFirestore.instance
          .collection("Menus")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(widget.myMenuIteamList!.toMap())
          .then((value) {
        Navigator.pop(context);
        setState(() {});
      });
    }
    Navigator.pop(context);
  }
}
