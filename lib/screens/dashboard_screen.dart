import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/models/habit.dart';
import 'package:habit_app/widgets/habit_tile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Habit> habits = [
    Habit(
      name: "Drink Water",
      goal: "3 Glasses",
      icon: Icons.water_drop_outlined,
      streak: "2",
    ),
    Habit(
      name: "Morning Run",
      goal: "2 KM",
      icon: Icons.directions_run,
      streak: "5",
    ),
    Habit(
      name: "Read Book",
      goal: "10 Pages",
      icon: Icons.menu_book_outlined,
      streak: "8",
    ),
    Habit(
      name: "Meditation",
      goal: "30 Minutes",
      icon: Icons.self_improvement_outlined,
      streak: "4",
    ),
    Habit(
      name: "Exercise",
      goal: "30 Minutes",
      icon: Icons.sports_gymnastics_outlined,
      streak: "3",
    ),
  ];

  Future<void> addHabit() async {
    final Habit? newHabit = await context.push<Habit>(
      '/add-habit',
    );

    if (newHabit != null) {
      setState(() {
        habits.add(newHabit);
      });
    }
  }

  void deleteHabit(int index) {
    final deletedHabit = habits[index];

    setState(() {
      habits.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("${deletedHabit.name} deleted"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 212, 241),
      appBar: AppBar(
        title:const Text(
          "Habit Tracker",
        ),
      ),
      body: habits.isEmpty
          ? Center(    
              child: Text(
                "No Habits Added",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: habits.length,
              itemBuilder: (context, index) {
                final habit = habits[index];

                return Dismissible(
                  key: ValueKey(habit.name),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (_) => deleteHabit(index),
                  child: HabitTile(
                    habitName: habit.name,
                    habitGoal: habit.goal,
                    icon: habit.icon,
                    streakCounter: habit.streak,
                  ),
                );
              },
            ),
        floatingActionButton: FloatingActionButton(
        focusColor: const Color.fromARGB(255, 193, 244, 234),
        backgroundColor: const Color.fromARGB(255, 232, 237, 239),
        onPressed: addHabit,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
