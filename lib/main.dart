import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:online_coach_supabase/views/shared/no_internet.dart';
import 'package:online_coach_supabase/shared/shared_preferences/shared_preferences.dart';
import 'package:online_coach_supabase/views/admin/admin_home_page.dart';
import 'package:online_coach_supabase/views/authentication/login.dart';
import 'package:online_coach_supabase/views/user/user_home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://fxnkbcnmlsvvnmmpkeif.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ4bmtiY25tbHN2dm5tbXBrZWlmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY3MjM1MDYsImV4cCI6MjA1MjI5OTUwNn0.Z5DTSMD4Z-4rcMQ3qwp0nsk3CbGCYtlYl6a20U0WfaE',
  );
  await SharedPrefs.init();
  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) async {
    String? role = await SharedPrefs.getData(key: "role");
    if (role == "user") {
      runApp(const MyApp(
        start: UserHomePage(),
      ));
    } else if (role == "admin") {
      runApp(MyApp(start: AdminHomePage()));
    } else {
      runApp(MyApp(start: Login()));
    }
  });
}

class MyApp extends StatefulWidget {
  final Widget start;

  const MyApp({super.key, required this.start});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isConnected = false;

  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();

    _streamSubscription = InternetConnection().onStatusChange.listen((event) {
      switch (event) {
        case InternetStatus.connected:
          setState(() {
            isConnected = true;
          });
          break;
        case InternetStatus.disconnected:
          setState(() {
            isConnected = false;
          });
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.grey[900],
              elevation: 0,
            ),
            // background color for app
            scaffoldBackgroundColor: Colors.grey[900],
            progressIndicatorTheme:
                ProgressIndicatorThemeData(color: Colors.white),
            // font family for the app
            textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
              bodyMedium: GoogleFonts.alkatra(
                  textStyle: textTheme.bodyMedium, color: Colors.white),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: isConnected ? widget.start : NoInternetConnection()),
    );
  }
}
