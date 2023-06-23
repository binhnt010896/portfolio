import 'package:flutter/material.dart';

enum ListType {
  ROW,
  COLUMN
}

class CustomColumnRow extends StatefulWidget {
  final List<Widget> children;
  final Widget? separator;
  final ListType listType;
  final CrossAxisAlignment crossAxisAlignment;
  const CustomColumnRow({
    Key? key,
    required this.children,
    this.separator,
    this.listType = ListType.COLUMN,
    this.crossAxisAlignment = CrossAxisAlignment.center
  }) : super(key: key);

  @override
  State<CustomColumnRow> createState() => _CustomColumnRowState();
}

class _CustomColumnRowState extends State<CustomColumnRow> {

  List<Widget> widgetList = [];

  @override
  void initState() {
    for (var child in widget.children) {
      widgetList.add(child);
      if (widget.children.indexOf(child) != widget.children.length - 1) {
        widgetList.add(widget.separator ?? SizedBox(height: 0, width: 0));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listType == ListType.ROW) {
      return Row(
        crossAxisAlignment: widget.crossAxisAlignment,
        children: [
          for (Widget child in widgetList)
            child
        ],
      );
    }
    return Column(
      crossAxisAlignment: widget.crossAxisAlignment,
      children: [
        for (Widget child in widgetList)
          child
      ],
    );
  }
}
