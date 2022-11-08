import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RoundedDialog extends StatefulWidget {
  const RoundedDialog({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<RoundedDialog> createState() => _RoundedDialogState();
}

class _RoundedDialogState extends State<RoundedDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 200,
        child: Center(child: widget.child),
      ),
    );
  }
}
