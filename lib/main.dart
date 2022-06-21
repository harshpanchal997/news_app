import 'package:app/provider/news_detail_provider.dart';
import 'package:app/provider/news_list_provider.dart';
import 'package:app/ui/splash_screen.dart';
import 'package:app/utils/theme_const.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox('userBox');

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Color for Android
      statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsListProvider()),
        ChangeNotifierProvider(create: (context) => NewsDetailProvider()),
      ],
      child: const MyApp(),
    ),
  );

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, widget) {
        return MaterialApp(
          title: appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: ColorScheme.light(
                  primary: clrTheme
              ),
              scaffoldBackgroundColor: clrBGLightGrey,
              fontFamily: fontFamily,
              primarySwatch: colorPrimary,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              // appBarTheme: AppBarTheme(
              //   color: clrWhite,
              //   elevation: 0,
              // )
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
