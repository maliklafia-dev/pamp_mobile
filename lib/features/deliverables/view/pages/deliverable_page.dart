import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pamp_mobile/features/deliverables/view/widgets/deliverable_card.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../viewmodel/deliverable_viewmodel.dart';

class DeliverablesPage extends StatefulWidget {
  final String promotion;
  final String projectName;
  final String deadline;

  const DeliverablesPage({
    super.key,
    required this.promotion,
    required this.projectName,
    required this.deadline,
  });

  @override
  State<DeliverablesPage> createState() => _DeliverablesPageState();
}

class _DeliverablesPageState extends State<DeliverablesPage> {
  int _selectedIndex = 1; // Projects tab selected by default

  @override
  void initState() {
    super.initState();
    // Fetch deliverables when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DeliverablesViewModel>(context, listen: false)
          .fetchDeliverables(widget.promotion);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation based on the selected tab
    if (index == 0) {
      // Navigate to Notations
    } else if (index == 2) {
      // Navigate to Profile
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DeliverablesViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.promotion),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.projectName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Deadline : ${widget.deadline}',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.error != null
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    viewModel.error!,
                    style: const TextStyle(color: AppPalette.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.fetchDeliverables(widget.promotion);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: viewModel.deliverables.length,
              itemBuilder: (context, index) {
                final deliverable = viewModel.deliverables[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: DeliverableCard(
                    groupName: deliverable.groupName,
                    deliveryDate: DateFormat('dd/MM/yy')
                        .format(deliverable.deliveryDate),
                    isDelivered: deliverable.isDelivered,
                    compliance: deliverable.compliance,
                    similarity: deliverable.similarity,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note),
            label: 'Notations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
