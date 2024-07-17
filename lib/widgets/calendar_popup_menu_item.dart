import 'package:flutter/material.dart';
import 'package:flutter_dtr_app/core/theme.dart';
import 'package:flutter_dtr_app/widgets/typography.dart';

class CalendarPopupMenuItem<T> extends PopupMenuEntry<T> {
  const CalendarPopupMenuItem({
    super.key,
    required this.value,
    required this.isSelected,
  });

  final T value;
  final bool isSelected;

  @override
  State<CalendarPopupMenuItem> createState() => _CalendarPopupMenuItemState();

  @override
  double get height => kMinInteractiveDimension;

  @override
  bool represents(T? value) {
    return this.value == value;
  }
}

class _CalendarPopupMenuItemState extends State<CalendarPopupMenuItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    if (widget.isSelected) {
      backgroundColor = palette['primary'];
    } else if (isHovered) {
      backgroundColor = palette['inputs'];
    } else {
      backgroundColor = Colors.white;
    }
    Color? textColor = widget.isSelected ? Colors.white : palette['dark'];
    return InkWell(
      onHover: (value) => setState(() {
        isHovered = value;
      }),
      onTap: () => Navigator.pop(context, widget.value),
      child: Container(
        padding: const EdgeInsets.all(10),
        color: backgroundColor!,
        child: buildRegularText(widget.value.toString(),
            fontSize: 16, color: textColor),
      ),
    );
  }
}
