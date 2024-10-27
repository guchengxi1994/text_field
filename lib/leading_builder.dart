import 'package:flutter/material.dart';
import 'package:text_field/text_field_item.dart';

class LeadingBuilder<T extends TextFieldItem> extends StatelessWidget {
  const LeadingBuilder({super.key, required this.item});
  final T item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.lightBlue, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(right: 10),
      width: 80,
      height: 30,
      child: Center(
        child: Text(
          item.content,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
