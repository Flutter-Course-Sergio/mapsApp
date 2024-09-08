import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final Function()? onPressed;

  const CustomFloatingActionButton(
      {super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: Colors.black,
            )),
      ),
    );
  }
}
