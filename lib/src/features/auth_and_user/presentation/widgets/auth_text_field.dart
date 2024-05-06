import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/constants.dart';

/// Reusable custom TextField.
class AuthTextField extends StatefulWidget {
  const AuthTextField(
      {super.key,
      required this.myFieldController,
      required this.myKeyboardInputType,
      required this.myHintText,
      required this.myLabelText,
      required this.myWidth,
      this.myObscureText = false,
      this.myIcon});

  final TextEditingController myFieldController;
  final TextInputType myKeyboardInputType;
  final String myHintText;
  final String myLabelText;
  final double myWidth;
  final bool myObscureText;
  final Widget? myIcon;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  // Bool for password obscurity on text field.
  late bool passwordObscurity;

  @override
  void initState() {
    super.initState();
    passwordObscurity = widget.myObscureText;
  }

  // Toggles between password obscurity.
  void changePasswordObscurity() {
    if (passwordObscurity == true) {
      setState(() {
        passwordObscurity = false;
      });
    } else if (passwordObscurity == false) {
      setState(() {
        passwordObscurity = true;
      });
    }
  }

  String? get errorText {
    final text = widget.myFieldController.text;
    if (text.isNotEmpty) {
      if (widget.myKeyboardInputType == TextInputType.emailAddress) {
        if (!text.contains('@')) {
          return 'Put Valid Email';
        }
      } else if (widget.myKeyboardInputType == TextInputType.visiblePassword) {
        if (text.length < 7) {
          return 'Password should be more than 7 characters';
        }
      }
    } else {
      return '${widget.myLabelText} Can\'t Be Empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.myWidth,
      child: TextFormField(
        // Validator for text field.
        validator: (value) {
          switch (widget.myKeyboardInputType) {
            case TextInputType.text:
              if (value != null && value.isEmpty) {
                return 'Enter ${widget.myLabelText}';
              }

            case TextInputType.datetime:
              if (value != null && value.isEmpty) {
                return 'Enter ${widget.myLabelText}';
              }

            case TextInputType.emailAddress:
              if (value != null && value.isNotEmpty) {
                // If email is not null and is not empty, then it should have following pattern for valid email.
                if (!RegExp(
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                    .hasMatch(value)) {
                  return 'Enter Valid Email';
                }
                // If email is not null and empty, it returns obvious message of 'Enter Email'.
              } else if (value != null && value.isEmpty) {
                return 'Enter Email';
              }

            case TextInputType.visiblePassword:
              // Checks if password is not null and is not empty.
              if (value != null && value.isNotEmpty) {
                // If password is not null and not empty, then password should be greater than 7 character length.
                if (value.length < 7) {
                  return 'Password should be more than 7 characters';
                }
                // If password is not null and empty, it returns 'Enter Password' message.
              } else if (value != null && value.isEmpty) {
                return 'Enter Password';
              }

            case TextInputType.phone:
              if (value != null && value.isNotEmpty) {
                if (!RegExp(
                        r"^(\+\d{1,2}\s?)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$")
                    .hasMatch(value)) {
                  return 'Enter Valid Phone Number';
                }
              } else if (value != null && value.isEmpty) {
                return 'Enter Phone Number';
              }
            default:
              return null;
          }
          return null;
        },

        controller: widget.myFieldController,
        keyboardType: widget.myKeyboardInputType,
        obscureText: passwordObscurity,
        style: const TextStyle(
          color: actionColor,
          height: 1.5,
        ),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(width: 2, color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(width: 2, color: Colors.white)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(width: 2, color: Colors.red)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(width: 2, color: Colors.white)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(width: 2, color: Colors.white)),
          border: InputBorder.none,
          hintText: widget.myHintText,
          labelText: widget.myLabelText,
          labelStyle: const TextStyle(color: Colors.white),
          hintStyle: const TextStyle(color: Colors.white60),
          floatingLabelStyle: const TextStyle(color: Colors.white60),

          // Shows suffix icon for password obscurity.
          suffixIcon:
              widget.myKeyboardInputType == TextInputType.visiblePassword
                  ? GestureDetector(
                      onTap: changePasswordObscurity,
                      child: passwordObscurity == false
                          ? const Icon(
                              CupertinoIcons.eye,
                              color: Colors.white60,
                            )
                          : const Icon(
                              CupertinoIcons.eye_slash,
                              color: Colors.white60,
                            ))
                  : null,
          icon: widget.myIcon,
          //errorText: _errorText,
        ),
        // Sets text field to read only if input type is date time.
        readOnly: widget.myKeyboardInputType == TextInputType.datetime,

        onTap: () async {
          if (widget.myKeyboardInputType == TextInputType.datetime) {
            // If input type is date time, it shows date picker dialog to pick date.
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1985),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat().add_d().add_MMMM().add_y().format(pickedDate);
              widget.myFieldController.value =
                  TextEditingValue(text: formattedDate);
            }
          }
        },
      ),
    );
  }
}
