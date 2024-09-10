import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLength;

  const ExpandableText({
    required this.text,
    this.trimLength = 100,
    super.key,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final text = widget.text;
    final trimLength = widget.trimLength;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   isExpanded ? text : '${text.substring(0, trimLength)}...',
        //   style: textTheme.bodyMedium,
        // ),
        // GestureDetector(
        //   onTap: () {
        //     setState(() {
        //       isExpanded = !isExpanded;
        //     });
        //   },
        //   child: Text(
        //     isExpanded ? 'Ver menos' : 'Ver más',
        //     style: TextStyle(color: Colors.blue),
        //   ),
        // ),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: RichText(
            text: TextSpan(
              text: isExpanded ? text : '${text.substring(0, trimLength)}...',
              style: textTheme.bodySmall?.copyWith(
                fontSize: 13,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: isExpanded ? '' : 'Ver más',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: textTheme.bodyMedium?.color?.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
