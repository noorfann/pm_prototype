import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

enum PopupType { success, failed }

class PopupHelper {
  static void showGeneralPopup(
    BuildContext context, {
    required String title,
    String? desc,
    PopupType type = PopupType.success,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero, // Remove default padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    (type == PopupType.success)
                        ? 'assets/lotties/success.json'
                        : 'assets/lotties/failed.json',
                    repeat: false,
                    width: 120,
                    height: 120,
                  ),
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  if (desc != null) ...[
                    verticalSpacing(10),
                    Text(desc, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                  verticalSpacing(20),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
