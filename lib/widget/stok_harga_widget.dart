import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/widget/size_config.dart';

class StokHargaWidget extends StatelessWidget {
  const StokHargaWidget(
      {super.key,
      required this.onSaved,
      required this.textStyle,
      required this.labelText,
      required this.initialValue});

  final void Function(int value) onSaved;
  final String labelText;
  final TextStyle textStyle;
  final int initialValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFC9C9C9),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Container(
          margin: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical! * 0.1,
              left: SizeConfig.blockSizeHorizontal! * 7),
          child: TextFormField(
            initialValue: initialValue.toString(),
            maxLength: 50,
            minLines: 1,
            maxLines: 3,
            validator: (value) {
              if (value == null ||
                  value.trim().length == 1 ||
                  value.trim().length > 50 ||
                  value.trim().isEmpty) {
                return 'cannot be empty';
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 1),
              border: InputBorder.none,
              labelText: labelText,
              counterText: '',
              labelStyle: textStyle,
              errorStyle: GoogleFonts.poppins(color: Colors.red),
            ),
            onSaved: (newValue) {
              onSaved(int.parse(newValue!));
            },
            style: textStyle.copyWith(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
