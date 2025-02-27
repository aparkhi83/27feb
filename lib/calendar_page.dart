import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

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
      home: const CalendarPage(),
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final Map<DateTime, List<String>> _events = {};
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  bool _isAnimating = false;

  @override
  Widget build(BuildContext context) {
    final selectedEvents = _events[_selectedDay] ?? [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Calendar'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.lock),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminPage(
                    events: _events,
                    onUpdate: (updatedEvents) {
                      setState(() {
                        _events.clear();
                        _events.addAll(updatedEvents);
                      });
                      Navigator.pop(context); // Refresh UI on return
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2024, 1, 1),
            lastDay: DateTime(2028, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
                _focusedDay = focusedDay;
                _isAnimating = true;
              });
              Future.delayed(const Duration(milliseconds: 300), () {
                setState(() {
                  _isAnimating = false;
                });
              });
              print("Loaded events for $_selectedDay: ${_events[_selectedDay]}");
            },
            eventLoader: (day) {
              final normalizedDate = DateTime(day.year, day.month, day.day);
              return _events[normalizedDate] ?? [];
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: _isAnimating
                ? const Center(child: CircularProgressIndicator(color: Colors.teal))
                : selectedEvents.isEmpty
                ? const Center(child: Text('No events for this day.'))
                : ListView.builder(
              itemCount: selectedEvents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(selectedEvents[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AdminPage extends StatefulWidget {
  final Map<DateTime, List<String>> events;
  final Function(Map<DateTime, List<String>>) onUpdate;

  const AdminPage({super.key, required this.events, required this.onUpdate});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _eventController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final String _adminPassword = "admin123";
  bool _isAuthenticated = false;

  void _authenticate(String password) {
    if (password == _adminPassword) {
      setState(() {
        _isAuthenticated = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin - Assign Events')),
      body: _isAuthenticated
          ? Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2024, 1, 1),
            lastDay: DateTime(2028, 12, 31),
            focusedDay: _selectedDate,
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
              });
            },
            calendarFormat: CalendarFormat.month,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _eventController,
              decoration: const InputDecoration(labelText: 'Event Name'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_eventController.text.isNotEmpty) {
                final normalizedDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
                setState(() {
                  widget.events.putIfAbsent(normalizedDate, () => []);
                  widget.events[normalizedDate]!.add(_eventController.text);
                  widget.onUpdate(widget.events);
                });
                print("Event added on $normalizedDate: ${widget.events[normalizedDate]}");
                _eventController.clear();
              }
            },
            child: const Text('Add Event'),
          ),
        ],
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Enter Admin Password'),
          TextField(
            obscureText: true,
            onSubmitted: _authenticate,
          ),
        ],
      ),
    );
  }
}
