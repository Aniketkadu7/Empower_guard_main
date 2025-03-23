import 'package:flutter/material.dart';
import '../models/complaint.dart';
import '../widgets/custom_drawer.dart';

class NearbyComplaintsScreen extends StatefulWidget {
  const NearbyComplaintsScreen({Key? key}) : super(key: key);

  @override
  State<NearbyComplaintsScreen> createState() => _NearbyComplaintsScreenState();
}

class _NearbyComplaintsScreenState extends State<NearbyComplaintsScreen> {
  final List<Complaint> _complaints = [
    Complaint(
      id: '1',
      title: 'Suspicious person near park',
      description: 'A suspicious person was seen loitering around the children\'s playground for several hours.',
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
      location: 'Central Park, Main Entrance',
      latitude: 40.785091,
      longitude: -73.968285,
      status: 'Under Investigation',
    ),
    Complaint(
      id: '2',
      title: 'Street lights not working',
      description: 'The street lights on Oak Avenue have been out for a week, making it unsafe to walk at night.',
      dateTime: DateTime.now().subtract(const Duration(days: 3)),
      location: 'Oak Avenue',
      latitude: 40.781091,
      longitude: -73.965285,
      status: 'Reported',
    ),
    Complaint(
      id: '3',
      title: 'Harassment incident',
      description: 'A woman was verbally harassed by a group of men outside the shopping mall.',
      dateTime: DateTime.now().subtract(const Duration(days: 2)),
      location: 'Downtown Mall',
      latitude: 40.789091,
      longitude: -73.961285,
      status: 'Under Investigation',
    ),
    Complaint(
      id: '4',
      title: 'Attempted theft',
      description: 'Someone tried to snatch a woman\'s purse near the subway station.',
      dateTime: DateTime.now().subtract(const Duration(hours: 12)),
      location: 'Metro Station',
      latitude: 40.782091,
      longitude: -73.972285,
      status: 'Resolved',
    ),
  ];

  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Recent', 'Resolved', 'Under Investigation'];

  List<Complaint> get _filteredComplaints {
    switch (_selectedFilter) {
      case 'Recent':
        return _complaints
            .where((complaint) => complaint.dateTime.isAfter(DateTime.now().subtract(const Duration(days: 2))))
            .toList();
      case 'Resolved':
        return _complaints.where((complaint) => complaint.status == 'Resolved').toList();
      case 'Under Investigation':
        return _complaints.where((complaint) => complaint.status == 'Under Investigation').toList();
      default:
        return _complaints;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Complaints'),
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Complaints in Your Area',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Stay informed about incidents reported nearby',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
            
            // Filter chips
            SizedBox(
              height: 50,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = _selectedFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            
            // Complaints list
            Expanded(
              child: _filteredComplaints.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No complaints found',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.grey[600],
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try changing the filter or check back later',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey[500],
                                ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _filteredComplaints.length,
                      itemBuilder: (context, index) {
                        final complaint = _filteredComplaints[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    _buildStatusIndicator(complaint.status),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        complaint.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  complaint.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        complaint.location,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _formatDate(complaint.dateTime),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton.icon(
                                      icon: const Icon(Icons.map, size: 16),
                                      label: const Text('View on Map'),
                                      onPressed: () {
                                        // Navigate to map view
                                      },
                                    ),
                                    TextButton.icon(
                                      icon: const Icon(Icons.info_outline, size: 16),
                                      label: const Text('Details'),
                                      onPressed: () {
                                        // Show complaint details
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/complaint_form');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatusIndicator(String status) {
    Color color;
    switch (status) {
      case 'Resolved':
        color = Colors.green;
        break;
      case 'Under Investigation':
        color = Colors.orange;
        break;
      case 'Reported':
        color = Colors.blue;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
}

