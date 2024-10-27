library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:text_field/leading_builder.dart';

import 'text_field_item.dart';

const InputDecoration defaultInputDecoration = InputDecoration(
    errorStyle: TextStyle(height: 0),
    hintStyle:
        TextStyle(color: Color.fromARGB(255, 159, 159, 159), fontSize: 12),
    contentPadding: EdgeInsets.only(left: 10, bottom: 15),
    border: InputBorder.none,
    // focusedErrorBorder:
    //     OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 114, 145, 245))),
    errorBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 114, 145, 245))),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 159, 159, 159))));

typedef OnSubmit<T extends TextFieldItem> = void Function(T item);

class CustomTextField<T extends TextFieldItem> extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.maxLines,
      this.items = const [],
      this.border,
      this.contentPadding,
      this.enabledBorder,
      this.errorBorder,
      this.errorStyle,
      this.focusedBorder,
      this.hintStyle,
      this.focusedErrorBorder});
  final int? maxLines;
  final List<T> items;
  final TextStyle? errorStyle;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? focusedErrorBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState<T extends TextFieldItem>
    extends State<CustomTextField> {
  final TextEditingController controller = TextEditingController();

  // ignore: avoid_init_to_null
  T? selected = null;

  void showPopupMenu(Offset offset, List<PopupMenuEntry<T>> items) {
    if (kDebugMode) {
      print(offset);
    }
    showMenu<T>(
            context: context,
            position: RelativeRect.fromLTRB(
                offset.dx, offset.dy, offset.dx, offset.dy),
            items: items)
        .then((v) {
      if (selected != v) {
        setState(() {
          selected = v;
        });
        controller.text =
            controller.text.substring(0, controller.text.length - 1);
      }
    });
  }

  (double, double) getTextWidth() {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: controller.text,
        style: TextStyle(fontSize: 16.0),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    double textWidth = textPainter.width;
    double textHeight = textPainter.height;
    if (kDebugMode) {
      print(textWidth);
    }
    return (textWidth, textHeight);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        if (widget.items.isEmpty) {
          return;
        }

        if (controller.selection.extentOffset != value.length) {
          return;
        }

        if (value.isNotEmpty) {
          var char = value.substring(value.length - 1);
          if (char == '@') {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            Offset globalPosition = renderBox.localToGlobal(Offset.zero);
            if (kDebugMode) {
              print(globalPosition);
            }

            final size = renderBox.size;

            var (textWidth, textHeight) = getTextWidth();

            showPopupMenu(
                Offset(
                    textWidth % size.width,
                    ((textWidth / size.width).ceil() + 1) * textHeight +
                        size.height +
                        20),
                widget.items
                    .map((e) =>
                        PopupMenuItem<T>(value: e as T, child: Text(e.content)))
                    .toList());
          }
        }
      },
      maxLines: widget.maxLines ?? 1,
      decoration: InputDecoration(
        enabledBorder:
            widget.enabledBorder ?? defaultInputDecoration.enabledBorder,
        errorBorder: widget.errorBorder ?? defaultInputDecoration.errorBorder,
        focusedBorder:
            widget.focusedBorder ?? defaultInputDecoration.focusedBorder,
        focusedErrorBorder: widget.focusedErrorBorder ??
            defaultInputDecoration.focusedErrorBorder,
        errorStyle: widget.errorStyle ?? defaultInputDecoration.errorStyle,
        hintStyle: widget.hintStyle ?? defaultInputDecoration.hintStyle,
        contentPadding:
            widget.contentPadding ?? defaultInputDecoration.contentPadding,
        border: widget.border ?? defaultInputDecoration.border,
        prefix: selected != null
            ? LeadingBuilder(
                item: selected!,
              )
            : null,
      ),
    );
  }
}
