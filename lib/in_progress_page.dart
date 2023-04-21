import 'package:flutter/material.dart';

class InProgressPage extends StatefulWidget {
  const InProgressPage({Key? key}) : super(key: key);

  @override
  State<InProgressPage> createState() => _InProgressPageState();
}

class _InProgressPageState extends State<InProgressPage> {
  @override
  Widget build(BuildContext context) {
    return Image.asset('img/In-progress.png');
  }
}
