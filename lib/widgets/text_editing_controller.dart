import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextFormField customizeTextFormField(
    List<TextInputFormatter>? textInputFormat,
    double mediaQueryWidth,
    TextEditingController controller,
    IconData icon,
    String text,
    int maxLines,
    bool interactiveSelection,
    Function() functionOnTap,
    bool showCursor,
    Function(String) functionEditingComplete,
    String? Function(String?)? functionOfValidator,
    bool isEnabled) {
  return TextFormField(
      inputFormatters: textInputFormat,
      enabled: isEnabled,
      onChanged: functionEditingComplete,
      showCursor: showCursor,
      onTap: functionOnTap,
      enableInteractiveSelection: interactiveSelection,
      maxLines: maxLines,
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.red[700]),
          contentPadding: EdgeInsets.all(mediaQueryWidth * 0.024),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: const BorderSide(color: Colors.amberAccent)),
          prefixIcon: Icon(icon, size: mediaQueryWidth * 0.08),
          hintText: text,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(50.0))),
      validator: functionOfValidator);
}
