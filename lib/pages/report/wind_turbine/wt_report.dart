import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_aset/pages/report/wind_turbine/wt_tabel_daily.dart';
import 'package:manajemen_aset/pages/report/wind_turbine/wt_table_monthly.dart';
import 'package:manajemen_aset/service/database.dart';

class WtReport extends StatefulWidget {
  final String docPerangkatId;
  final String idCluster;
  final String idPerangkat;
  const WtReport({
    Key? key,
    required this.docPerangkatId,
    required this.idCluster,
    required this.idPerangkat,
  }) : super(key: key);

  @override
  State<WtReport> createState() => _WtReportState();
}

class _WtReportState extends State<WtReport>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16, 16.0, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // id asset
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Center(
                child: Text(
                  '0604001',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(225, 18, 149, 117),
                  ),
                ),
              ),
            ),

            // mekanik
            ExpansionTileCard(
              elevation: 0,
              shadowColor: Colors.transparent,
              title: const Text(
                'Spek Dasar Mekanik',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                  color: Color.fromARGB(225, 18, 149, 117),
                ),
              ),
              children: [
                const Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                StreamBuilder(
                  stream: DatabaseService()
                      .listMekanik(widget.idCluster, widget.docPerangkatId),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    } else if (snapshot.hasData || snapshot.data != null) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final documentSnapshot = snapshot.data!.docs[index];
                            // final String mekanikId =
                            //     snapshot.data!.docs[index].id;
                            // String id = documentSnapshot['id'] ?? "-";
                            String spd11 = documentSnapshot['spd11'] ?? "-";
                            String spd12 = documentSnapshot['spd12'] ?? "-";
                            String spd13 = documentSnapshot['spd13'] ?? "-";

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'SPD 1.1: $spd11',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'SPD 1.2: $spd12',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'SPD 1.3: $spd13',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: const [
                                      Text(
                                        "Kondisi Aset: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Icon(
                                        Icons.square,
                                        color: Colors.green,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Rekomendasi: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Table(
                                        defaultColumnWidth:
                                            const FixedColumnWidth(20),
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        border: TableBorder.all(
                                          width: 1.0,
                                        ),
                                        children: const [
                                          TableRow(children: [
                                            Text(
                                              " 0 ",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ])
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(thickness: 1)
                              ],
                            );
                          },
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

            // elektrik
            ExpansionTileCard(
              elevation: 0,
              shadowColor: Colors.transparent,
              title: const Text(
                'Spek Dasar Elektrik',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                  color: Color.fromARGB(225, 18, 149, 117),
                ),
              ),
              children: [
                const Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                StreamBuilder(
                  stream: DatabaseService()
                      .listElektrik(widget.idCluster, widget.docPerangkatId),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    } else if (snapshot.hasData || snapshot.data != null) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final documentSnapshot = snapshot.data!.docs[index];
                            // final String mekanikId =
                            //     snapshot.data!.docs[index].id;
                            // String id = documentSnapshot['id'] ?? "-";
                            String spd21 = documentSnapshot['spd21'] ?? "-";
                            String spd22 = documentSnapshot['spd22'] ?? "-";
                            String spd23 = documentSnapshot['spd23'] ?? "-";

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'SPD 2.1: $spd21',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'SPD 2.2: $spd22',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'SPD 1.3: $spd23',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: const [
                                      Text(
                                        "Kondisi Aset: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Icon(
                                        Icons.square,
                                        color: Colors.green,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Rekomendasi: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Table(
                                        defaultColumnWidth:
                                            const FixedColumnWidth(20),
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        border: TableBorder.all(
                                          width: 1.0,
                                        ),
                                        children: const [
                                          TableRow(children: [
                                            Text(
                                              " 0 ",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ])
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(thickness: 1)
                              ],
                            );
                          },
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

            // sipil
            ExpansionTileCard(
              elevation: 0,
              shadowColor: Colors.transparent,
              title: const Text(
                'Spek Dasar Sipil',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                  color: Color.fromARGB(225, 18, 149, 117),
                ),
              ),
              children: [
                const Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                StreamBuilder(
                  stream: DatabaseService()
                      .listSipil(widget.idCluster, widget.docPerangkatId),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    } else if (snapshot.hasData || snapshot.data != null) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final documentSnapshot = snapshot.data!.docs[index];
                            // final String mekanikId =
                            //     snapshot.data!.docs[index].id;
                            // String id = documentSnapshot['id'] ?? "-";
                            String spd61 = documentSnapshot['spd61'] ?? "-";
                            String spd62 = documentSnapshot['spd62'] ?? "-";

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'SPD 6.1: $spd61',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'SPD 6.2: $spd62',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: const [
                                      Text(
                                        "Kondisi Aset: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Icon(
                                        Icons.square,
                                        color: Colors.green,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Rekomendasi: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Table(
                                        defaultColumnWidth:
                                            const FixedColumnWidth(20),
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        border: TableBorder.all(
                                          width: 1.0,
                                        ),
                                        children: const [
                                          TableRow(children: [
                                            Text(
                                              " 0 ",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ])
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(thickness: 1)
                              ],
                            );
                          },
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

            // Tab Bar
            TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black54,
              indicator: const BubbleTabIndicator(
                indicatorHeight: 33,
                indicatorColor: Color.fromARGB(225, 18, 149, 117),
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
                indicatorRadius: 30,
              ),
              labelPadding: const EdgeInsets.only(right: 15, left: 15),
              tabs: const [
                Tab(
                  child: Text(
                    'Harian',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                Tab(
                  child: Text(
                    'Bulanan',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),

            // Tab View
            SizedBox(
              width: double.infinity,
              height: 600,
              child: TabBarView(
                controller: _tabController,
                children: [
                  WtTabelDaily(idPerangkat: widget.idPerangkat),
                  WtTabelMonthly(idPerangkat: widget.idPerangkat),
                ],
              ),
            ),

            // DataTable(columns: <DataColumn>[
            //   DataColumn(label: Text("Dessert (100g serving)")),
            //   DataColumn(label: Text("Calories")),
            //   DataColumn(label: Text("Fat (g)")),
            //   DataColumn(label: Text("Protein (g)")),
            // ], rows: rows)
          ],
        ),
      ),
    );
  }
}
