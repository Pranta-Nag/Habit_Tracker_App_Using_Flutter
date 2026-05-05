import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HabitApp(),
    );
  }
}

class HabitApp extends StatelessWidget {
  const HabitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 233, 229, 232),
        elevation: 0,
        title: Text("Habit Tracker", style: GoogleFonts.abel()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          HabitTile(
            habitName: "Drink Water",
            habitSub: "3 glasses",
            icon: Icons.water_drop_outlined,
          ),
          HabitTile(
            habitName: "Read a Book",
            habitSub: "10 pages",
            icon: Icons.book_outlined,
          ),
          HabitTile(
            habitName: "Morning Run",
            habitSub: "2 km",
            icon: Icons.directions_run,
          ),
          HabitTile(
            habitName: "Exercise",
            habitSub: "30 mins",
            icon: Icons.run_circle_outlined,
          ),
          HabitTile(
            habitName: "Meditate",
            habitSub: "10 mins",
            icon: Icons.mediation,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HabitTile extends StatelessWidget {
  final String habitName;
  final String habitSub;
  final IconData icon;

  const HabitTile({
    super.key,
    required this.habitName,
    required this.habitSub,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 30),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habitName,
                    style:GoogleFonts.abel(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ), 
                  Text(
                    habitSub,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 157, 251, 152)),
                  ),
                ],
              ),
            ],
          ),
         const Icon(Icons.check_circle_outline, color: Color.fromARGB(255, 193, 208, 242)),
        ],
      ),
    );
  }
}
