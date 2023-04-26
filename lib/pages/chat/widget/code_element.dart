import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/github-gist.dart';

class CodeElementBuilder extends MarkdownElementBuilder {
  BuildContext buildContext;

  CodeElementBuilder(this.buildContext);

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    var language = 'javascript';

    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String;
      language = lg.substring(9);
    }
    return SizedBox(
      width:
          MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width,
      child: SingleChildScrollView(
        scrollDirection:Axis.horizontal,
        child: HighlightView(
          element.textContent,
          language: language,
          theme: githubTheme,
          textStyle: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
