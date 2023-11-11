import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialImage;
  }

  void _takeImage() async {
    final imagePicker = ImagePicker();

    final image = await imagePicker.pickImage(
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
          child: Container(
            width: SizeConfig.blockSizeVertical! * 13,
            height: SizeConfig.blockSizeVertical! * 13,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: _selectedImage != null
                      ? DecorationImage(
                          fit: BoxFit.fill,
                          image: FileImage(_selectedImage!),
                        )
                      : null,
                ),
                child: _selectedImage == null
                    ? CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 188, 188, 188),
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
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
