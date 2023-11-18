import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/widget/s/size_config.dart';

class UserDrawerActionWidgets extends StatelessWidget {
  final Function() onLogout;
  final Function() onAdmin;
  final Function() onPesanan;

  const UserDrawerActionWidgets({
    super.key,
    required this.onLogout,
    required this.onAdmin,
    required this.onPesanan,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.only(left: SizeConfig.blockSizeVertical! * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 2,
          ),
          TextButton.icon(
            onPressed: onLogout,
            icon: Icon(
              CupertinoIcons.home,
              color: const Color.fromARGB(255, 63, 63, 63),
              size: SizeConfig.blockSizeVertical! * 3.7,
            ),
            label: Text(
              'Home',
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeVertical! * 2.7,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical! * 1),
          TextButton.icon(
            onPressed: onAdmin,
            icon: Icon(
              CupertinoIcons.person_circle,
              color: const Color.fromARGB(255, 63, 63, 63),
              size: SizeConfig.blockSizeVertical! * 4,
            ),
            label: Text(
              'Account',
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeVertical! * 2.7,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical! * 1),
          TextButton.icon(
            onPressed: onPesanan,
            icon: Icon(
              CupertinoIcons.bookmark,
              color: const Color.fromARGB(255, 63, 63, 63),
              size: SizeConfig.blockSizeVertical! * 4,
            ),
            label: Text(
              'Report ',
              style: GoogleFonts.rubik(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeVertical! * 2.7,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical! * 1),
          TextButton.icon(
            onPressed: onPesanan,
            icon: Icon(
              CupertinoIcons.settings,
              color: const Color.fromARGB(255, 63, 63, 63),
              size: SizeConfig.blockSizeVertical! * 4,
            ),
            label: Text(
              'Settings',
              style: GoogleFonts.rubik(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeVertical! * 2.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
