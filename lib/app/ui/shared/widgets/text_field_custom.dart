import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:recipe_food/app/config/app_colors.dart';

class TextFieldCustom extends StatelessWidget {
  final String? hintText;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextInputType? keyboardType;
  final int? minLines;
  final Color? color;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double radius;
  final String name;
  final bool obscureText;
  final int? maxLines;

  const TextFieldCustom({
    super.key,
    this.hintText,
    this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.keyboardType = TextInputType.text,
    this.minLines = 1,
    this.controller,
    this.validator,
    this.onChanged,
    this.color,
    this.focusNode,
    this.suffixIcon,
    this.prefixIcon,
    this.radius = 25,
    required this.name,
    this.obscureText = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      minLines: minLines,
      maxLines: maxLines,
      autocorrect: false,
      focusNode: focusNode,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: TextOverflow.ellipsis,
        color: color,
      ),
      decoration: InputDecoration(
        filled: false,
        border: InputBorder.none,
        errorMaxLines: 2,
        // hintText: hintText,
        labelText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        suffixIcon: suffixIcon,
        suffixIconColor: Theme.of(context).iconTheme.color?.withOpacity(0.7),
        prefixIconColor: Theme.of(context).iconTheme.color?.withOpacity(0.7),
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: AppColors.silver500,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: AppColors.silver500,
            width: 1.0,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: AppColors.silver300,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: Color(0xFFDC3838),
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: Color(0xFFEE5E5E),
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
