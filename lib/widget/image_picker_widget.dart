import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toserba/widget/size_config.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key, required this.pickedImage});

  final void Function(File image) pickedImage;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _selectedImage;

  void _takeImage() async {
    final imagePicker = ImagePicker();

    final image = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 150);

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
    var image =
        "https://img.freepik.com/free-vector/curious-analyst-investigating-question-mark-with-magnifier_74855-20083.jpg?w=900&t=st=1698211843~exp=1698212443~hmac=329b9060ff1703e6add157137e390bca4884e6c2139fbe5039c47d71589a079f";
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.blockSizeVertical! * 25,
          width: SizeConfig.blockSizeVertical! * 25,
          child: CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(image),
            foregroundImage:
                _selectedImage != null ? FileImage(_selectedImage!) : null,
          ),
        ),
        TextButton.icon(
          onPressed: _takeImage,
          icon: const Icon(
            Icons.camera,
            color: Colors.black,
          ),
          label: Text(
            'take picture',
            style: GoogleFonts.poppins(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
