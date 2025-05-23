import 'package:flutter/material.dart';

class SoalLayoutPage extends StatelessWidget {
  final String title;
  final String mode;

  const SoalLayoutPage({super.key, required this.title, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Kiri: Nomor soal (Grid)
          Container(
            width: 100,
            color: Colors.grey.shade200,
            child: ListView.builder(
              itemCount: 40,
              itemBuilder:
                  (context, index) => ListTile(
                    title: Text('Q${index + 1}'),
                    onTap: () {
                      // Navigasi antar soal
                    },
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
                    '$title - Mode: $mode',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Placeholder(fallbackHeight: 200),
                  const SizedBox(height: 10),
                  const Text('Isi soal di sini...'),
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
                ElevatedButton(onPressed: () {}, child: const Text('Prev')),
                const SizedBox(height: 10),
                ElevatedButton(onPressed: () {}, child: const Text('Next')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
