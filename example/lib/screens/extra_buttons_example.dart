import 'package:flutter/material.dart';
import 'package:numpad_kit/numpad_kit.dart';

class ExtraButtonsExampleScreen extends StatefulWidget {
  const ExtraButtonsExampleScreen({super.key});

  @override
  State<ExtraButtonsExampleScreen> createState() =>
      _ExtraButtonsExampleScreenState();
}

class _ExtraButtonsExampleScreenState extends State<ExtraButtonsExampleScreen> {
  late NumpadController _controller;
  String _displayValue = '';
  bool _showLeftButton = true;
  bool _showRightButton = true;

  @override
  void initState() {
    super.initState();
    _controller = NumpadController(
      onInput: (value) => setState(() => _displayValue = value),
      onDelete: () => setState(() => _displayValue = _controller.value),
      onClear: () => setState(() => _displayValue = ''),
      onSubmit: (value) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Submitted: $value')));
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extra Buttons'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Configure extra buttons:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilterChip(
                    label: const Text('Left Button (Delete)'),
                    selected: _showLeftButton,
                    onSelected: (value) {
                      setState(() => _showLeftButton = value);
                    },
                    avatar: const Icon(Icons.backspace, size: 18),
                  ),
                  const SizedBox(width: 16),
                  FilterChip(
                    label: const Text('Right Button (Submit)'),
                    selected: _showRightButton,
                    onSelected: (value) {
                      setState(() => _showRightButton = value);
                    },
                    avatar: const Icon(Icons.check, size: 18),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _displayValue.isEmpty ? '0' : _displayValue,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Numpad(
                controller: _controller,
                showLeftExtraButton: _showLeftButton,
                leftExtraButton: const Icon(Icons.backspace),
                onLeftExtraButton: () => _controller.deleteDigit(),
                showRightExtraButton: _showRightButton,
                rightExtraButton: const Icon(Icons.check),
                onRightExtraButton: () => _controller.submit(),
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Toggle the chips above to show/hide extra buttons. '
                  'The left button deletes the last digit, and the right button submits.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
