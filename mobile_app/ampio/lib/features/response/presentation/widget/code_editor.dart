import 'package:ampio/features/response/presentation/bloc/response_add_bloc.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:ampio/features/response/presentation/bloc/response_bloc.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:highlight/languages/python.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/darcula.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class CodeEditor extends StatefulWidget {
  const CodeEditor({Key? key}) : super(key: key);

  @override
  _CodeEditorState createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> {
  CodeController? _codeController;
  Map<String, TextStyle>? theme = monokaiSublimeTheme;
 // Uint8List _imageFile;


  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final source = "void main() {\n    print(\"Hello, world!\");\n}";
    // Instantiate the CodeController
    _codeController = CodeController(
      text: source,
      language: python,
    );
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Code Editor"),
          backgroundColor: Colors.teal,
          actions: [
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: Colors.blueGrey,
                elevation: 20,
                icon: const Icon(Icons.color_lens_outlined),
                iconEnabledColor: Colors.white,
                items: <String>['Atom', 'Monokai-sublime', 'VS', 'Darcula']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    onTap: () {
                      setState(() {
                        if (value == "Monokai-sublime") {
                          theme = monokaiSublimeTheme;
                        } else if (value == "Atom") {
                          theme = atomOneDarkTheme;
                        } else if (value == "VS") {
                          theme = vsTheme;
                        } else if (value == "Darcula") {
                          theme = darculaTheme;
                        }
                      });
                    },
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: CodeField(
              controller: _codeController!,
              textStyle: const TextStyle(fontFamily: 'SourceCode', fontSize: 20),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          onPressed: () async {
            final directory = (await getApplicationDocumentsDirectory ()).path; //from path_provide package
            String fileName = 'screenshot_test' + DateTime.now().toString();
            final path = '$directory';
            print(path);
            final result = await screenshotController.captureAndSave(
                path ,
                fileName:fileName
            );
           context.read<ResponseBloc>().add(
              ResponseAddEvent(
                content: 'Hey via code editor 8',
                filePath: result
              ),
            );
           context.pop();
          },
          child: const Icon(
            Icons.send,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
