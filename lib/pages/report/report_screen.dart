import 'package:flutter/material.dart';
import 'package:manajemen_aset/in_progress_page.dart';
import 'package:manajemen_aset/pages/report/wind_turbine/wt_report.dart';

class ReportScreen extends StatefulWidget {
  final String idCluster;
  final String docPerangkatId;
  final String jenisPerangkat;
  final String idPerangkat;
  const ReportScreen({
    Key? key,
    required this.docPerangkatId,
    required this.jenisPerangkat,
    required this.idCluster,
    required this.idPerangkat,
  }) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    String jenisPerangkat = widget.jenisPerangkat;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (jenisPerangkat == 'PLTB')
              WtReport(
                docPerangkatId: widget.docPerangkatId,
                idCluster: widget.idCluster,
                idPerangkat: widget.idPerangkat,
              )
            else if (jenisPerangkat == 'PLTS')
              const InProgressPage()
            else if (jenisPerangkat == 'Diesel')
              const InProgressPage()
            else if (jenisPerangkat == 'Baterai')
              const InProgressPage()
            else if (jenisPerangkat == 'Weather Station')
              const InProgressPage()
            else if (jenisPerangkat == 'Rumah Energi')
              const InProgressPage()
          ],
        ),
      ),
    );
  }
}
