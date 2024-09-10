import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconText extends StatelessWidget {
  const IconText({
    super.key,
    required this.svgPath,
    required this.text,
  });

  final String svgPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          svgPath,
          width: 15,
          height: 15,
          // ignore: deprecated_member_use
          color: theme.iconTheme.color,
        ),
        const SizedBox(width: 6),
        AutoSizeText(
          text,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
