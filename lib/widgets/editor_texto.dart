import 'package:flutter/material.dart';

import 'package:flutter_quill/flutter_quill.dart';

class EditorTexto extends StatelessWidget {
  const EditorTexto({super.key});

  @override
  Widget build(BuildContext context) {
    QuillController _controller = QuillController.basic();
    return SafeArea(
      child: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Form(
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black38),
                ),
                QuillToolbar.basic(
                  controller: _controller,
                  //showAlignmentButtons: false,
                  multiRowsDisplay: false,
                  showColorButton: true,
                  //color: Colors.red,

                  sectionDividerColor: Colors.red,
                  sectionDividerSpace: 2.0,
                  showDividers: true, showBackgroundColorButton: true,
                ),
                Container(
                  child: QuillEditor.basic(
                    controller: _controller,
                    readOnly:
                        false, //showAlignmentButtons: false , // true for view only mode
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
