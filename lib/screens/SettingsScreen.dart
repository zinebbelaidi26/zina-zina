import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:projet_signe/screens/about_us.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool pushNotifications = false;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? Colors.black : Colors.white,
      body: Column(
        children: [
          // HEADER
          Container(
            color: Color(0xFF1664F3),
            padding: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 20),
            child: Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.settings, color: Colors.white, size: 40),
                    SizedBox(width: 8),
                    Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()), // pour prendre l'espace restant
                GestureDetector(
                  onTap: () {},
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 24),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/profilpage');
                    },
                  ),
                ),
              ],
            ),
          ),

          // PROFILE
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            color: darkMode ? Colors.black : Colors.white,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(
                    'images/edf.PNG',
                  ), // replace with your avatar
                ),
                SizedBox(height: 8),
                Text(
                  'Mon Nom',
                  style: TextStyle(
                    fontSize: 25,
                    color: darkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.25,
            color: Colors.grey,
            margin: EdgeInsets.only(top: 16, bottom: 8),
          ),
          // SETTINGS OPTIONS
          Expanded(
            child: ListView(
              children: [
                // Account Settings
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 0, 4),
                  child: Text(
                    'Account Settings',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    'Edit profile',
                    style: TextStyle(
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.of(context).pushNamed('/editprofile');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.lock),
                  title: Text(
                    'Privacy',
                    style: TextStyle(
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.of(context).pushNamed('/changhe');
                  },
                ),
                SwitchListTile(
                  title: Text(
                    'Push notifications',
                    style: TextStyle(
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  value: pushNotifications,
                  onChanged: (bool value) {
                    setState(() {
                      pushNotifications = value;
                    });
                  },
                  activeColor: Color(0xFF1664F3),
                ),
                SwitchListTile(
                  /* title: Text('Dark mode'),
                  value: darkMode,
                  onChanged: (bool value) {
                    setState(() {
                      darkMode = value;
                    });
                  },
                  activeColor: Color(0xFF1664F3),
                ),*/
                  title: Text(
                    'Dark mode',
                    style: TextStyle(
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  value: darkMode,
                  onChanged: (bool value) {
                    setState(() {
                      darkMode = value;
                    });
                  },
                  activeColor: Color(0xFF1664F3),
                ),
                Container(
                  height: 0.25,
                  color: Colors.grey,
                  margin: EdgeInsets.only(top: 16, bottom: 8),
                ),
                // More
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 4),
                  child: Text(
                    'More',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
                ListTile(
                  title: Text(
                    'About us',
                    style: TextStyle(
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.of(context).pushNamed('/about_us');
                  },
                ),
                ListTile(
                  title: Text(
                    'Terms and conditions',
                    style: TextStyle(
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.of(context).pushNamed('/terms_and_condition');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    'log out',
                    style: TextStyle(
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.of(context).pushNamed('/');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
