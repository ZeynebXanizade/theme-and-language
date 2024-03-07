import 'package:flutter/material.dart';

class TextFields extends StatefulWidget {
  // ignore: use_super_parameters
  const TextFields({
    Key? key,
    required this.text,
    required this.keyboardType,
    required this.controller,
    required this.obscureText,
    required this.validator,
  }) : super(key: key);
  final String text;
  final TextInputType keyboardType;

  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formState,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            style: Theme.of(context).textTheme.headlineLarge,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: true,
            validator: widget.validator,
            controller: widget.controller,
            decoration: InputDecoration(
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20) , borderSide: BorderSide(color:  Theme.of(context).colorScheme.primary)),
              labelStyle: Theme.of(context).textTheme.headlineLarge,
              labelText: widget.text,
            ),
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
          ),
        ));
  }
}
