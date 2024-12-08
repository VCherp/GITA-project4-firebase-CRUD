import 'package:flutter/material.dart';

class FirebaseTextField extends StatefulWidget {
  final String labelText;
  final IconData icon;
  final void Function(String) onEditingComplete;

  const FirebaseTextField({
    required this.labelText,
    required this.icon,
    required this.onEditingComplete,
    super.key,
  });

  @override
  State<FirebaseTextField> createState() => FirebaseTextFieldState();
}

class FirebaseTextFieldState extends State<FirebaseTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void clear() {
    // setState(() {
    _controller.clear();
    // });
  }

  void fillData(String text) {
    // setState(() {
    _controller.text = text;
    // });
  }

  @override
  Widget build(BuildContext context) {
    const accentColor = Color.fromRGBO(255, 145, 0, 1);
    //Theme.of(context).primaryColor.withOpacity(1);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        // onTapOutside: (_) {
        //   widget.onEditingComplete(_controller.text);
        // },
        onChanged: widget.onEditingComplete,
        // onEditingComplete: () {
        //   widget.onEditingComplete(_controller.text);
        // },
        onSubmitted: (value) {
          widget.onEditingComplete(_controller.text);
          FocusScope.of(context).unfocus();
        },
        controller: _controller,
        keyboardType: TextInputType.text,
        cursorColor: accentColor,
        style: const TextStyle(color: accentColor, fontSize: 20),
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: const TextStyle(color: Colors.grey),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: accentColor)),
          focusColor: accentColor,
          prefixIcon: Icon(
            widget.icon,
            color: accentColor,
          ),
        ),
      ),
    );
  }
}
