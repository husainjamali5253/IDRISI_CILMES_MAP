import 'package:flutter/material.dart';
import '../models/clime.dart';

class ClimeDrawer extends StatelessWidget {
  final List<Clime> climes;
  final int? selectedClime;
  final ValueChanged<int?> onSelectClime;

  const ClimeDrawer({
    super.key,
    required this.climes,
    required this.selectedClime,
    required this.onSelectClime,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.amber),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nuzhat al-Mushtāq',
                  style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Filter by Seven Climes (الأقاليم)',
                  style: TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.public),
            title: const Text('Show All Climes'),
            selected: selectedClime == null,
            onTap: () {
              onSelectClime(null);
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ...climes.map((clime) {
            return ExpansionTile(
              leading: CircleAvatar(
                backgroundColor: selectedClime == clime.number ? Colors.amber : Colors.grey.shade800,
                child: Text('${clime.number}', style: const TextStyle(color: Colors.white)),
              ),
              title: Text('${clime.name} (${clime.arabicName})'),
              subtitle: Text(clime.bounds, style: const TextStyle(fontSize: 11)),
              trailing: IconButton(
                icon: const Icon(Icons.filter_alt_outlined),
                onPressed: () {
                  onSelectClime(clime.number);
                  Navigator.pop(context);
                },
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    clime.description,
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}