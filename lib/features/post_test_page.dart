import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ubtsimulation/features/soal_layout_page.dart';

class PostTestPage extends StatelessWidget {
  final String examId;
  const PostTestPage({super.key, required this.examId});

  @override
  Widget build(BuildContext context) {
    // Ubah orientasi ke landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return SoalLayoutPage(title: "Post Test $examId", mode: 'posttest');
  }
}
