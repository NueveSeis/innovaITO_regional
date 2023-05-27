import 'package:flutter/material.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:html_editor_enhanced/utils/callbacks.dart';
import 'package:html_editor_enhanced/utils/file_upload_model.dart';
import 'package:html_editor_enhanced/utils/options.dart';
import 'package:html_editor_enhanced/utils/plugins.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_fake.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';
import 'package:html_editor_enhanced/utils/shims/flutter_inappwebview_fake.dart';
import 'package:html_editor_enhanced/utils/toolbar.dart';
import 'package:html_editor_enhanced/utils/utils.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
//import 'package:html_editor/html_editor.dart';

class InicioScreen extends StatefulWidget {
  static const String name = 'inicio';
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  GlobalKey<FlutterSummernoteState> _keyEditor = GlobalKey();

  String result = '';
  @override
  Widget build(BuildContext context) {
    //HtmlEditorController controller = HtmlEditorController();

    HtmlEditorController controller = HtmlEditorController();

    return Scaffold(
      body: Fondo(
          fontSize: 20,
          tituloPantalla: 'prubea',
          widget: Column(
            children: [
              IconButton(
                icon: Icon(Icons.save),
                onPressed: () async {
                  // final value = (await _keyEditor.currentState?.getText());
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //   duration: Duration(seconds: 5),
                  //   content: Text(value ?? '-'),
                  // ));
                  //String? simon = await _keyEditor.currentState?.getText();

                  print(await controller.getText());
                },
              ),
              // FlutterSummernote(
              //   showBottomToolbar: true,
              //   hint: 'Your text here...',
              //   key: _keyEditor,
              //   hasAttachment: true,
              //   customToolbar: """
              //    [
              //      ['style', ['bold', 'italic', 'underline', 'clear']],
              //      ['font', ['strikethrough', 'superscript', 'subscript']],
              //      ['insert', ['link', 'table', 'hr']]
              //    ]
              //  """,
              // ),
              HtmlEditor(
                controller: controller, //required
                htmlEditorOptions: HtmlEditorOptions(
                  characterLimit: 10,
                  spellCheck: true,
                  shouldEnsureVisible: true,
                  hint: "Your text here...",
                  //initalText: "text content initial, if any",
                ),
                otherOptions: OtherOptions(
                  height: 400,
                ),
              ),
            ],
          )),
    );
  }
}
