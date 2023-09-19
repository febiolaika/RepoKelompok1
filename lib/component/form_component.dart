import 'package:flutter/material.dart';

class InputForm extends StatefulWidget {
  Function(String?) validasi;
  final TextEditingController controller;
  final String hintTxt;
  final String helperTxt;
  final IconData iconData;
  final bool password;
  InputForm({super.key,
  required this.validasi,
  required this.controller,
  required this.hintTxt,
  required this.helperTxt,
  required this.iconData,
  this.password = false,
  });

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  
  bool show = false;
  @override
  void initState() {
    super.initState();
    show = widget.password;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.only(left: 20, top: 10),
    child: SizedBox(
        width: 350,
        child: TextFormField(
          validator: (value) => widget.validasi(value),
          autofocus: true,
          controller: widget.controller,
          obscureText: show,
          decoration: InputDecoration(
            hintText: widget.hintTxt,
            border: const OutlineInputBorder(),
            helperText: widget.helperTxt,
            prefixIcon: Icon(widget.iconData),
            suffixIcon: widget.password ? toggleVisibility() : null,
          ),
        )),
  );
  }
  Widget toggleVisibility() {
    return IconButton(
        onPressed: () {
          setState(() {
            show = !show;
          });
        },
        icon: show
            ? const Icon(Icons.visibility_off)
            : const Icon(Icons.visibility));
  }
}
