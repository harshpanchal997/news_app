import 'package:app/utils/text_styles.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

String appName = "News";


/*
  * -- Dimen
  * */
double infiniteSize = double.infinity;


/*
  * -- Date Time Formate
  * */
String dateUTC = "yyyy-MM-dd'T'HH:mm:ssZ";
String str12Hr = "hh:mm a";
String str24Hr = "hh:mm:ss";

///Hive Object
var userBox = Hive.box('userBox');

///Local Data
const String KEY_LOCAL_NEWS = "key_local_news";
String? getLocalNews() => (userBox.get(KEY_LOCAL_NEWS));

///App Language
String langEN = "en";

/*
  * ------------------------ Colors ----------------------------------------- *
  * */
MaterialColor colorPrimary = MaterialColor(0xff007FFF, colorSwathes);

Map<int, Color> colorSwathes = {
  50: const Color.fromRGBO(0, 127, 255, .1),
  100: const Color.fromRGBO(0, 127, 255, .2),
  200: const Color.fromRGBO(0, 127, 255, .3),
  300: const Color.fromRGBO(0, 127, 255, .4),
  400: const Color.fromRGBO(0, 127, 255, .5),
  500: const Color.fromRGBO(0, 127, 255, .6),
  600: const Color.fromRGBO(0, 127, 255, .7),
  700: const Color.fromRGBO(0, 127, 255, .8),
  800: const Color.fromRGBO(0, 127, 255, .9),
  900: const Color.fromRGBO(0, 127, 255, 1),
};

Color clrTheme = const Color(0xff007FFF);
Color clrBlack = const Color(0xff000000);
Color clrWhite = const Color(0xffFFFFFF);
Color clrBGLightGrey = const Color(0xffF5F6F9);
Color clrTextGrey = const Color(0xffECECEC);
Color clrTextDarkGrey = const Color(0xff767676);
Color clrTextDark = const Color(0xffDFDFDF);
Color clrGreyShadow = const Color(0xFFDFDFDF);
Color clrDarkRed = const Color(0xffFF3B3B);

/*
  * ------------------------ FontStyle ----------------------------------------- *
  * */
String fontFamily = "Circular-Std";

FontWeight fwThin = FontWeight.w100;
FontWeight fwExtraLight = FontWeight.w200;
FontWeight fwLight = FontWeight.w300;
FontWeight fwRegular = FontWeight.w400;
FontWeight fwMedium = FontWeight.w500;
FontWeight fwSemiBold = FontWeight.w600;
FontWeight fwBold = FontWeight.w700;
FontWeight fwExtraBold = FontWeight.w800;


/*
  * ------------------------ Text Style ----------------------------------------- *
  * */

TextStyle textStyle({int fontSize = 16, FontWeight? fontWeight, Color? textColor}) {
  return TextStyle(
    fontSize: fontSize.sp,
    fontWeight: fontWeight ?? fwMedium,
    color: textColor ?? clrBlack,
    fontFamily: fontFamily,
  );
}

///Save Local Data
saveLocalData(String key, value) {
  userBox.put(key, value);
  print("Saved new data into your local Key - $key Value - ${userBox.get(key)}");
}

///Common Methods
showMessageDialog(BuildContext context, String? message, Function()? didDismiss) {
  return showDialog(barrierDismissible: false, context: context, builder: (context) => Dialog(
    backgroundColor: clrWhite,
    insetPadding: EdgeInsets.all(16.sp),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtil().setWidth(18))),
    child: Stack(
      overflow: Overflow.visible,
      alignment: Alignment.center,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: ScreenUtil().setHeight(180),
          child:
          Padding(
            padding: EdgeInsetsDirectional.only(start: 25.w,end: 25.w,top: 23.h,bottom :15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: Text(
                    message ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyles.txtMedium16,
                  ),
                ),
                SizedBox(height: 25.h,),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    if(didDismiss != null){
                      Future.delayed(const Duration(milliseconds: 80), () {
                        didDismiss();
                      });
                    }
                  },
                  child: Container(
                    height: 50.h,
                    alignment: Alignment.center,
                    child: Text(
                      "Ok",
                      style: TextStyles.txtSemiBold14.copyWith(color: clrTheme),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  )
  );
}

Future<bool> checkInternetConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult != ConnectivityResult.none;
}