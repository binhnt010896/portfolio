import 'package:flutter/material.dart';

class NavigationButton extends StatefulWidget {
  final String title;
  final int index;
  final int currentIndex;
  final VoidCallback onPress;
  final ValueChanged<int> onHover;

  const NavigationButton({Key? key, required this.title, required this.onPress, required this.onHover, required this.index, required this.currentIndex}) : super(key: key);

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  @override
  Widget build(BuildContext context) {

    bool isHover = false;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) {
        if (!isHover) {
          setState(() => isHover = true);
        }
        widget.onHover(widget.index);
      },
      onExit: (event) {
        if (isHover) {
          setState(() => isHover = false);
        }
        widget.onHover(-1);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: GestureDetector(
          onTap: widget.onPress,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title, style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: (widget.index == widget.currentIndex) ? Theme.of(context).colorScheme.secondary : Colors.white,
              )),
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: 2,
                width: (widget.index == widget.currentIndex) ? 24 : 0,
                color: (widget.index == widget.currentIndex) ? Theme.of(context).colorScheme.secondary : Colors.white,
                margin: EdgeInsets.only(top: 4),
              )
            ],
          ),
        ),
      ),
    );
  }
}
