import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/bottom_navigation_widget.dart';
import '../../viewmodel/reports_viewmodel.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReportsViewModel>(context, listen: false)
          .fetchReports(widget.promotion);
    });
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
                    child: const Text('Réessayer'),
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
      bottomNavigationBar: const BottomNavigationWidget(currentIndex: 1),
    );
  }
}
