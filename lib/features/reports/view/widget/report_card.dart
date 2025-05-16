import 'package:flutter/material.dart';
import 'package:pamp_mobile/core/theme/app_pallete.dart';

class ReportCard extends StatelessWidget {
  final String groupName;
  final String deliveryDate;
  final VoidCallback onReadReport;
  final VoidCallback onGiveNote;

  const ReportCard({
    super.key,
    required this.groupName,
    required this.deliveryDate,
    required this.onReadReport,
    required this.onGiveNote,
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
                ElevatedButton(
                  onPressed: onReadReport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPalette.yellow,
                    foregroundColor: AppPalette.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    minimumSize: const Size(0, 0),
                  ),
                  child: const Text('Read Report'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery Date : $deliveryDate',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                ElevatedButton(
                  onPressed: onGiveNote,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPalette.purple,
                    foregroundColor: AppPalette.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    minimumSize: const Size(0, 0),
                  ),
                  child: const Text('Give A Note'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
