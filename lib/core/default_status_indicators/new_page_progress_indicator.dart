import 'package:flutter/material.dart';
import 'package:genix/core/utils/colors.dart';

class NewPageProgressIndicator extends StatelessWidget {
  const NewPageProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      // FooterTile(
      //       child:
      Center(
          child: CircularProgressIndicator(
        color: AppColors.kPrimaryColor,
      ));
  //);
}
