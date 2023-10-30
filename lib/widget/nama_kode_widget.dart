import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/widget/size_config.dart';

class NamaKodeWidget extends StatelessWidget {
  const NamaKodeWidget(
      {super.key,
      required this.onSaved,
      required this.textStyle,
      required this.labelText,
      required this.initialValue});

  final void Function(String value) onSaved;
  final TextStyle textStyle;
  final String labelText;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              height: SizeConfig.blockSizeVertical! * 12,
              margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical! * 2,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFC9C9C9),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Container(
                margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical! * 2,
                    left: SizeConfig.blockSizeHorizontal! * 8),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim() == '' ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return 'Must be between 1 and 50 characters';
                    }
                    return null;
                  },
                  initialValue: initialValue,
                  maxLength: 50,
                  minLines: 1,
                  maxLines: 3,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 2),
                    border: InputBorder.none,
                    labelText: labelText,
                    counterText: '',
                    errorStyle: GoogleFonts.poppins(color: Colors.red),
                    labelStyle: textStyle,
                  ),
                  onSaved: (newValue) {
                    onSaved(newValue!);
                  },
                  style: textStyle.copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
