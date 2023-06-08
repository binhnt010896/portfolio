import 'package:flutter/material.dart';

class ContactButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ContactButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 26, bottom: 26, right: 48),
      child: MaterialButton(
          color: Theme.of(context).colorScheme.secondary,
          textColor: Theme.of(context).colorScheme.onSecondary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
          ),
          elevation: 5,
          onPressed: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text('Contact', style: TextStyle(fontWeight: FontWeight.bold)),
          )
      ),
    );
  }
}
