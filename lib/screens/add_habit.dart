import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/models/habit.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final TextEditingController habitNameController =
      TextEditingController();

  final TextEditingController habitGoalController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    habitNameController.dispose();
    habitGoalController.dispose();
    super.dispose();
  }

  void saveHabit() {
    if (formKey.currentState!.validate()) {
      Habit newHabit = Habit(
        name: habitNameController.text,
        goal: habitGoalController.text,
        icon: Icons.check_circle_outline,
        streak: "0",
      );

      Navigator.pop(context, newHabit);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade300,
        centerTitle: true,
        title: Text(
          "Add Habit",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(size.width * 0.05),

        child: Form(
          key: formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Habit Name",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: habitNameController,

                decoration: InputDecoration(
                  hintText: "Enter habit name",

                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter habit name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 25),

              Text(
                "Daily Goal",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: habitGoalController,

                decoration: InputDecoration(
                  hintText: "Example: 2 km / 10 pages",

                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter daily goal";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue.shade300,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  onPressed: saveHabit,

                  child: Text(
                    "Save Habit",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}