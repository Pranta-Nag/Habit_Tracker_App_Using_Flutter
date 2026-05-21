import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HabitTile extends StatefulWidget {
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
  State<HabitTile> createState() => _HabitTileState();
}

class _HabitTileState extends State<HabitTile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(size.width * 0.03),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 239, 237),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.shade50,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                widget.icon,
                size: size.width * 0.06,
                color: Colors.lightBlue,
              ),

              SizedBox(width: size.width * 0.04),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.habitName,
                    style: GoogleFonts.akshar(
                      fontSize: size.width * 0.040,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    widget.habitGoal,
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
                widget.streakCounter,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
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