import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ubtsimulation/features/soal_layout_page.dart';

class EpsTopikPage extends StatelessWidget {
  const EpsTopikPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ubah orientasi ke landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return const SoalLayoutPage(title: 'CBT Simulation', mode: 'cbt');
  }
}
