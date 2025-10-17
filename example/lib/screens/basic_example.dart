import 'package:flutter/material.dart';
import 'package:numpad_kit/numpad_kit.dart';

class BasicExampleScreen extends StatefulWidget {
  const BasicExampleScreen({super.key});

  @override
  State<BasicExampleScreen> createState() => _BasicExampleScreenState();
}

class _BasicExampleScreenState extends State<BasicExampleScreen> {
  late NumpadController _controller;
  String _displayValue = '';

  @override
  void initState() {
    super.initState();
    _controller = NumpadController(
      maxLength: 10,
      onInput: (value) {
        setState(() => _displayValue = value);
      },
      onDelete: () {
        setState(() => _displayValue = _controller.value);
      },
      onClear: () {
        setState(() => _displayValue = '');
      },
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
        title: const Text('Basic Numpad'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter a number:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
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
              Numpad(controller: _controller),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _controller.deleteDigit(),
                    icon: const Icon(Icons.backspace),
                    label: const Text('Delete'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () => _controller.clear(),
                    icon: const Icon(Icons.clear),
                    label: const Text('Clear'),
                  ),
                  const SizedBox(width: 16),
                  FilledButton.icon(
                    onPressed: () => _controller.submit(),
                    icon: const Icon(Icons.check),
                    label: const Text('Submit'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Tip: On desktop/web, you can use your keyboard to enter numbers!',
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
