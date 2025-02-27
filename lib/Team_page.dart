import 'package:flutter/material.dart';
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
      home: const TeamPage(isDarkMode: false),
    );
  }
}

class TeamPage extends StatelessWidget {
  final bool isDarkMode;
  const TeamPage({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    // Function to generate members
    List<Map<String, String>> generateMembers(int count) {
      return List.generate(count, (index) {
        return {
          "name": "Mike Hawk",
          "designation": "Noob",
          "photo": "assets/images/pfps/${(index % 10) + 1}.jpg"
        };
      });
    }

    // Categorized team members
    final List<Map<String, String>> adminCore = generateMembers(8);
    final List<Map<String, String>> executiveCore = generateMembers(15);
    final List<Map<String, String>> auxCore = generateMembers(8);
    final List<Map<String, String>> executiveMembers = generateMembers(20);

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.white12 : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Members List"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          categorySection("Admin Core", adminCore),
          categorySection("Executive Core", executiveCore),
          categorySection("Aux Core", auxCore),
          categorySection("Executive Members", executiveMembers),
        ],
      ),
    );
  }

  Widget categorySection(String title, List<Map<String, String>> members) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...members.map((member) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(member["photo"]!),
              ),
              title: Text(
                member["name"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(member["designation"]!),
            ),
          );
        }).toList(),
      ],
    );
  }
}
