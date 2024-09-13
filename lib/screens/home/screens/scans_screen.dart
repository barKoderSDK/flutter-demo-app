import 'package:barkoder/screens/home/widgets/scan_detail_popup.dart';
import 'package:barkoder/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class RecentScansScreen extends StatefulWidget {
  final List<Map<String, String>> recentScans;

  const RecentScansScreen({super.key, required this.recentScans});

  @override
  RecentScansScreenState createState() => RecentScansScreenState();
}

class RecentScansScreenState extends State<RecentScansScreen> {
  void _exportToCSV() {
    final csvData = widget.recentScans.map((scan) => '${scan['name']},${scan['type']}').join('\n');
    Share.share(csvData, subject: 'Exported CSV');
  }

  void _removeAllScans(BuildContext context) {
    setState(() {
      widget.recentScans.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All scans removed')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recent Scans',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColor.mainRed,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings, color: Colors.white),
            onSelected: (value) {
              if (value == 'export_csv') {
                _exportToCSV();
              } else if (value == 'remove_all') {
                _removeAllScans(context);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'export_csv',
                child: Text('Export to CSV'),
              ),
              const PopupMenuItem<String>(
                value: 'remove_all',
                child: Text('Remove all', style: TextStyle(color: AppColor.mainRed)),
              ),
            ],
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: widget.recentScans.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey.shade400,
          height: 1.0,
        ),
        itemBuilder: (context, index) {
          final scan = widget.recentScans[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
            leading: SizedBox(
              width: 40.0,
              height: 40.0,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  'assets/icon_placeholder.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            title: Text(scan['name']!, style: const TextStyle(fontSize: 14.0)),
            subtitle: Text(scan['type']!, style: const TextStyle(fontSize: 12.0)),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ScanDetailPopup(
                    name: scan['name']!,
                    type: scan['type']!,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
