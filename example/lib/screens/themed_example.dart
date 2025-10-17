import 'package:flutter/material.dart';
import 'package:numpad_kit/numpad_kit.dart';

class ThemedExampleScreen extends StatefulWidget {
  const ThemedExampleScreen({super.key});

  @override
  State<ThemedExampleScreen> createState() => _ThemedExampleScreenState();
}

class _ThemedExampleScreenState extends State<ThemedExampleScreen> {
  late NumpadController _controller;
  String _displayValue = '';
  int _selectedTheme = 0;

  final List<_ThemeConfig> _themes = [
    _ThemeConfig(name: 'Default Light', theme: NumpadThemeData.light()),
    _ThemeConfig(name: 'Default Dark', theme: NumpadThemeData.dark()),
    _ThemeConfig(
      name: 'Blue Circles',
      theme: NumpadThemeData(
        buttonColor: Colors.blue.shade100,
        buttonTextColor: Colors.blue.shade900,
        buttonHoverColor: Colors.blue.shade200,
        buttonPressedColor: Colors.blue.shade300,
        buttonShape: NumpadButtonShape.circle,
      ),
    ),
    _ThemeConfig(
      name: 'Green Squares',
      theme: const NumpadThemeData(
        buttonColor: Color(0xFFC8E6C9),
        buttonTextColor: Color(0xFF1B5E20),
        buttonHoverColor: Color(0xFFA5D6A7),
        buttonPressedColor: Color(0xFF81C784),
        buttonShape: NumpadButtonShape.square,
        borderWidth: 2,
        buttonBorderColor: Color(0xFF4CAF50),
      ),
    ),
    _ThemeConfig(
      name: 'Purple Rounded',
      theme: const NumpadThemeData(
        buttonColor: Color(0xFFE1BEE7),
        buttonTextColor: Color(0xFF4A148C),
        buttonHoverColor: Color(0xFFCE93D8),
        buttonPressedColor: Color(0xFFBA68C8),
        buttonShape: NumpadButtonShape.roundedSquare,
        borderRadius: 20,
        shadows: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = NumpadController(
      onInput: (value) => setState(() => _displayValue = value),
      onDelete: () => setState(() => _displayValue = _controller.value),
      onClear: () => setState(() => _displayValue = ''),
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
        title: const Text('Themed Numpad'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Select a theme:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: List.generate(_themes.length, (index) {
                  return ChoiceChip(
                    label: Text(_themes[index].name),
                    selected: _selectedTheme == index,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedTheme = index);
                      }
                    },
                  );
                }),
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
              NumpadTheme(
                data: _themes[_selectedTheme].theme,
                child: Numpad(controller: _controller),
              ),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeConfig {
  final String name;
  final NumpadThemeData theme;

  _ThemeConfig({required this.name, required this.theme});
}
