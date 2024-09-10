import 'package:flutter/material.dart';
import 'package:recipe_food/app/ui/shared/inputs/custom_input.dart';

class NumberInputField extends StatefulWidget {
  // final int initialValue;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function()? onTapDecrement;
  final void Function()? onTapIncrement;

  const NumberInputField({
    super.key,
    // this.initialValue = 1,
    required this.controller,
    this.onChanged,
    this.onTapDecrement,
    this.onTapIncrement,
  });

  @override
  State<NumberInputField> createState() => _NumberInputFieldState();
  // metodo getter para obtener el valor actual
  // int get currentValue => _NumberInputFieldState()._currentValue;
}

class _NumberInputFieldState extends State<NumberInputField> {
  // late int _currentValue;
  // final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _currentValue = widget.initialValue;
    // widget.controller.text = _currentValue.toString();
  }

  // // Método para aumentar el valor
  // void _increment() {
  //   setState(() {
  //     _currentValue++;
  //     widget.controller.text = _currentValue.toString();
  //   });
  // }

  // // Método para disminuir el valor, validando que no baje de 0
  // void _decrement() {
  //   setState(() {
  //     if (_currentValue > 0) {
  //       _currentValue--;
  //       widget.controller.text = _currentValue.toString();
  //     }
  //   });
  // }

  // Validador que solo permite números enteros y positivos
  String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }

    // Expresión regular para asegurar que solo se ingresen números enteros
    final regex = RegExp(r'^[0-9]+$');
    if (!regex.hasMatch(value)) {
      return 'Only whole numbers are allowed';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // IconButton(
        //   icon: Icon(Icons.remove),
        //   onPressed: _decrement,
        // ),
        Stack(
          children: [
            SizedBox(
              width: 85,
              child: TextFormField(
                controller: widget.controller,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number, // Solo números
                decoration: CustomInput.buildInputDecoration(
                  context,
                  hintText: "",
                  radius: 5,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 25,
                  ),
                ),
                validator: _validateNumber,
                onChanged: widget.onChanged,
                // onChanged: (value) {
                //   final int? number = int.tryParse(value);
                //   if (number != null && number >= 0) {
                //     setState(() {
                //       _currentValue = number;
                //     });
                //   }
                // },
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 2,
              child: InkWell(
                onTap: widget.onTapDecrement,
                child: const Icon(Icons.remove_rounded),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: 2,
              child: InkWell(
                onTap: widget.onTapIncrement,
                child: const Icon(Icons.add_rounded),
              ),
            ),
          ],
        ),
        // IconButton(
        //   icon: Icon(Icons.add),
        //   onPressed: _increment,
        // ),
      ],
    );
  }
}
