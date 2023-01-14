import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  const ChatItem(
      {Key? key, required this.message, required this.isSentByCurrentUser})
      : super(key: key);
  final String message;
  final bool isSentByCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 2,
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 32,
            height: 24,
          ),
          Flexible(
            child: IntrinsicWidth(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isSentByCurrentUser
                      ? const Color(0xFFABDBD5).withOpacity(0.15)
                      : const Color(0xFFF8F9FB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
