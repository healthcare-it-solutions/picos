import 'package:flutter/material.dart';

/// A defined button with InkWell animation.
class PicosInkWellButton extends StatelessWidget {
  /// Creates the PicosInkWellButton.
  const PicosInkWellButton(
      {required this.text,
      required this.onTap,
      this.disabled = false,
      Key? key})
      : super(key: key);

  /// The text shown on the button.
  final String text;

  /// The function to execute on tap.
  final void Function() onTap;

  /// Disables the button.
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final BorderRadius buttonBorderRadius = BorderRadius.circular(7);
    Color buttonColor = Theme.of(context).colorScheme.secondary;

    if (disabled) {
      buttonColor = Theme.of(context).disabledColor;
    }

    return Padding(
      padding: const EdgeInsets.all(13),
      child: Material(
        color: Colors.transparent,
        child: AbsorbPointer(
          absorbing: disabled,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: buttonBorderRadius,
              color: buttonColor,
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: buttonBorderRadius,
              child: SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
