import 'package:flutter/material.dart';
import 'screens/basic_example.dart';
import 'screens/themed_example.dart';
import 'screens/extra_buttons_example.dart';
import 'screens/custom_builder_example.dart';

void main() {
  runApp(const NumpadKitExampleApp());
}

class NumpadKitExampleApp extends StatelessWidget {
  const NumpadKitExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Numpad Kit Examples',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatelessWidget {
  const ExampleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Numpad Kit Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _ExampleCard(
            title: 'Basic Numpad',
            description: 'Default numpad with standard configuration',
            icon: Icons.dialpad,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BasicExampleScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _ExampleCard(
            title: 'Themed Numpad',
            description: 'Custom themes with different colors and shapes',
            icon: Icons.palette,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ThemedExampleScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _ExampleCard(
            title: 'Extra Buttons',
            description: 'Numpad with customizable extra buttons',
            icon: Icons.add_circle_outline,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ExtraButtonsExampleScreen(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _ExampleCard(
            title: 'Custom Builder',
            description: 'Using custom button widgets',
            icon: Icons.build,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CustomBuilderExampleScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExampleCard extends StatelessWidget {
  const _ExampleCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
