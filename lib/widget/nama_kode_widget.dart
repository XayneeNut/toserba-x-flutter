import 'package:flutter/material.dart';
import 'package:toserba/widget/size_config.dart';

// ignore: must_be_immutable
class NamaKodeWidget extends StatelessWidget {
  const NamaKodeWidget(
      {super.key,
      required this.onSaved,
      required this.textStyle,
      required this.labelText});

  final void Function(String value) onSaved;
  final TextStyle textStyle;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
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
                maxLength: 50,
                minLines: 1,
                maxLines: 3,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 2),
                    border: InputBorder.none,
                    labelText: labelText,
                    counterText: '',
                    labelStyle: textStyle),
                onSaved: (newValue) {
                  onSaved(newValue!);
                },
                style: textStyle.copyWith(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
