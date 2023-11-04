import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final IconData icon;
  final int? flex;
  final String? toolTip;
  final void Function()? onPressed;

  const BottomButton({
    super.key,
    required this.icon,
    this.flex = 1,
    this.onPressed,
    this.toolTip = 'Tooltip'
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex!,
      child: Tooltip(
        verticalOffset: 40.0,
        triggerMode: TooltipTriggerMode.longPress,
        showDuration: const Duration(seconds: 2),
        message: toolTip,
        child: GestureDetector(
          onTap: _onPressed,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(icon),
          ),
        ),
      ),
    );
  }

  void _onPressed() {
    if (onPressed != null) {
      onPressed!();
    }
  }
}
