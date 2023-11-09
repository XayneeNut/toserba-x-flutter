import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/widget/s/size_config.dart';

class AddClearWidget extends StatelessWidget {
  const AddClearWidget(
      {super.key,
      required this.onPressed,
      required this.backgroundColor,
      required this.labelText});

  final void Function() onPressed;
  final String labelText;
  final MaterialStateProperty<Color> backgroundColor;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.blockSizeVertical! * 8,
      width: SizeConfig.blockSizeVertical! * 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: backgroundColor,
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(SizeConfig.blockSizeVertical! * 2),
            ),
          ),
        ),
        child: Text(
          labelText,
          style: GoogleFonts.poppins(
              fontSize: SizeConfig.blockSizeVertical! * 2.44,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
