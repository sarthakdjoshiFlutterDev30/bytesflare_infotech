import 'package:bytesflare_infotech/View/Service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AppThemeData.dart';
import 'ThemeProvider.dart';
import 'View/About.dart';
import 'View/Contactus.dart';
import 'View/Info.dart';
import 'View/PrivacyPolicyPage.dart';
import 'View/Welcome.dart';
import 'View/career.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Bytes Flare Infotech',
          debugShowCheckedModeBanner: false,
          theme: AppThemeData.lightTheme,
          darkTheme: AppThemeData.darkTheme,
          themeMode: themeProvider.themeMode,
          initialRoute: "/welcome",
          routes: {
            "/welcome": (context) => const WelcomePage(),
            "/info": (context) => const InfoPage(),
            "/service": (context) => ServicesPage(),
            "/About": (context) => const AboutUsPage(),
            "/contactus": (context) => const ContactUsPage(),
            "/carriers": (context) => const CareerFormPage(),
            "/privacy-policy": (context) => const PrivacyPolicyPage(),
          },
        );
      },
    );
  }
}
