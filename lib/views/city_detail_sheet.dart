import 'package:flutter/material.dart';
import '../models/city.dart';

class CityDetailSheet extends StatelessWidget {
  final City city;

  const CityDetailSheet({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    city.name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  city.arabicName,
                  style: const TextStyle(fontSize: 22, color: Colors.amber, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text('Clime ${city.clime}'),
              backgroundColor: Colors.amber.withOpacity(0.2),
            ),
            const Divider(height: 24),
            const Text(
              'Historical Significance',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            const SizedBox(height: 6),
            Text(
              city.history,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 16),
            const Text(
              'Al-Idrisi Map Navigation Hint',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            const SizedBox(height: 6),
            Text(
              city.idrisiHint,
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white70),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.public, size: 16, color: Colors.white54),
                const SizedBox(width: 6),
                Text(
                  'Modern Coordinates: ${city.modernLat}° N, ${city.modernLng}° E',
                  style: const TextStyle(fontSize: 12, color: Colors.white54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}