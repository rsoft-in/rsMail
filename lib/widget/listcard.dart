import 'package:flutter/material.dart';

class ListCard extends StatefulWidget {
  const ListCard(
      {Key? key, required this.title, required this.subtitle, this.onTap})
      : super(key: key);
  final String title;
  final String subtitle;
  final Function? onTap;

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
      ),
      subtitle: Text(
        widget.subtitle,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      onTap: () => widget.onTap!(),
    );
  }
}
