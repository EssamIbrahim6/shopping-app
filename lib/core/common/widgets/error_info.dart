import 'package:flutter/material.dart';

class ErrorInfo extends StatelessWidget {
  const ErrorInfo({
    super.key,
    required this.title,
    required this.description,
    this.btnText,
    required this.press,
    this.showRetryButton = true,
  });

  final String title;
  final String description;
  final String? btnText;
  final VoidCallback press;
  final bool showRetryButton;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(description, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            if (showRetryButton)
              TextButton(
                onPressed: press,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: Text(btnText ?? "Retry".toUpperCase()),
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
