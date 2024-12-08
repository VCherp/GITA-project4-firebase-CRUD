import 'package:flutter/material.dart';

class FirebaseButton extends StatefulWidget {
  final String title;
  final void Function() onPress;

  const FirebaseButton({required this.title, required this.onPress, super.key});

  @override
  State<FirebaseButton> createState() => _FirebaseButtonState();
}

class _FirebaseButtonState extends State<FirebaseButton> {
  @override
  Widget build(BuildContext context) {
    const accentColor = Color.fromRGBO(255, 145, 0, 1);
    //Theme.of(context).primaryColor.withOpacity(1);

    var isPressed = false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: 100,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed) ||
                  states.contains(WidgetState.hovered)) {
                isPressed = true;
                return accentColor; // Color when the button is pressed
              }
              isPressed = false;
              return Colors.black; // Default color
            }),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                side: const BorderSide(
                    color: Color.fromRGBO(255, 145, 0, 1), width: 3),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
          onPressed: widget.onPress,
          child: Text(
            widget.title,
            style: TextStyle(color: isPressed ? Colors.black : Colors.white),
          ),
        ),
      ),
    );
  }
}
