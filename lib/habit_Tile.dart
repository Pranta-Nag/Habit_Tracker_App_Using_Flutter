import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HabitPage(),
    );
  }
}

class Habit {
  final String name;
  final String sub;
  final IconData icon;
  final String streak;

  Habit({
    required this.name,
    required this.sub,
    required this.icon,
    required this.streak,
  });
}

class HabitPage extends StatefulWidget {
  const HabitPage({super.key});

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {
  List<Habit> habits = [
    Habit(
        name: "Morning Run",
        sub: "Health",
        icon: Icons.directions_run,
        streak: "5"),
    Habit(
        name: "Read Book",
        sub: "Study",
        icon: Icons.book,
        streak: "12"),
    Habit(
        name: "Drink Water",
        sub: "Health",
        icon: Icons.local_drink,
        streak: "20"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Habit Tracker"),
        centerTitle: true,
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
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.delete, color: Colors.white),
            ),

            onDismissed: (direction) {
              setState(() {
                habits.removeAt(index);
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${habit.name} deleted")),
              );
            },

            child: HabitTile(
              habitName: habit.name,
              habitSub: habit.sub,
              icon: habit.icon,
              streakCounter: habit.streak,
            ),
          );
        },
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

    final iconSize =
        isPortrait ? size.width * 0.06 : size.height * 0.05;

    final titleSize =
        isPortrait ? size.width * 0.04 : size.height * 0.03;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: iconSize),
              SizedBox(width: size.width * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habitName,
                    style: GoogleFonts.aladin(
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 40, 56, 65),
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
              Text(
                streakCounter,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                "Done",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}