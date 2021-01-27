import 'package:flutter/material.dart';

class CuidapetTextFormField extends TextFormField {
  CuidapetTextFormField({
    TextEditingController controller,
    @required String label,
    FormFieldValidator<String> validator,
    bool obscureText = false,
    IconButton suffixIcon,
  }) : super(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            labelText: label,
            labelStyle: TextStyle(fontSize: 15),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50), gapPadding: 0),
          ),
          validator: validator,
        );
}
