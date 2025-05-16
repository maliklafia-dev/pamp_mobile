import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pamp_mobile/core/theme/app_pallete.dart';
import 'package:pamp_mobile/features/reports/viewmodel/reports_viewmodel.dart';
import 'package:intl/intl.dart';
import '../widget/report_card.dart';

class ReportsPage extends StatefulWidget {
  final String promotion;
  final String projectName;
  final String deadline;

  const ReportsPage({
    super.key,
    required this.promotion,
    required this.projectName,
    required this.deadline,
  });

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  int _selectedIndex = 1; // Projects tab selected by default

  @override
  void initState() {
    super.initState();
    // Fetch reports when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReportsViewModel>(context, listen: false)
          .fetchReports(widget.promotion);
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
    final viewModel = Provider.of<ReportsViewModel>(context);

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
                      viewModel.fetchReports(widget.promotion);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: viewModel.reports.length,
              itemBuilder: (context, index) {
                final report = viewModel.reports[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ReportCard(
                    groupName: report.groupName,
                    deliveryDate: DateFormat('dd/MM/yy')
                        .format(report.deliveryDate),
                    onReadReport: () {
                      viewModel.readReport(report.id);
                    },
                    onGiveNote: () {
                      viewModel.giveNote(report.id);
                    },
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
