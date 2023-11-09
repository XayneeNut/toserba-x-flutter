import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              labelText: labelText,
              counterText: '',
              errorStyle: GoogleFonts.poppins(color: Colors.red),
              labelStyle: textStyle,
            ),
            onSaved: (newValue) {
              onSaved(newValue!);
            },
            style:
                textStyle.copyWith(color: const Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ],
    );
  }
}
