import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'iti_project/home_iti.dart';
import 'iti_project/onbaord_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
bool show = true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: FirebaseOptions(
      appId: '1:679719447941:android:1cc9eeca8ba803a36868ec',
      apiKey: 'AIzaSyDI2DpRYY5aBYKOyYZ9DlTRGakciqT4D8Y',
      projectId: 'mariefa-8f5f6',
      messagingSenderId: '',
     ));
  final prefs = await SharedPreferences.getInstance();
  show = prefs.getBool('ON_BOARDING') ?? true;
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
   const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'),
        // // ('ar', 'AE') English, no country code
      ],
      title: 'Market',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
      // IntroScreen(),
      show ? IntroScreen() : Home_ITI(),
      // SplashScreen(),
      // RegisterScreen(),
      // routes: {
      //   "event" : (context) => EventsScreen(),
      //   QuizScreenView.quizRoute :(context) => QuizScreenView(),
      //   HomeScreen.homeRoute :(context) => HomeScreen(),
      //  },
    );
  }
}