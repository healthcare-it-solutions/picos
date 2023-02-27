import 'package:flutter/material.dart';
import 'package:picos/widgets/picos_body.dart';

/// Creates a standardized page item.
class PicosPageViewItem extends StatefulWidget {
  /// PicosPageViewItem constructor.
  const PicosPageViewItem({
    required this.child,
    Key? key,
  }) : super(key: key);

  /// The body of the page.
  final Widget child;

  @override
  State<PicosPageViewItem> createState() => _PicosPageViewItemState();
}

class _PicosPageViewItemState extends State<PicosPageViewItem>
    with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return PicosBody(
      child: widget.child,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
