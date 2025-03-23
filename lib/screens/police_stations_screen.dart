import 'package:flutter/material.dart';
import '../models/police_station.dart';
import '../widgets/custom_drawer.dart';

class PoliceStationsScreen extends StatefulWidget {
  const PoliceStationsScreen({Key? key}) : super(key: key);

  @override
  State<PoliceStationsScreen> createState() => _PoliceStationsScreenState();
}

class _PoliceStationsScreenState extends State<PoliceStationsScreen> {
  final List<PoliceStation> _policeStations = [
    PoliceStation(
      id: '1',
      name: 'Central Police Station',
      address: '123 Main Street, Downtown',
      phone: '911',
      latitude: 40.785091,
      longitude: -73.968285,
      distance: 0.8,
    ),
    PoliceStation(
      id: '2',
      name: 'Westside Police Department',
      address: '456 Oak Avenue, Westside',
      phone: '911',
      latitude: 40.781091,
      longitude: -73.965285,
      distance: 1.2,
    ),
    PoliceStation(
      id: '3',
      name: 'Eastside Police Station',
      address: '789 Pine Street, Eastside',
      phone: '911',
      latitude: 40.789091,
      longitude: -73.961285,
      distance: 2.5,
    ),
    PoliceStation(
      id: '4',
      name: 'Northside Police Department',
      address: '101 Maple Road, Northside',
      phone: '911',
      latitude: 40.782091,
      longitude: -73.972285,
      distance: 3.7,
    ),
  ];

  bool _isMapView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearest Police Stations'),
        actions: [
          IconButton(
            icon: Icon(_isMapView ? Icons.list : Icons.map),
            onPressed: () {
              setState(() {
                _isMapView = !_isMapView;
              });
            },
            tooltip: _isMapView ? 'List View' : 'Map View',
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: _isMapView
            ? _buildMapView()
            : _buildListView(),
      ),
    );
  }

  Widget _buildMapView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.map,
            size: 100,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Map View',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'Map integration would be implemented here',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isMapView = false;
              });
            },
            child: const Text('Switch to List View'),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nearest Police Stations',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Find police stations near your current location',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _policeStations.length,
            itemBuilder: (context, index) {
              final station = _policeStations[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.local_police,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  station.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${station.distance} km away',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              station.address,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            station.phone,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            icon: const Icon(Icons.directions, size: 16),
                            label: const Text('Directions'),
                            onPressed: () {
                              // Open maps app with directions
                            },
                          ),
                          TextButton.icon(
                            icon: const Icon(Icons.phone, size: 16),
                            label: const Text('Call'),
                            onPressed: () {
                              // Make a phone call
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

