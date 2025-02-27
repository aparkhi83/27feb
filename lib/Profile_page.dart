import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const ProfilePage(isDarkMode: false),
    );
  }
}


class ProfilePage extends StatelessWidget {
  final bool isDarkMode;
  const ProfilePage({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(

        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data?.data() as Map<String, dynamic>?;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person, size: 50),
                ),
                const SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.person_outline),
                          title: const Text('Name'),
                          subtitle: Text(userData?['name'] ?? 'Not set'),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.numbers),
                          title: const Text('Roll Number'),
                          subtitle: Text(userData?['rollNo'] ?? 'Not set'),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.email_outlined),
                          title: const Text('Email'),
                          subtitle: Text(userData?['email'] ?? 'Not set'),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.calendar_month_rounded),
                          title: const Text('Date of Birth'),
                          subtitle: Text(userData?['dob'] ?? 'Not set'),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.calendar_today_sharp),
                          title: const Text('Year of Graduation'),
                          subtitle: Text(userData?['year'] ?? 'Not set'),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.book_online_rounded),
                          title: const Text('SIG'),
                          subtitle: Text(userData?['sig'] ?? 'Not set'),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.phone_android_sharp),
                          title: const Text('Phone Number'),
                          subtitle: Text(userData?['phone'] ?? 'Not set'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}