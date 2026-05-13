import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/add_habit.dart';
import 'package:habit_app/habit_Tile.dart';

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
        backgroundColor: Colors.lightBlue.shade300,
        shadowColor: Colors.amberAccent.shade200,
        elevation: 0,
        title: Text(
          "Habit Tracker",
          style: GoogleFonts.aclonica(color: Colors.black),
        ),
      ),

      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return ListView(
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.03,
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddHabitScreen()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 221, 218, 218),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}

