import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;

class TruncatedHtmlWidget extends StatelessWidget {
  final String html;
  final int maxLines;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final TextOverflow overflow;

  const TruncatedHtmlWidget({
    super.key,
    required this.html,
    this.maxLines = 3,
    this.textStyle,
    this.textAlign = TextAlign.left,
    this.overflow = TextOverflow.ellipsis,
  });

  /// Convert HTML to plain text
  String _htmlToPlainText(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text ?? '';
  }

  /// Truncate plain text approximately to max lines
  String _truncateToLines(String text, int lines, {int charsPerLine = 50}) {
    final maxChars = lines * charsPerLine;
    if (text.length <= maxChars) return text;
    return '${text.substring(0, maxChars)}...';
  }

  @override
  Widget build(BuildContext context) {
    final plainText = _htmlToPlainText(html);
    final truncatedText = _truncateToLines(plainText, maxLines);

    return Text(
      truncatedText,
      style: textStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
