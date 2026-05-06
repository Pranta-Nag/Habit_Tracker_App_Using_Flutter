import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const HabitApp(),
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
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Habit Tracker",
          style: GoogleFonts.abel(color: Colors.black),
        ),
      ),

      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return ListView(
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.04,
              ),
              children: const [
                HabitTile(
                  habitName: "Drink Water",
                  habitSub: "3 glasses",
                  icon: Icons.water_drop_outlined,
                  streakCounter: "2 times",
                ),
                HabitTile(
                  habitName: "Read a Book",
                  habitSub: "10 pages",
                  icon: Icons.menu_book_outlined,
                  streakCounter: "2 times",
                ),
                HabitTile(
                  habitName: "Morning Run",
                  habitSub: "2 km",
                  icon: Icons.directions_run,
                  streakCounter: "2 times",
                ),
                HabitTile(
                  habitName: "Exercise",
                  habitSub: "30 mins",
                  icon: Icons.fitness_center,
                  streakCounter: "3 times",
                ),
                HabitTile(
                  habitName: "Meditate",
                  habitSub: "10 mins",
                  icon: Icons.self_improvement,
                  streakCounter: "4 times",
                ),
              ],
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}

class HabitTile extends StatelessWidget {
  final String habitName;
  final String habitSub;
  final IconData icon;
  final String streakCounter;

  const HabitTile({
    super.key,
    required this.habitName,
    required this.habitSub,
    required this.icon,
    required this.streakCounter,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    double iconSize =
        isPortrait ? size.width * 0.06 : size.height * 0.05;

    double titleSize =
        isPortrait ? size.width * 0.035 : size.height * 0.04;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),

      child: isPortrait
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, size: iconSize),
                    SizedBox(width: size.width * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          habitName,
                          style: GoogleFonts.abel(
                            fontSize: titleSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          habitSub,
                          style: const TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(streakCounter),
                    const Text("Done"),
                  ],
                ),
              ],
            )

          // LANDSCAPE LAYOUT
          : Column(
              children: [
                Icon(icon, size: iconSize),
                const SizedBox(height: 10),
                Text(
                  habitName,
                  style: GoogleFonts.abel(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  habitSub,
                  style: const TextStyle(color: Colors.green),
                ),
                const SizedBox(height: 10),
                Text(streakCounter),
                const Text("Done"),
              ],
            ),
    );
  }
}