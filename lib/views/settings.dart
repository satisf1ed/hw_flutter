import 'package:flutter/material.dart';
import 'package:hw_flutter/providers/theme_provider.dart';
import 'package:provider/provider.dart';

const List<Widget> themes = [
  Text('Light'),
  Text('Dark'),
];

class ToggleButtonsSample extends StatefulWidget {
  const ToggleButtonsSample({super.key, required this.title});

  final String title;

  @override
  State<ToggleButtonsSample> createState() => _ToggleButtonsSampleState();
}

class _ToggleButtonsSampleState extends State<ToggleButtonsSample> {
  late final List<bool> _selectedTheme;

  @override
  void initState() {
    super.initState();
    _selectedTheme = <bool>[
      Provider.of<ThemeProvider>(context, listen: false).isLight,
      !Provider.of<ThemeProvider>(context, listen: false).isLight
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Theme', style: theme.textTheme.titleMedium),
                const SizedBox(height: 5),
                ToggleButtons(
                  direction: Axis.horizontal,
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < _selectedTheme.length; i++) {
                        _selectedTheme[i] = i == index;
                      }
                    });

                    if (index == 0) {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .turnOnLight();
                    } else {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .turnOnDark();
                    }
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Colors.red[700],
                  selectedColor: Colors.white,
                  fillColor: Colors.red[200],
                  color: Colors.red[400],
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: _selectedTheme,
                  children: themes,
                ),
              ]
              // ToggleButtons with a multiple selection.
              ),
        ),
      ),
    );
  }
}
