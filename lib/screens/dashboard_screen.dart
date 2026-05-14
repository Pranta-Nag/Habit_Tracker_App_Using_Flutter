import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/models/habit.dart';
import 'package:habit_app/screens/add_habit.dart';
import 'package:habit_app/widgets/habit_tile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Habit> habits = [
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
  ];

  Future<void> addHabit() async {
    final Habit? newHabit = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddHabitScreen(),
      ),
    );

    if (newHabit != null) {
      setState(() {
        habits.add(newHabit);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue.shade300,

        title: Text(
          "Habit Tracker",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: habits.length,

        itemBuilder: (context, index) {
          final habit = habits[index];

          return Dismissible(
            key: Key(habit.name),

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

            onDismissed: (direction) {
              setState(() {
                habits.removeAt(index);
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${habit.name} deleted"),
                ),
              );
            },

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
        backgroundColor: Colors.lightBlue.shade300,

        onPressed: addHabit,

        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}