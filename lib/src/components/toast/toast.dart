// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

enum ToastType {
  success,
  alert,
  failure,
}

class ToastComponent extends StatelessWidget {
  final String message;
  final ToastType toastType;

  const ToastComponent({
    Key? key,
    required this.message,
    required this.toastType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: toastType == ToastType.success
            ? Colors.green.withOpacity(0.8)
            : toastType == ToastType.alert
                ? Colors.orange.withOpacity(0.8)
                : Colors.red.withOpacity(0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check, color: Colors.white),
          const SizedBox(
            width: 12.0,
          ),
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
