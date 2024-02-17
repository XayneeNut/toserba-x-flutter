import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toserba/widget/s/size_config.dart';

class UpdateImageWidget extends StatefulWidget {
  const UpdateImageWidget({
    Key? key,
    required this.pickedImage,
    required this.initialImage,
  }) : super(key: key);

  final void Function(String image) pickedImage;
  final File? initialImage;

  @override
  State<UpdateImageWidget> createState() => _UpdateImageWidgetState();
}

class _UpdateImageWidgetState extends State<UpdateImageWidget> {
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

    widget.pickedImage(_selectedImage!.path);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _takeImage,
          child: Container(
            width: SizeConfig.blockSizeVertical! * 10,
            height: SizeConfig.blockSizeVertical! * 10,
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
                    ? const Icon(
                        Icons.add_a_photo_outlined,
                        size: 48,
                        color: Colors.black,
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
