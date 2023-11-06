import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/widget/s/size_config.dart';

class DrawerActions extends StatelessWidget {
  final Function() onLogout;
  final Function() onAdmin;
  final Function() onPesanan;

  const DrawerActions({
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
              Icons.logout,
              color: Colors.black,
              size: SizeConfig.blockSizeVertical! * 4,
            ),
            label: Text(
              'log out',
              style: GoogleFonts.rubik(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeVertical! * 3,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical! * 1),
          TextButton.icon(
            onPressed: onAdmin,
            icon: Icon(
              Icons.people,
              color: Colors.black,
              size: SizeConfig.blockSizeVertical! * 4,
            ),
            label: Text(
              'admin',
              style: GoogleFonts.rubik(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeVertical! * 3,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical! * 1),
          TextButton.icon(
            onPressed: onPesanan,
            icon: Icon(
              Icons.library_books,
              color: Colors.black,
              size: SizeConfig.blockSizeVertical! * 4,
            ),
            label: Text(
              'pesanan',
              style: GoogleFonts.rubik(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeVertical! * 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
