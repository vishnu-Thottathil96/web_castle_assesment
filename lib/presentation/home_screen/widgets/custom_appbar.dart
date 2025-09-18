import 'package:flutter/material.dart';
import 'package:flutter_template/core/util/responsive_util.dart';

class CustomAppBarSection extends StatelessWidget {
  final String username;
  final VoidCallback onNotificationTap;
  final VoidCallback onScanTap;

  const CustomAppBarSection({
    super.key,
    required this.username,
    required this.onNotificationTap,
    required this.onScanTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // keep stable background
      padding:
          ResponsiveHelper.scalePadding(context, horizontal: 18, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Row with Welcome text + Notification
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: "Welcome, ",
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                  children: [
                    TextSpan(
                      text: username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(text: "!"),
                  ],
                ),
              ),
              IconButton(
                onPressed: onNotificationTap,
                icon: const Icon(Icons.notifications_none),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Row with Search + Scan
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: "Search..",
                      border: InputBorder.none,
                      icon: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: onScanTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                label: const Text(
                  "Scan Here",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
