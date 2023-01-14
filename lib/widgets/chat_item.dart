import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({Key? key}) : super(key: key);

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
                  color: const Color(0xFFABDBD5).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  "You diuwhdu dshduhsi suidhsuhdu s dgysgiudhiu",
                  style: TextStyle(
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
