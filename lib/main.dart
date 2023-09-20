import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/router/app_router.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

//void main() => runApp(const ProviderScope(child: MyApp()));
void main() async {
  await dotenv.load(fileName: "lib/.env");
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  //const ProviderScope(child: MyApp());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es', 'EN');
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTema.modoLuz,
      debugShowCheckedModeBanner: false,
      title: 'Innova ITO',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [Locale('en', "EN"), Locale('es', "ES")],
      locale: const Locale('es', 'ES'),
    );
  }
}
