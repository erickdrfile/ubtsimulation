import 'package:flutter/material.dart';

class UbtSimulationPage extends StatelessWidget {
  const UbtSimulationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exams = List.generate(10, (index) => 'Exam ${index + 1}');

    return Scaffold(
      appBar: AppBar(title: const Text('Pemahaman Soal & UBT Simulation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Pre-Test, Post-Test & UBT Simulation',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // TODO: Navigate to CBT Simulation
              },
              child: const Text('CBT SIMULATION'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: exams.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(exams[index], style: const TextStyle(fontSize: 16)),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue[100],
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              // TODO: Navigate to Pre-Test Page
                            },
                            child: const Text("Pre-Test"),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[300],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              // TODO: Navigate to Post-Test Page
                            },
                            child: const Text("Post-Test"),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
