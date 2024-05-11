import 'package:doctor_reservation/Custom/colors.dart';
import 'package:flutter/material.dart';

class custom_text_field extends StatelessWidget {
  final TextEditingController? EditingController;
  final String Label;
  final int? maxlines;
  final TextInputType textInputType;
  final bool obscure_text;
  final ValueSetter? onchanged;

  const custom_text_field(
      {super.key,
      required this.EditingController,
      required this.Label,
      required this.maxlines,
      required this.textInputType,
      required this.obscure_text,
      required this.onchanged});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width * 0.85,
        child: TextField(
          style: TextStyle(fontSize: 13),
          onChanged: onchanged,
          controller: EditingController,
          maxLines: maxlines,
          obscureText: obscure_text,
          keyboardType: textInputType,
          decoration: InputDecoration(
              label: Text(Label),
              alignLabelWithHint: true,
              labelStyle: const TextStyle(color: blue, fontSize: 12.5),
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)))),
        ));
  }
}
