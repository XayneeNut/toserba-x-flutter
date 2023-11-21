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
    return SizedBox(
      height: SizeConfig.blockSizeVertical! * 28,
      child: UserAccountsDrawerHeader(
        currentAccountPictureSize: Size(
          SizeConfig.blockSizeVertical! * 8,
          SizeConfig.blockSizeVertical! * 8,
        ),
        currentAccountPicture: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: SizeConfig.blockSizeVertical! * 1.2,
                color: const Color.fromARGB(255, 255, 255, 255),
              )
            ],
          ),
          child: const CircleAvatar(
            backgroundColor: Colors.white,
          ),
        ),
        otherAccountsPictures: const [
          Icon(
            Icons.more_horiz,
            color: Colors.white,
          )
        ],
        accountName: Text(
          adminUsername,
          style: GoogleFonts.poppins(
            color: Colors.white,
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
                color: Colors.white,
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
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.blockSizeVertical! * 1.55,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: SizeConfig.blockSizeVertical! * 1.8,
              color: Color.fromARGB(255, 76, 45, 126),
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(SizeConfig.blockSizeVertical! * 3),
          ),
          color: Color.fromARGB(255, 41, 36, 69),
        ),
      ),
    );
  }
}
