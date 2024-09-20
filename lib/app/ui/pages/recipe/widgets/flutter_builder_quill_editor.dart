// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;

// class FormBuilderQuillEditor extends FormBuilderField<String> {
//   final quill.QuillController controller;
//   final double height;

//   FormBuilderQuillEditor({
//     required String name,
//     required this.controller,
//     this.height = 200,
//     FormFieldValidator<String>? validator,
//     bool? enabled,
//   }) : super(
//           name: name,
//           validator: validator,
//           initialValue: controller.document.toPlainText(),
//           builder: (FormFieldState<String?> field) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Barra de herramientas con opciones avanzadas
//                 quill.QuillSimpleToolbar(
//                   controller: controller,
//                   configurations: quill.QuillSimpleToolbarConfigurations(
//                     showAlignmentButtons: true,
//                   ),
//                 ),
//                 Container(
//                   height: height,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                   ),
//                   child: quill.QuillEditor.basic(
//                     controller: controller,
//                     // readOnly: !(enabled ?? true),  // Si el campo está habilitado
//                   ),
//                 ),
//                 if (field.hasError)
//                   Text(
//                     field.errorText!,
//                     style: TextStyle(color: Colors.red),
//                   ),
//               ],
//             );
//           },
//         );

//   @override
//   FormBuilderFieldState<FormBuilderQuillEditor, String> createState() =>
//       _FormBuilderQuillEditorState();
// }

// class _FormBuilderQuillEditorState
//     extends FormBuilderFieldState<FormBuilderQuillEditor, String> {
//   @override
//   void didChange(String? value) {
//     super.didChange(value);
//   }

//   @override
//   void save() {
//     final value = widget.controller.document.toPlainText();
//     setValue(value);
//     super.save();
//   }
// }
