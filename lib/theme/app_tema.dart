import 'package:flutter/material.dart';

class AppTema {
  static const Color primario = Color.fromRGBO(250, 122, 30, 1); //Ecstaszy
  static const Color pizazz = Color.fromRGBO(255, 149, 0, 1); //Pizazz
  static const Color balticSea = Color(0xFF2E2D2F); //Baltic Sea
  static const Color emperor = Color(0xFF4E4B4D); //Emperor
  static const Color indigo50 = Color(0xFFE4EBF5); //Indigo50
  static const Color grey100 = Color(0xFFF4F8FB); //Grey100
  static const Color bluegrey700 = Color(0xFF4B597B);
  static const Color redA400 = Color(0xFFEF003B);
  static const Color greenS400 = Color(0xFF66BB6A);

  static final ThemeData modoOscuro = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: balticSea,
  );

  static final ThemeData modoLuz = ThemeData.light().copyWith(
    scaffoldBackgroundColor: primario,
    // primaryColor: AppTema.primario,
    // primaryColorLight: AppTema.primario,

    //inputs de los forms y tambien drops
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: grey100,
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: bluegrey700,
            width: 0.3,
          ),
          borderRadius: BorderRadius.circular(10.0)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: primario,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      hintStyle:
          const TextStyle(color: bluegrey700, fontWeight: FontWeight.normal),
      labelStyle: const TextStyle(color: bluegrey700),
    ),

    //elevatedButton

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      primary: pizazz,
      elevation: 15,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    )),

    //ListTile
    listTileTheme: const ListTileThemeData(
      iconColor: AppTema.bluegrey700,
      textColor: AppTema.bluegrey700,
    ),

    //
    // datePickerTheme: const DatePickerThemeData(
    //   headerBackgroundColor: AppTema.primario,
    // ),

    //
  );
}
