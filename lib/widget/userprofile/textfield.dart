import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final int maxLines;
  final String label;
  final String text;
  final ValueChanged<String> onChanged;
  const TextfieldWidget({
    Key key,
    this.maxLines = 1,
    @required this.label,
    @required this.text,
    @required this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: text);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          maxLines: maxLines,
        ),
      ],
    );
  }
}
