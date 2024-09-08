import 'package:flutter/material.dart';

class ToggleModeButton extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  const ToggleModeButton({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  @override
  State<ToggleModeButton> createState() => _ToggleModeButtonState();
}

class _ToggleModeButtonState extends State<ToggleModeButton> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  @override
  void didUpdateWidget(covariant ToggleModeButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isDarkMode != widget.isDarkMode) {
      setState(() {
        _isDarkMode = widget.isDarkMode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      isSelected: _isDarkMode,
      onPressed: () {
        widget.onDarkModeChanged(!_isDarkMode);
      },
      icon: Icon(
        _isDarkMode ? Icons.dark_mode : Icons.light_mode,
      ),
    );
  }
}