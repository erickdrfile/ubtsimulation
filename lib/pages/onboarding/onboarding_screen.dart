import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/onboard1.png",
      "title": "Belajar EPS-TOPIK Lebih Mudah & Terarah",
      "desc":
          "Pelajari Bahasa Korea untuk kerja di Korea dengan cara yang sistematis, efisien, dan menyenangkan",
    },
    {
      "image": "assets/images/onboard2.png",
      "title": "Materi Terstruktur & Mudah Dipahami",
      "desc":
          "Pahami setiap bab dengan penjelasan lenhgkap, terjemahan per kata, dan konteks penggunaan asli",
    },
    {
      "image": "assets/images/onboard3.png",
      "title": "Hafal Kosakata & Tata Bahasa Secara Efektif",
      "desc":
          "Gunakan flashcard pintar & latihan interaktif untuk hafalan tahan lama",
    },
    {
      "image": "assets/images/onboard4.png",
      "title": "Latihan Soal & Pemahaman",
      "desc":
          "Jawab soal seperti di ujian asli dan pahami alasan benar-salah serta tips cepat menjawab soal",
    },
    {
      "image": "assets/images/onboard5.png",
      "title": "UBT Simulation",
      "desc":
          "Rasakan pengalaman mengerjakan ujian dengan sistem yang sama seperti di HRDK EPS-Center",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              setState(() => onLastPage = index == onboardingData.length - 1);
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(onboardingData[index]['image']!, height: 250),
                    const SizedBox(height: 30),
                    Text(
                      onboardingData[index]['title']!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      onboardingData[index]['desc']!,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 60,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text("Lewati"),
                  onPressed:
                      () => _controller.jumpToPage(onboardingData.length - 1),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: onboardingData.length,
                  effect: const WormEffect(dotHeight: 10, dotWidth: 10),
                ),
                TextButton(
                  child: const Text("Lanjut"),
                  onPressed:
                      () => _controller.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      ),
                ),
              ],
            ),
          ),
          if (onLastPage)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(60),
                ),
                onPressed: () {
                  // Solusi paling aman untuk GoRouter + PageView
                  // ignore: use_build_context_synchronously
                  Future.microtask(() => context.go('/login'));
                },
                child: const Text("Mulai Sekarang"),
              ),
            ),
        ],
      ),
    );
  }
}
