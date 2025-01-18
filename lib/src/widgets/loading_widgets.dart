import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/src/res/app_colors.dart';

class LoadingWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS
          ? const CupertinoActivityIndicator(
              color: AppColors.primaryColor,
            )
          : const CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
    );
  }

}