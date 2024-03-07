import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Widget text;
  final VoidCallback onPressed;
  
  const MyButton({
    super.key,
    required this.text, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: onPressed,
          
          child: text,
        ),
      ),
    );
  }
}
