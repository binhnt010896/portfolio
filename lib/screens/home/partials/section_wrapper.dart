import 'package:flutter/material.dart';

class SectionWrapper extends StatefulWidget {
  final Widget child;
  const SectionWrapper({Key? key, required this.child}) : super(key: key);

  @override
  State<SectionWrapper> createState() => _SectionWrapperState();
}

class _SectionWrapperState extends State<SectionWrapper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}
