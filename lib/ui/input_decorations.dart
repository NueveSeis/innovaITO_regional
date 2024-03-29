import 'package:flutter/material.dart';
import 'package:innova_ito/theme/app_tema.dart';

class InputDecorations {
  static InputDecoration accesoInputDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(217, 217, 217, 1),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(217, 217, 217, 1),
            ),
            borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromRGBO(250, 122, 30, 1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(color: Color.fromRGBO(46, 45, 47, 0.8)),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: const Color.fromRGBO(28, 27, 31, 0.9))
            : null);
  }

  static InputDecoration registroLiderDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
        filled: true,
        hintStyle: TextStyle(
            overflow: TextOverflow.visible,
            fontWeight: FontWeight.normal,
            color: AppTema.bluegrey700),
        labelStyle: TextStyle(
          overflow: TextOverflow.visible,
          color: AppTema.bluegrey700,
          fontWeight: FontWeight.bold,
        ),
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: const Color.fromRGBO(28, 27, 31, 0.9))
            : null);
  }
}
