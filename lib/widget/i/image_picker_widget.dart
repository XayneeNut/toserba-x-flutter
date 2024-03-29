import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toserba/controller/apps%20controller/apps_controller.dart';
import 'package:toserba/widget/s/size_config.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({
    Key? key,
    required this.pickedImage,
    required this.initialImage,
    required this.isUser,
  }) : super(key: key);

  final void Function(File image) pickedImage;
  final File? initialImage;
  final bool isUser;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  late File? _selectedImage;
  AppsController appsController = AppsController();

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialImage;
  }

  void _takeImage() async {
    final imagePicker = ImagePicker();
    var image = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (image == null) {
      return;
    }

    setState(() {
      _selectedImage = File(image.path);
    });

    widget.pickedImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.blockSizeVertical! * 2,
        ),
        GestureDetector(
          onTap: _takeImage,
          child: SizedBox(
            width: Get.width * 0.3,
            height: Get.width * 0.3,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: _selectedImage != null
                      ? DecorationImage(
                          fit: BoxFit.fill,
                          image: FileImage(_selectedImage!),
                        )
                      : null,
                ),
                child: _selectedImage != null
                    ? null
                    : CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: widget.isUser == false
                            ? Icon(
                                Icons.photo,
                                size: SizeConfig.blockSizeVertical! * 8.7,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.person,
                                size: SizeConfig.blockSizeVertical! * 8.7,
                                color: Colors.black,
                              ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
