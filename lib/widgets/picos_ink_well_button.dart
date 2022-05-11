import 'package:flutter/material.dart';

/// A defined button with InkWell animation.
class PicosInkWellButton extends StatelessWidget {
  /// Creates the PicosInkWellButton.
  const PicosInkWellButton({required this.text, required this.onTap, Key? key})
      : super(key: key);

  /// The text shown on the button.
  final String text;

  /// The function to execute on tap.
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final BorderRadius buttonBorderRadius = BorderRadius.circular(7);

    return Padding(
      padding: const EdgeInsets.all(13),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: buttonBorderRadius,
            color: Theme.of(context).colorScheme.secondary,
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
    );
  }
}
