import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_flutter/features/browse_settings/domain/browse_settings.dart';
import 'package:kunhavigi_flutter/features/browse_settings/provider/settings_provider.dart';
import 'package:kunhavigi_flutter/features/common/presentation/bottom_sheet_base.dart';
import 'package:kunhavigi_flutter/features/common/presentation/messages.dart';

class BrowseSettingsModal extends ConsumerWidget {
  const BrowseSettingsModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(currentBrowseSettingsProvider);

    return BottomSheetBase(
      padding: EdgeInsets.zero,
      header: const BottomSheetHeader(
        title: 'Browse Settings',
        subtitle: 'Configure browse and connection settings',
        icon: Icons.settings,
      ),
      child: settingsAsync.when(
        data: (settings) => _BrowseSettingsForm(settings: settings),
        error: (error, stack) => Padding(
          padding: const EdgeInsets.all(16),
          child: ErrorMessage(error: error, stackTrace: stack),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _BrowseSettingsForm extends HookConsumerWidget {
  const _BrowseSettingsForm({required this.settings});
  final BrowseSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

    void reset() {
      formKey.currentState?.reset();
    }

    void submit() {
      final formState = formKey.currentState;
      if (formState == null || !formState.saveAndValidate()) return;

      final updatedSettings = BrowseSettings.fromFormValues(formState.value);
      ref.read(currentBrowseSettingsProvider.notifier).set(updatedSettings);
      Navigator.of(context).pop();
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: FormBuilder(
        key: formKey,
        initialValue: settings.toFormValues(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          spacing: 24,
          children: [
            const _SettingsSection(
              title: 'Connection',
              icon: Icons.cloud_outlined,
              children: [
                _SettingsTextField(
                  name: 'serverUrl',
                  labelText: 'Server URL',
                  prefixIcon: Icons.cloud_outlined,
                  helperText:
                      'E.g. https://api.example.com/ or http://localhost:3000/',
                ),
              ],
            ),
            _SettingsSection(
              title: 'Display',
              icon: Icons.visibility_outlined,
              children: [
                const _SettingsTextField(
                  name: 'hiddenPatterns',
                  labelText: 'Hidden Patterns',
                  prefixIcon: Icons.visibility_off_outlined,
                  helperText:
                      'Comma separated patterns to hide (e.g. .DS_Store, .git)',
                ),
                _SettingsSwitch(
                  name: 'showHidden',
                  title: 'Show Hidden Files',
                  initialValue: settings.showHidden,
                ),
                const _SettingsTextField(
                  name: 'ignoreUploadPatterns',
                  labelText: 'Ignore Upload Patterns',
                  prefixIcon: Icons.upload_file_outlined,
                  helperText: 'Comma separated patterns to ignore on upload',
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8,
              children: [
                _ResetButton(onPressed: reset),
                _SaveButton(onPressed: submit),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Row(
            children: [
              Icon(
                icon,
                color: colorScheme.primary,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        ...children,
      ],
    );
  }
}

class _SettingsTextField extends StatelessWidget {
  const _SettingsTextField({
    required this.name,
    required this.labelText,
    required this.prefixIcon,
    this.helperText,
  });

  final String name;
  final String labelText;
  final IconData prefixIcon;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: Icon(prefixIcon),
        helperText: helperText,
      ),
    );
  }
}

class _SettingsSwitch extends StatelessWidget {
  const _SettingsSwitch({
    required this.name,
    required this.title,
    required this.initialValue,
  });

  final String name;
  final String title;
  final bool initialValue;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return FormBuilderSwitch(
      name: name,
      title: Text(title, style: textTheme.bodyMedium),
      activeColor: colorScheme.primary,
      initialValue: initialValue,
      decoration: const InputDecoration(border: InputBorder.none),
    );
  }
}

class _ResetButton extends ConsumerWidget {
  const _ResetButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.primary,
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.5,
          ),
          textStyle: Theme.of(context).textTheme.labelLarge,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text('Reset to Defaults'),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          textStyle: textTheme.labelLarge,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text('Save'),
      ),
    );
  }
}
