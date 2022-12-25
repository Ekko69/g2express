import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class CustomHtmlInput extends StatefulWidget {
  const CustomHtmlInput({
    this.controller,
    this.initalText,
    Key key,
  }) : super(key: key);

  final HtmlEditorController controller;
  final String initalText;

  @override
  State<CustomHtmlInput> createState() => _CustomHtmlInputState();
}

class _CustomHtmlInputState extends State<CustomHtmlInput> {
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        HtmlEditor(
          controller: widget.controller,
          htmlEditorOptions: HtmlEditorOptions(
            hint: "",
            initialText: widget.initalText,
          ),
          htmlToolbarOptions: HtmlToolbarOptions(
            initiallyExpanded: true,
            toolbarItemHeight: 30,
            toolbarType: ToolbarType.nativeExpandable,
          ),
          otherOptions: OtherOptions(
            height: 600,
          ),
        ),
      ],
    ).p2().box.border(color: Colors.grey.shade300).roundedSM.make();
  }
}
