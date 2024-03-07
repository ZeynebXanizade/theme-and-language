import 'package:flutter/material.dart';

class MaterialWidget extends StatefulWidget {
  final Icon icon;
  final void Function()? onTap;
  final String text;

  const MaterialWidget({
    super.key,
    required this.icon,
    this.onTap,
    required this.text,
  });

  @override
  State<MaterialWidget> createState() => _MaterialWidgetState();
}

class _MaterialWidgetState extends State<MaterialWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: InkWell(
          onTap: widget.onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ignore: avoid_unnecessary_containers
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: widget.icon,
                    ),
                    Text(
                      widget.text,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.chevron_right_rounded)),
            ],
          ),
        ),
      ),
    );
  }
}
