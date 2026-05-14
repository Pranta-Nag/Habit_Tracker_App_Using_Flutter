import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final String habitGoal;
  final IconData icon;
  final String streakCounter;

  const HabitTile({
    super.key,
    required this.habitName,
    required this.habitGoal,
    required this.icon,
    required this.streakCounter,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(size.width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: size.width * 0.06,
                color: Colors.lightBlue,
              ),

              SizedBox(width: size.width * 0.04),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habitName,
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.035,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    habitGoal,
                    style: GoogleFonts.poppins(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ],
          ),

          Column(
            children: [
              Text(
                streakCounter,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const Text(
                "Done",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}