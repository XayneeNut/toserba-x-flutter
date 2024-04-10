import 'package:flutter/material.dart';
import 'package:toserba/widget/s/size_config.dart';

// ignore: must_be_immutable
class CustomBottomNavBarWidget extends StatefulWidget {
  CustomBottomNavBarWidget(
      {super.key,
      required this.bottomIconColor,
      required this.pressedIconColor,
      required this.selectedPageIndex,
      required this.onPageSelected});

  final Color bottomIconColor;
  final Color pressedIconColor;
  int? selectedPageIndex;
  final void Function(int) onPageSelected;

  @override
  State<CustomBottomNavBarWidget> createState() =>
      _CustomBottomNavBarWidgetState();
}

class _CustomBottomNavBarWidgetState extends State<CustomBottomNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeVertical! * 2,
          right: SizeConfig.blockSizeVertical! * 2),
      height: SizeConfig.blockSizeVertical! * 8,
      margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical! * 2,
          left: SizeConfig.blockSizeVertical! * 5,
          bottom: SizeConfig.blockSizeVertical! * 5,
          right: SizeConfig.blockSizeVertical! * 5),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              widget.onPageSelected(1);
            },
            icon: widget.selectedPageIndex == 1
                ? Icon(
                    Icons.home,
                    color: widget.pressedIconColor,
                  )
                : Icon(
                    Icons.home,
                    color: widget.bottomIconColor,
                  ),
          ),
          IconButton(
            onPressed: () {
              widget.onPageSelected(2);
            },
            icon: widget.selectedPageIndex == 2
                ? Icon(
                    Icons.create,
                    color: widget.pressedIconColor,
                  )
                : Icon(
                    Icons.create,
                    color: widget.bottomIconColor,
                  ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.circle,
              color: widget.bottomIconColor,
            ),
          ),
        ],
      ),
    );
  }
}
