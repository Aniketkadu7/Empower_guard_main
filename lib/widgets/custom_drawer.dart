import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Color(0xFF6A1B9A),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Jane Doe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'jane.doe@example.com',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Tracked Loved Ones'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/tracked_loved_ones');
            },
          ),
          ListTile(
            leading: const Icon(Icons.share_location),
            title: const Text('Share Location'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/share_location');
            },
          ),
          ListTile(
            leading: const Icon(Icons.report_problem),
            title: const Text('File Complaint'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/complaint_form');
            },
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Nearby Complaints'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/nearby_complaints');
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_police),
            title: const Text('Police Stations'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/police_stations');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}

