import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:velocity_x/velocity_x.dart';

class TaxiCustomTextFormField extends StatelessWidget {
  const TaxiCustomTextFormField({
    this.hintText,
    this.focusNode,
    this.controller,
    this.onChanged,
    Key key,
  }) : super(key: key);
  final String hintText;
  final FocusNode focusNode;
  final TextEditingController controller;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
      ),
      autofocus: false,
      maxLines: 1,
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
    )
        .box
        .color(
          focusNode.hasFocus ? context.backgroundColor : Colors.grey.shade200,
        )
        .withRounded(value: 5)
        .clip(Clip.antiAlias)
        .border(
          color:
              focusNode.hasFocus ? AppColor.primaryColor : Colors.transparent,
          width: 1.5,
        )
        .make();
  }
}
