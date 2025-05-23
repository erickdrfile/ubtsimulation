import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:ubtsimulation/features/soal_layout_page.dart';

class PreTestPage extends StatefulWidget {
  final String examId;
  const PreTestPage({super.key, required this.examId});

  @override
  State<PreTestPage> createState() => _PreTestPageState();
}

class _PreTestPageState extends State<PreTestPage> {
  List<dynamic> soalList = [];
  int currentIndex = 0;
  List<int?> jawabanUser = []; // index jawaban user, null jika belum dijawab
  final double pointPerSoal = 2.5;

  @override
  void initState() {
    super.initState();
    // Ubah orientasi ke landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    loadSoal();
  }

  Future<void> loadSoal() async {
    final path = 'assets/exam/1/pretest/pre_test_${widget.examId}.json';
    if (kDebugMode) {
      print('Load soal dari: $path');
    } // <-- letakkan di sini
    final data = await rootBundle.loadString(path);
    final jsonData = json.decode(data);
    setState(() {
      soalList = jsonData['soal'];
      jawabanUser = List.filled(soalList.length, null);
    });
  }

  void goToSoal(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void submitJawaban() {
    double totalPoint = 0;
    for (int i = 0; i < soalList.length; i++) {
      if (jawabanUser[i] == soalList[i]['jawaban_benar']) {
        totalPoint += pointPerSoal;
      }
    }
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Hasil'),
            content: Text('Total poin Anda: $totalPoint'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Tutup'),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final soal = soalList.isNotEmpty ? soalList[currentIndex] : null;

    return Scaffold(
      appBar: AppBar(title: Text('Pre Test ${widget.examId}')),
      body:
          soal == null
              ? const Center(child: CircularProgressIndicator())
              : Row(
                children: [
                  // Kiri: Nomor soal
                  Container(
                    width: 100,
                    color: Colors.grey.shade200,
                    child: ListView.builder(
                      itemCount: soalList.length,
                      itemBuilder:
                          (context, index) => ListTile(
                            title: Text('Q${index + 1}'),
                            selected: index == currentIndex,
                            onTap: () => goToSoal(index),
                          ),
                    ),
                  ),
                  // Tengah: Isi soal
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            soal['teks'] ?? '',
                            style: const TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          if (soal['gambar'] != null && soal['gambar'].toString().isNotEmpty)
                            Image.asset(
                              soal['gambar'],
                              height: 160,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Text('Gambar tidak ditemukan'),
                            ),
                          const SizedBox(height: 20),
                          ...List.generate(
                            (soal['pilihan'] as List).length,
                            (i) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    jawabanUser[currentIndex] = i;
                                  });
                                },
                                child: Text(
                                  '${String.fromCharCode(65 + i)}. ${soal['pilihan'][i]}',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: submitJawaban,
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Kanan: Navigasi
                  Container(
                    width: 80,
                    color: Colors.grey.shade100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed:
                              currentIndex > 0
                                  ? () => goToSoal(currentIndex - 1)
                                  : null,
                          child: const Text('Prev'),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed:
                              soalList.isNotEmpty &&
                                      currentIndex < soalList.length - 1
                                  ? () => goToSoal(currentIndex + 1)
                                  : null,
                          child: const Text('Next'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
