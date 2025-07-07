import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RenameDialog extends HookWidget {
  const RenameDialog({required this.initialName, super.key});

  final String initialName;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialName);

    return AlertDialog(
      title: const Text('Rename'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'New name',
          border: OutlineInputBorder(),
        ),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(controller.text),
          child: const Text('Rename'),
        ),
      ],
    );
  }
}
