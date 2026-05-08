import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final Widget? avatar;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isUser,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser && avatar != null) ...[avatar!, const SizedBox(width: 8)],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser ? AppColors.primaryText : AppColors.surface,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isUser ? 20 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 20),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: isUser ? Colors.white : AppColors.primaryText,
                ),
              ),
            ),
          ),
          if (isUser && avatar != null) ...[const SizedBox(width: 8), avatar!],
        ],
      ),
    );
  }
}

class ChatAvatar extends StatelessWidget {
  final double size;

  const ChatAvatar({super.key, this.size = 32});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.glowPurple,
      ),
      child: const Icon(Icons.smart_toy_rounded, size: 18, color: Colors.white),
    );
  }
}
