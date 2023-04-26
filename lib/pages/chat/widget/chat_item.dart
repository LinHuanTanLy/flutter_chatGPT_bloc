import 'package:bubble_box/bubble_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'code_element.dart';

class ChatItem extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatItem({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    Widget portrait = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black,
      ),
      width: 38,
      height: 38,
    );

    Widget content = BubbleBox(
      maxWidth: MediaQuery.of(context).size.width * 0.8,
      shape: BubbleShapeBorder(
        position: const BubblePosition.start(12),
        direction: isMe ? BubbleDirection.right : BubbleDirection.left,
      ),
      backgroundColor: isMe ? const Color(0xff94EB68) : Colors.white,
      child: MarkdownBody(data: message, builders: {
        'code': CodeElementBuilder(context),
      },selectable: true,),
    );

    Widget space = const SizedBox(
      width: 6,
    );
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: isMe ? [content, space, portrait] : [portrait, space, content],
    );
  }
}
