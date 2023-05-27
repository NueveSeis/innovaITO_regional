import 'package:flutter/material.dart';
import 'package:innova_ito/widgets/widgets.dart';
//import 'package:html_editor/html_editor.dart';

class InicioScreen extends StatelessWidget {
  static const String name = 'inicio';
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //HtmlEditorController controller = HtmlEditorController();

    return Scaffold(
      body: Fondo(
          fontSize: 20,
          tituloPantalla: 'prubea',
          widget: Column(
            children: [
              // HtmlEditor(
              //   controller: controller, //required
              //   htmlEditorOptions: HtmlEditorOptions(
              //     hint: "Your text here...",
              //     //initalText: "text content initial, if any",
              //   ),
              //   otherOptions: OtherOptions(
              //     height: 400,
              //   ),
              // )
            ],
          )),
    );
  }
}
