import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_test/generated/l10n.dart';
import 'package:ism_test/presentation/home/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ism_test/presentation/themes.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: initialLightTheme,
      dark: initialDarkTheme,
      initial: AdaptiveThemeMode.light,
      builder: (light, dark) => GetMaterialApp(
        theme: light,
        darkTheme: dark,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
