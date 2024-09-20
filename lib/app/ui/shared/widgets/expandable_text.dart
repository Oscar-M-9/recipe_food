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

    // Asegúrate de que el trimLength no sea mayor que la longitud del texto
    final displayText = text.length > trimLength && !isExpanded
        ? '${text.substring(0, trimLength)}...'
        : text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: RichText(
            text: TextSpan(
              text: displayText,
              style: textTheme.bodySmall?.copyWith(
                fontSize: 13,
              ),
              children: <TextSpan>[
                if (!isExpanded && text.length > trimLength)
                  TextSpan(
                    text: ' Ver más',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: textTheme.bodyMedium?.color?.withOpacity(0.8),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
