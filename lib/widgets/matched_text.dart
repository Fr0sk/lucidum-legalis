import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/match.dart';

class MatchedText extends StatelessWidget {
  final String text;
  final List<StringMatch> matches;
  final TextStyle? style;
  final TextStyle? selectedTextStyle;

  const MatchedText(
      {Key? key,
      required this.text,
      this.matches = const [],
      this.style,
      this.selectedTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final texts = <TextSpan>[];

    if (matches.isEmpty) {
      texts.add(TextSpan(text: text));
    } else {
      var txt = text;
      for (var match in matches) {
        texts.addAll([
          TextSpan(text: txt.substring(0, match.index)),
          TextSpan(
            style: selectedTextStyle ??
                TextStyle(color: Theme.of(context).colorScheme.secondary),
            text: txt.substring(match.index, match.index + match.length),
          )
        ]);
        txt = txt.substring(match.index + match.length);
      }

      texts.add(TextSpan(text: txt));
    }

    return RichText(
      text: TextSpan(
        style: style ?? DefaultTextStyle.of(context).style,
        children: texts,
      ),
    );
  }
}
