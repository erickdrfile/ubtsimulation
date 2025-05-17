import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'
    show CarouselOptions, CarouselSlider;
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentCarousel = 0;

  final List<String> carouselImages = [
    'assets/images/carousel/img1.jpg',
    'assets/images/carousel/img2.jpg',
    'assets/images/carousel/img3.jpg',
    'assets/images/carousel/img4.jpg',
    'assets/images/carousel/img5.jpg',
    'assets/images/carousel/img6.jpg',
    'assets/images/carousel/img7.jpg',
    'assets/images/carousel/img8.jpg',
    'assets/images/carousel/img9.jpg',
  ];

  final List<Map<String, dynamic>> featureItems = [
    {"icon": "assets/images/icons/institusi.png", "label": "Khusus\nLembaga"},
    {"icon": "assets/images/icons/modul.png", "label": "Modul dasar"},
    {
      "icon": "assets/images/icons/textbook.png",
      "label": "Textbook\nEps-topik",
    },
    {"icon": "assets/images/icons/kosakata.png", "label": "Kosakata"},
    {"icon": "assets/images/icons/grammar.png", "label": "Tata bahasa"},
    {
      "icon": "assets/images/icons/speaking.png",
      "label": "Pengucapan\n& Ungkapan",
    },
    {"icon": "assets/images/icons/budaya.png", "label": "Budaya\n& Informasi"},
    {
      "icon": "assets/images/icons/ubt.png",
      "label": "Pemahaman soal\n& UBT Simulation",
    },
    {
      "icon": "assets/images/icons/skema.png",
      "label": "Informasi\n& Skema g to g",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "EPS-TOPIK DIGITAL LEARNING",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(child: Text("Pengaturan")),
            ListTile(title: Text("Bantuan")),
            ListTile(title: Text("Logout")),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profil Header
            ListTile(
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/icons/user.png"),
              ),
              title: const Text(
                "Nama/email",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("Status member"),
              trailing: TextButton(
                onPressed: () {},
                child: const Text("Log Out"),
              ),
            ),

            // Carousel
            CarouselSlider(
              items:
                  carouselImages
                      .map(
                        (path) => ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            path,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      )
                      .toList(),
              options: CarouselOptions(
                height: 180,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                onPageChanged: (index, reason) {
                  setState(() => _currentCarousel = index);
                },
              ),
            ),

            // Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  carouselImages.asMap().entries.map<Widget>((entry) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 4.0,
                      ),
                      child: SizedBox(
                        width: 8,
                        height: 8,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                _currentCarousel == entry.key
                                    ? Colors.blue
                                    : Colors.grey,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),

            // Grid Menu
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: featureItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final item = featureItems[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      if (item['label'].contains("UBT")) {
                        context.go('/ubt-simulation');
                      }
                      // TODO: Tambahkan else if untuk fitur lain
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade100,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(item['icon'], height: 50),
                          const SizedBox(height: 8),
                          Text(
                            item['label'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
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
