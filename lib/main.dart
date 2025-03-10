import 'package:eventplanningapp/eventManageScreens/add_event_screen.dart';
import 'package:eventplanningapp/auth/login/login_screen.dart';
import 'package:eventplanningapp/auth/signup/register_screen.dart';
import 'package:eventplanningapp/eventManageScreens/edit_event_screen.dart';
import 'package:eventplanningapp/eventManageScreens/event_details_screen.dart';
import 'package:eventplanningapp/homescreen.dart';
import 'package:eventplanningapp/providers/apptheme_provider.dart';
import 'package:eventplanningapp/providers/event_list_provider.dart';
import 'package:eventplanningapp/providers/language_provider.dart';
import 'package:eventplanningapp/providers/user_provider.dart';
import 'package:eventplanningapp/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:eventplanningapp/utils/apptheme.dart';
import 'package:eventplanningapp/onboarding/onboarding.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.disableNetwork();
  await MyServices.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AppthemeProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => EventListProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<AppthemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: Apptheme.darkTheme,
      theme: Apptheme.lightTheme,
      themeMode: themeProvider.apptheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.appLanguage),
      routes: {
        HomeScreen.routename: (context) => const HomeScreen(),
        OnBoarding.routename: (context) => OnBoarding(),
        LoginScreen.routename: (context) => LoginScreen(),
        RegisterScreen.routename: (context) => RegisterScreen(),
        AddEventScreen.routename: (context) => AddEventScreen(),
        EventDetailsScreen.routename: (context) => EventDetailsScreen(),
        EditEventScreen.routename: (context) => EditEventScreen(),
      },
      initialRoute: MyServices.getString("step") == "1"
          ? LoginScreen.routename
          : OnBoarding.routename,
    );
  }
}
