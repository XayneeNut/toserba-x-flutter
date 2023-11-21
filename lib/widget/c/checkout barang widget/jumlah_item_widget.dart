import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JumlahItemWidget extends StatefulWidget {
  const JumlahItemWidget(
      {super.key,
      required this.onAddPressed,
      required this.onMinusPressed,
      required this.jumlahItem});

  final VoidCallback onAddPressed;
  final VoidCallback onMinusPressed;
  final int jumlahItem;

  @override
  State<JumlahItemWidget> createState() => _JumlahItemWidgetState();
}

class _JumlahItemWidgetState extends State<JumlahItemWidget> {
  var localJumlahItem = 0;

  @override
  void initState() {
    super.initState();
    localJumlahItem = widget.jumlahItem;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              localJumlahItem++;
            });
            widget.onAddPressed();
          },
          icon: Icon(
            CupertinoIcons.add,
            size: Get.width * 0.045,
          ),
        ),
        Text('$localJumlahItem'),
        IconButton(
          onPressed: () {
            setState(
              () {
                if (localJumlahItem > 1) {
                  localJumlahItem--;
                }
              },
            );
            widget.onMinusPressed();
          },
          icon: Icon(
            CupertinoIcons.minus,
            size: Get.width * 0.045,
          ),
        ),
      ],
    );
  }
}
