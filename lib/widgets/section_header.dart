import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    Key? key,
    required this.title,
    this.action='View more'

  }) : super(key: key);
  final String title;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold,color: Colors.white),
        ),
        Text(action,style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold,color: Colors.white),)
      ],
    );
  }
}