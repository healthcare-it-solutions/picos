import 'package:flutter/material.dart';

/// Creates a standardized section for the overview.
class Section extends StatelessWidget {
  /// Section constructor.
  const Section({required this.child, Key? key, this.title, this.titleColor})
      : super(key: key);

  /// Title for the section.
  final String? title;

  /// The content for the section.
  final Widget child;

  /// The color for the title.
  final Color? titleColor;

  static const Color _standardTitleColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              title ?? '',
              style: TextStyle(
                color: titleColor ?? _standardTitleColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            color: titleColor ?? _standardTitleColor,
            height: 1,
          ),
          const SizedBox(
            height: 20,
          ),
          child,
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
