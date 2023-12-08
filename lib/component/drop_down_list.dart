import 'package:flutter/material.dart';

class DropDownList extends StatelessWidget {
  DropDownList({super.key, required this.name, required this.call});
  final String name;
  final Function call;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(title: Text(name)),
      onTap: () => call(),
    );
  }
}
