import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final bool withCloseButton;
  const HeaderWidget({
    super.key,
    required this.title,
    this.withCloseButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.all(8),
      child: (!withCloseButton)
          ? Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        visualDensity: VisualDensity.compact,
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.outline),
                      ),
                      onPressed: () {
                        context.pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 20,
                      )),
                  horizontalSpacing(),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
    );
  }
}
