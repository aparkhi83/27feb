import 'package:flutter/material.dart';
import 'package:tired/screen/signin.dart';
import 'package:tired/change.dart';
import 'package:tired/calendar_page.dart';
import 'Profile_page.dart';
import 'Team_page.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
          titleMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const ISTEApp(),
    );
  }
}


class ISTEApp extends StatefulWidget {
  const ISTEApp({super.key});

  @override
  _ISTEAppState createState() => _ISTEAppState();
}

class _ISTEAppState extends State<ISTEApp> {
  int currentIndex = 0;
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
      final currentPages = [
        LandingPage(isDarkMode: isDarkMode),
        CalendarPage(),
        TeamPage(isDarkMode: isDarkMode),
        ProfilePage(isDarkMode: isDarkMode),
        MoreOptionsPage(isDarkMode: isDarkMode)
      ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Center(
          child: Text(
            'ISTE : NITK',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.more_vert_rounded,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                 MoreOptionsPage(isDarkMode: isDarkMode),
              ),
            );
          },
        ),
        shape: Border(
          bottom: BorderSide(
            color: isDarkMode ? Colors.white : Colors.black,
            width: 1.0,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: isDarkMode?Colors.white12:Colors.white,
        ),
        child: currentPages[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        selectedItemColor: isDarkMode ? Colors.white : Colors.black,
        unselectedItemColor: isDarkMode ? Colors.white70 : Colors.black54,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Team',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  final bool isDarkMode;
  const ChatPage({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {


    return Center(
      child: Text(
        'New chats here!',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class MoreOptionsPage extends StatelessWidget {
  final bool isDarkMode;
  const MoreOptionsPage({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'More Options',
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      body: ListView(
        children: [
          Divider(color: isDarkMode ? Colors.white : Colors.black),
          ListTile(
            leading: Icon(
              Icons.lock,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            title: Text(
              'Change Password',
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangePasswordScreen(),
                ),
              );
            },
          ),
          Divider(color: isDarkMode ? Colors.white : Colors.black),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            title: Text(
              'Log Out',
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignInScreen(),
                ),
              );
            },
          ),
          Divider(color: isDarkMode ? Colors.white : Colors.black),
        ],
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  final bool isDarkMode;
  const LandingPage({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: isDarkMode ? Colors.white : Colors.black,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: isDarkMode ? Colors.black : Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'ABHIMANYU BINU',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    'CRYPT',
                    style: TextStyle(
                      fontSize: 18,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  Text(
                    'NUB',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Text(
              'UPCOMING EVENTS:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 16),
            EventBox(
              title: 'Dec 2: ISTE Meet the new recruits!',
              isDarkMode: isDarkMode,
            ),
            EventBox(
              title: 'Dec 5: ISTE CRYPT : Meet\'n Greet',
              isDarkMode: isDarkMode,
            ),
            SizedBox(height: 32),
            Text(
              'NOTIFICATIONS:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 16),
            NotificationBox(
              sender: 'Ansh',
              message: 'Be there on time!',
              isDarkMode: isDarkMode,
            ),
            NotificationBox(
              sender: 'Harsh',
              message: 'RR on December 6 bois!',
              isDarkMode: isDarkMode,
            ),
          ],
        ),
      ),
    );
  }
}

class EventBox extends StatelessWidget {
  final String title;
  final bool isDarkMode;

  const EventBox({super.key, required this.title, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black54 : Colors.grey,
            offset: Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class NotificationBox extends StatelessWidget {
  final String sender;
  final String message;
  final bool isDarkMode;

  const NotificationBox({super.key,
    required this.sender,
    required this.message,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDarkMode?Colors.white12:Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black54 : Colors.grey,
            offset: Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
            child: Text(
              sender[0],
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              '$sender: $message',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class ChangePasswordPage extends StatelessWidget {
  final bool isDarkMode;
  const ChangePasswordPage({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
          'Change Password',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(

        child: Text(
          'Here you can change your password!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}