import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/monitoring/produksi_energi_chart.dart';

class ProduksiEnergiScreen extends StatefulWidget {
  final String idCluster;
  const ProduksiEnergiScreen({Key? key, required this.idCluster})
      : super(key: key);

  @override
  State<ProduksiEnergiScreen> createState() => _ProduksiEnergiScreenState();
}

class _ProduksiEnergiScreenState extends State<ProduksiEnergiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(225, 12, 144, 125),
        elevation: 0,
        title: const Text('Produksi Energi (kWh)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProduksiEnergiChart(
          idCluster: widget.idCluster,
        ),
      ),
    );
  }
}
