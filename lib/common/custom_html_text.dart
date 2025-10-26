import 'package:markdown/markdown.dart' as md;
import 'package:html/parser.dart' as html_parser;
import 'package:intl/intl.dart';

/// Convert either markdown-like text or HTML string into plain text.
/// - If input already contains HTML tags, it'll treat it as HTML.
/// - Otherwise it will convert markdown -> HTML -> plain text.
String toPlainText(String input) {
  if (input.trim().isEmpty) return '';

  // Basic detection: if it contains HTML tags, parse as html.
  final hasHtmlTags = RegExp(r'<[^>]+>').hasMatch(input);

  String intermediateHtml;
  if (hasHtmlTags) {
    intermediateHtml = input;
  } else {
    // Convert Markdown to HTML first (so lists, bold, etc. become tags we can cleanly strip)
    intermediateHtml = md.markdownToHtml(input);
  }

  // Parse HTML and extract text (this will normalize whitespace and preserve basic
  // line breaks for block elements).
  final document = html_parser.parse(intermediateHtml);
  final plain = document.body?.text ?? document.documentElement?.text ?? '';

  // Trim and normalize multiple blank lines to two newlines max
  final normalized = plain.trim().replaceAll(RegExp(r'\n{3,}'), '\n\n');

  return normalized;
}

String formatTo12HourTime(String utcTime) {
  try {
    // Parse the UTC timestamp
    final dateTime = DateTime.parse(utcTime).toLocal(); // Convert to local time

    // Format to 12-hour time with AM/PM
    final formattedTime = DateFormat('h:mm a').format(dateTime);

    return formattedTime; // e.g., "12:56 PM"
  } catch (e) {
    return ''; // Handle invalid format safely
  }
}
