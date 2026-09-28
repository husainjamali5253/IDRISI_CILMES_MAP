import 'package:flutter/material.dart';
import '../models/city.dart';
import '../models/clime.dart';
import '../services/map_data_service.dart';
import 'city_detail_sheet.dart';
import 'clime_drawer.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  final TransformationController _transformationController = TransformationController();
  List<City> _allCities = [];
  List<Clime> _climes = [];
  int? _selectedClime;
  bool _isLoading = true;

  // High-res map dimensions matching the coordinate picker
  static const double imgWidth = 11440.0;
  static const double imgHeight = 5592.0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final cities = await MapDataService.loadCities();
    final climes = await MapDataService.loadClimes();
    setState(() {
      _allCities = cities;
      _climes = climes;
      _isLoading = false;
    });
  }

  List<City> get _filteredCities {
    if (_selectedClime == null) return _allCities;
    return _allCities.where((c) => c.clime == _selectedClime).toList();
  }

  void _zoomToCity(City city) {
    if (city.px == null || city.py == null) return;

    // Convert normalized fractions to actual pixel coordinates
    final double actualX = city.px! * imgWidth;
    final double actualY = city.py! * imgHeight;

    const double zoomLevel = 3.0;
    final double x = -actualX * zoomLevel + (MediaQuery.of(context).size.width / 2);
    final double y = -actualY * zoomLevel + (MediaQuery.of(context).size.height / 2);

    final Matrix4 matrix = Matrix4.identity()
      ..translate(x, y)
      ..scale(zoomLevel);

    setState(() {
      _transformationController.value = matrix;
    });

    _showCityDetails(city);
  }

  void _showCityDetails(City city) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CityDetailSheet(city: city),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedClime == null ? 'Al-Idrisi World Map' : 'Clime $_selectedClime Cities'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search City',
            onPressed: () {
              showSearch(
                context: context,
                delegate: CitySearchDelegate(
                  cities: _allCities,
                  onCitySelected: _zoomToCity,
                ),
              );
            },
          ),
          if (_selectedClime != null)
            IconButton(
              icon: const Icon(Icons.clear),
              tooltip: 'Clear Filter',
              onPressed: () => setState(() => _selectedClime = null),
            ),
        ],
      ),
      drawer: ClimeDrawer(
        climes: _climes,
        selectedClime: _selectedClime,
        onSelectClime: (climeNum) {
          setState(() {
            _selectedClime = climeNum;
          });
        },
      ),
      body: InteractiveViewer(
        transformationController: _transformationController,
        maxScale: 20.0,
        minScale: 0.05,
        child: Center(
          child: SizedBox(
            width: imgWidth,
            height: imgHeight,
            child: Stack(
              children: [
                Image.asset(
                  'assets/maps/idrisi_map.jpg',
                  width: imgWidth,
                  height: imgHeight,
                  fit: BoxFit.fill,
                ),
                ..._filteredCities.where((c) => c.px != null && c.py != null).map((city) {
                  return Positioned(
                    left: (city.px! * imgWidth) - 20,
                    top: (city.py! * imgHeight) - 40,
                    child: GestureDetector(
                      onTap: () => _showCityDetails(city),
                      child: Tooltip(
                        message: city.name,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.amber,
                          size: 40,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CitySearchDelegate extends SearchDelegate<City?> {
  final List<City> cities;
  final Function(City) onCitySelected;

  CitySearchDelegate({required this.cities, required this.onCitySelected});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildSearchResults();

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchResults();

  Widget _buildSearchResults() {
    final results = cities.where((city) {
      final q = query.toLowerCase();
      return city.name.toLowerCase().contains(q) || city.arabicName.contains(q);
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final city = results[index];
        final bool isPinned = city.px != null && city.py != null;

        return ListTile(
          title: Text(city.name),
          subtitle: Text('${city.arabicName} • Clime ${city.clime}'),
          trailing: isPinned
              ? const Icon(Icons.my_location, color: Colors.amber)
              : const Text('Not Pinned', style: TextStyle(color: Colors.grey, fontSize: 12)),
          onTap: () {
            close(context, city);
            if (isPinned) {
              onCitySelected(city);
            }
          },
        );
      },
    );
  }
}