import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    required this.name,
    super.key,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete'),
      content: Text('Are you sure you want to delete "$name"?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}

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
