import 'package:flutter/material.dart';
import 'package:muslim/core/custom_color.dart';

class DividerCustom extends StatelessWidget {
  const DividerCustom({
    super.key,
    this.thickness = 3.0,
    this.color = primaryColor,
    this.indent = 0.0,
    this.endIndent = 0.0,
  });

  final double thickness;
  final Color color;
  final double indent;
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
