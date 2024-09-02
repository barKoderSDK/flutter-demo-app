import 'package:barkoder/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        flexibleSpace: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/backgrounds/bg-header.png',
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: 80,
              left: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/logos/bkdr-logo.png',
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'What would you like to scan?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 32,
              left: 8,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Positioned(
              top: 32,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.help, color: Colors.white),
                onPressed: () async {
                  final Uri url =
                      Uri.parse('https://www.barkoder.com/register');
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Curabitur pretium urna a felis laoreet, nec vehicula justo efficitur. '
              'Quisque ut metus at elit euismod consequat.',
              style: TextStyle(fontSize: 13.0),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Vivamus lacinia odio in risus consectetur, vel fermentum justo egestas. '
              'Phasellus vehicula leo sit amet ante tincidunt, in cursus dui venenatis. '
              'Maecenas ac ante ut dolor scelerisque sollicitudin.',
              style: TextStyle(fontSize: 13.0),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Sed nec nunc id ipsum congue tincidunt. Integer sed libero tincidunt, '
              'volutpat lacus ac, tristique lacus. Donec a varius mauris, eget posuere '
              'libero. Donec laoreet dui eget ligula suscipit, a tincidunt elit cursus.',
              style: TextStyle(fontSize: 13.0),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final Uri url =
                      Uri.parse('https://www.barkoder.com/register');
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.mainRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 24.0),
                ),
                child: const Text(
                  'Test barKoder SDK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: const Center(
                child: Text(
                  'Device id: 34SF74GJE48343',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'barKoder SDK version 1.3.1',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Changelog',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'v1.7.8',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '- Implemented barKoder SDK v1.3.1.\n- Various small bug fixes and performance enhancements.',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'v1.7.7',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '- Implemented barKoder SDK v1.2.11.\n- Various small bug fixes and performance enhancements.',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'v1.7.6',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '- Implemented barKoder SDK v1.2.10.\n- Added section for displaying device id in About screen.\n- Various small bug fixes and performance enhancements.',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final Uri url =
                          Uri.parse('https://www.barkoder.com');
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.mainRed, width: 1.0),
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      child: const Center(
                        child: Text(
                          'Learn more',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.mainRed,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final Uri url =
                          Uri.parse('https://www.barkoder.com/privacy-policy');
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.mainRed, width: 1.0),
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      child: const Center(
                        child: Text(
                          'Privacy policy',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.mainRed,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final Uri url =
                          Uri.parse('https://www.barkoder.com/terms-of-use');
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.mainRed, width: 1.0),
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      child: const Center(
                        child: Text(
                          'Terms of Use',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.mainRed,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
