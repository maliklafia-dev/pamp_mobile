import 'package:flutter/material.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/bottom_navigation_widget.dart';

class NotationsPlaceholderPage extends StatelessWidget {
  const NotationsPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notations'),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit_note,
              size: 64,
              color: AppPalette.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Fonctionnalité de notation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppPalette.darkGrey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Cette fonctionnalité sera disponible prochainement',
              style: TextStyle(
                fontSize: 14,
                color: AppPalette.darkGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(currentIndex: 0),
    );
  }
}
