import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:manajemen_aset/models/report_wt.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:http/http.dart' as http;

class WtTabelMonthly extends StatefulWidget {
  final String idPerangkat;
  const WtTabelMonthly({Key? key, required this.idPerangkat}) : super(key: key);

  @override
  State<WtTabelMonthly> createState() => _WtTabelMonthlyState();
}

class _WtTabelMonthlyState extends State<WtTabelMonthly> {
  DateTime? _monthTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchData(DateFormat('yyyy-MM').format(_monthTime!), widget.idPerangkat);
  }

  // menampilkan month picker
  void _showMonthPicker() {
    showMonthPicker(
      context: context,
      initialDate: _monthTime!,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((value) {
      setState(() {
        _monthTime = value!;
        _monthTime = _monthTime;
        fetchData(
            DateFormat('yyyy-MM').format(_monthTime!), widget.idPerangkat);
      });
    });
  }

  Future<ReportWt> fetchData(String date, String id) async {
    Uri url = Uri.parse(
        "https://ebt-polinema.id/api/cluster/wind-turbine/report-monthly");
    var response = await http.post(
      url,
      body: {"id": id, "date_month": date},
    );
    if (response.statusCode == 200) {
      return ReportWt.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        monthPicker(),
        // table
        FutureBuilder<ReportWt>(
          future: fetchData(
            DateFormat('yyyy-MM').format(_monthTime!),
            widget.idPerangkat,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final reportWt = snapshot.data!;
                return Table(
                  defaultColumnWidth: const FixedColumnWidth(150),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.all(
                    width: 1.0,
                    color: const Color.fromARGB(225, 18, 149, 117),
                  ),
                  children: [
                    // rpm generator
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'RPM Generator Max \n(rpm)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            reportWt.maxRpmGenerator.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),

                    // rpm bilah
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'RPM Bilah Max \n(rpm)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            reportWt.maxRpmBilah.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),

                    // prod kwh
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Prod kwh \n(kWh)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            reportWt.prodKwh.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),

                    // prod kwh
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Daya (P) Max \n(Watt)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            reportWt.maxWatt.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),

                    // Tegangan Max (Volt)
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Tegangan Max \n(Volt)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            reportWt.maxVolt.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),

                    // Arus Max (Ampere)
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Arus Max \n(Ampere)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            reportWt.maxAmpere.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),

                    // Wind Sped Max (m/s)
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Wind Sped Max \n(m/s)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            reportWt.maxWindSpeed.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),

                    // Wind Speed Avg (m/s)
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Wind Speed Avg \n(m/s)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            reportWt.avgWindSpeed.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }
            }
          },
        ),
      ],
    );
  }

  Row monthPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            const Icon(Iconsax.calendar_1),
            const SizedBox(
              width: 16,
            ),
            Text(
              _monthTime == null
                  ? DateFormat('MM/yyyy').format(DateTime.now())
                  : DateFormat('MM/yyyy').format(_monthTime!),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            IconButton(
              onPressed: () async {
                _showMonthPicker();
              },
              icon: const Icon(Iconsax.arrow_down_1),
            ),
          ],
        ),
      ],
    );
  }
}
