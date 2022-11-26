import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class EditText extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<InputEvent>? onEvent;
  final InputType inputType;

  const EditText({
    Key? key,
    required this.controller,
    this.onEvent,
    this.inputType = InputType.none,
  }) : super(key: key);

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  var valid = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: _getTextInputType(widget.inputType),
      controller: widget.controller,
      onChanged: _onChanged,
      showCursor: true,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: _decoration(),
    );
  }

  _onChanged(String value) {
    final type = widget.inputType;
    if (type == InputType.email) {
      valid = isEmail(value);
    } else if (type == InputType.number) {
      valid = isNumeric(value);
    } else if (type == InputType.date || type == InputType.time) {
      valid = isDate(value);
    } else if (type == InputType.url) {
      valid = isURL(value);
    } else {
      valid = value.isNotEmpty;
    }

    setState(() {
      widget.onEvent?.call(InputEvent(
        isValid: valid,
        value: value,
      ));
    });
  }

  _decoration() {
    return InputDecoration(
      labelText: "Email",
      labelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
      hintText: "something@email.com",
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 15,
      ),
      prefixIcon: const Icon(
        Icons.email_outlined,
        color: Colors.white,
      ),
      suffixIcon: !valid
          ? const Icon(
              Icons.close_sharp,
              color: Colors.red,
            )
          : const Icon(
              Icons.done,
              color: Colors.green,
            ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey.shade200,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: !valid ? Colors.red : Colors.green,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      floatingLabelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  _getTextInputType(InputType type) {
    if (type == InputType.email) {
      return TextInputType.emailAddress;
    } else if (type == InputType.text) {
      return TextInputType.text;
    } else if (type == InputType.multiline) {
      return TextInputType.multiline;
    } else if (type == InputType.number) {
      return TextInputType.number;
    } else if (type == InputType.date || type == InputType.time) {
      return TextInputType.datetime;
    } else if (type == InputType.url) {
      return TextInputType.url;
    } else {
      return TextInputType.text;
    }
  }
}

enum InputType {
  none,
  email,
  phone,
  password,
  retypePassword,
  date,
  number,
  time,
  text,
  multiline,
  url,
}

class InputValidator {}

class InputEvent {
  final bool isValid;
  final String value;

  InputEvent({
    required this.isValid,
    required this.value,
  });

  InputEvent copyWith({
    final bool? isValid,
    final String? result,
  }) {
    return InputEvent(
      isValid: isValid ?? this.isValid,
      value: result ?? this.value,
    );
  }
}
