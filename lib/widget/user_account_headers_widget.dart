import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/widget/s/size_config.dart';

class UserAccountHeader extends StatelessWidget {
  final String adminUsername;
  final String adminAccountId;
  final String adminEmail;

  const UserAccountHeader({
    super.key,
    required this.adminUsername,
    required this.adminAccountId,
    required this.adminEmail,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.blockSizeVertical! * 28,
      child: UserAccountsDrawerHeader(
        currentAccountPictureSize: Size(
          SizeConfig.blockSizeVertical! * 8,
          SizeConfig.blockSizeVertical! * 8,
        ),
        currentAccountPicture: const CircleAvatar(
          backgroundColor: Colors.black,
        ),
        otherAccountsPictures: const [Icon(Icons.more_horiz)],
        accountName: Text(
          adminUsername,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: SizeConfig.blockSizeVertical! * 3,
          ),
        ),
        accountEmail: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              adminAccountId,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.blockSizeVertical! * 1.4,
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 0.5,
            ),
            Text(
              adminEmail,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.blockSizeVertical! * 1.55,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: SizeConfig.blockSizeVertical! * 2,
              color: Colors.grey,
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(SizeConfig.blockSizeVertical! * 3),
          ),
          color: Color.fromARGB(255, 234, 233, 233),
        ),
      ),
    );
  }
}
