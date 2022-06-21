import 'package:app/utils/text_styles.dart';
import 'package:app/utils/theme_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? titleWidget;
  final Function()? onPress;
  final bool isLeading;
  final bool isDrawer;
  final bool isAppBgColor;
  final List<Widget>? action;
  final AppBar appBar;

  CustomAppBar(
      {required this.title,
        this.titleWidget,
        this.onPress,
        required this.appBar,
        this.isLeading = true,
        this.isDrawer = false,
        this.isAppBgColor = false,
        this.action,
      });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      centerTitle: true,
      // brightness: Platform.isIOS ? Brightness.light : null,
      leading: isLeading == true
          ? IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20.h, color: clrTheme,),
          onPressed: onPress ?? () {
            Navigator.pop(context);
          })
          : isDrawer == true
          ? GestureDetector(
        onTap: () {

        },
        child: Icon(Icons.menu_rounded, size: 34.h,),)
          : Container(),
      elevation: 0,
      actions: action,
      backgroundColor: clrWhite,
      title: titleWidget ?? Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyles.txtSemiBold18.copyWith(color: clrTheme),
        // style: TextStyle(
        //     fontSize: 20.sp,
        //     color: clrTheme,
        //     fontWeight: fwSemiBold
        // ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
