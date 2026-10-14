import 'package:flutter/material.dart';

extension PopupExtension on BuildContext {
  Future<void> showSuccessDialog({
    required String message,
    String confirmText = 'OK',
    VoidCallback? onConfirm,
    IconData? icon,
    Color? iconColor,
  }) {
    return showDialog<void>(
      context: this,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? Icons.check_circle,
              color: iconColor ?? Theme.of(context).colorScheme.primary,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm?.call();
              },
              child: Text(confirmText),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showErrorDialog({
    required String message,
    String confirmText = 'OK',
    VoidCallback? onConfirm,
    IconData? icon,
  }) {
    return showDialog<void>(
      context: this,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm?.call();
              },
              child: Text(confirmText),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showLoadingDialog({
    String message = 'Loading...',
    bool barrierDismissible = false,
  }) {
    return showDialog<void>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Flexible(child: Text(message)),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> showConfirmationDialog({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool dangerousAction = false,
  }) async {
    return await showDialog<bool>(
          context: this,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(cancelText),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  confirmText,
                  style: dangerousAction
                      ? TextStyle(color: Theme.of(context).colorScheme.error)
                      : null,
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  void showSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError
            ? Theme.of(this).colorScheme.errorContainer
            : null,
        action: action,
      ),
    );
  }
}
