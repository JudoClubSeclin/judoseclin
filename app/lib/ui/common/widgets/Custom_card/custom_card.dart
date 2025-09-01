import 'package:flutter/material.dart';
import 'package:judoseclin/theme.dart';

class CustomCard extends StatefulWidget {
  final String title;
  final String subTitle;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.title,
    required this.subTitle,
    this.onTap,
  });

  @override
  CustomCardState createState() => CustomCardState();
}

class CustomCardState extends State<CustomCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final borderColor = theme.colorScheme.primary;
    final elevation = _isHovered ? 8.0 : 0.0;

    Widget cardContent = Material(
      color: Colors.transparent,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: borderColor, width: 1.5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: widget.onTap,
        onHover: (hovering) {
          setState(() {
            _isHovered = hovering;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title, style: textStyleText(context)),
              const SizedBox(height: 5),
              Text(widget.subTitle, style: textStyleText(context)),
            ],
          ),
        ),
      ),
    );

    return cardContent;
  }
}
