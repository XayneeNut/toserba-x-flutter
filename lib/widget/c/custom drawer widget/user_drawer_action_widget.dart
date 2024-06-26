import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toserba/widget/s/size_config.dart';

class UserDrawerActionWidgets extends StatelessWidget {
  final Function() onHome;
  final Function() onAccount;
  final Function() onOrders;

  const UserDrawerActionWidgets({
    super.key,
    required this.onHome,
    required this.onAccount,
    required this.onOrders,
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
            onPressed: onHome,
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
            onPressed: onAccount,
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
            onPressed: onOrders,
            icon: Icon(
              CupertinoIcons.shopping_cart,
              color: const Color.fromARGB(255, 63, 63, 63),
              size: SizeConfig.blockSizeVertical! * 4,
            ),
            label: Text(
              'Orders',
              style: GoogleFonts.rubik(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeVertical! * 2.7,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical! * 1),
          
        ],
      ),
    );
  }
}
