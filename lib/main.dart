import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia_royale_2/screens/splash_screen.dart';
import 'firebase_options.dart';
import 'utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: GetMaterialApp(
        title: 'Trivia Royale 2',
        theme: ThemeData(
          textTheme: GoogleFonts.nunitoTextTheme(),
          fontFamily: GoogleFonts.nunito().fontFamily,
          primaryColor: Colors.white,
          colorScheme: const ColorScheme.light(
            primary: Colors.white,
            secondary: AppColors.secondaryColor,
          ),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
