import 'package:flutter/material.dart';
import 'package:pamp_mobile/core/theme/app_pallete.dart';

class DeliverableCard extends StatelessWidget {
  final String groupName;
  final String deliveryDate;
  final bool isDelivered;
  final int compliance;
  final int similarity;

  const DeliverableCard({
    super.key,
    required this.groupName,
    required this.deliveryDate,
    this.isDelivered = true,
    required this.compliance,
    required this.similarity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  groupName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Delivery Date : $deliveryDate',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isDelivered ? 'Delivered' : 'Not Delivered',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDelivered ? AppPalette.green : AppPalette.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Compliance : $compliance%',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Similarity : $similarity%',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
