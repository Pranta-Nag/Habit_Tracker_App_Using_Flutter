// Better Code

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HabitApp(),
    );
  }
}

// ── Model ────────────────────────────────────────────────────────────────────

class Habit {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  bool isCompletedToday;
  int streak;

  Habit({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    this.isCompletedToday = false,
    this.streak = 0,
  });
}

// ── Main Screen ──────────────────────────────────────────────────────────────

class HabitApp extends StatefulWidget {
  const HabitApp({super.key});

  @override
  State<HabitApp> createState() => _HabitAppState();
}

class _HabitAppState extends State<HabitApp> {
  final List<Habit> _habits = [
    Habit(id: '1', name: 'Morning Run',    icon: Icons.directions_run,  color: Colors.orange,      streak: 5),
    Habit(id: '2', name: 'Read 30 mins',   icon: Icons.menu_book,       color: Colors.blue,        streak: 12),
    Habit(id: '3', name: 'Drink Water',    icon: Icons.water_drop,      color: Colors.cyan,        streak: 3),
    Habit(id: '4', name: 'Meditate',       icon: Icons.self_improvement, color: Colors.purple,     streak: 7),
    Habit(id: '5', name: 'Sleep by 11 PM', icon: Icons.bedtime,         color: Colors.indigo,      streak: 2),
  ];

  final _nameController = TextEditingController();

  int get _completedCount => _habits.where((h) => h.isCompletedToday).length;

  void _toggleHabit(Habit habit) {
    setState(() {
      habit.isCompletedToday = !habit.isCompletedToday;
      habit.streak += habit.isCompletedToday ? 1 : -1;
    });
  }

  void _addHabit(String name) {
    if (name.trim().isEmpty) return;
    setState(() {
      _habits.add(Habit(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name.trim(),
        icon: Icons.star,
        color: Colors.teal,
      ));
    });
    _nameController.clear();
  }

  void _deleteHabit(String id) {
    setState(() => _habits.removeWhere((h) => h.id == id));
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('New Habit'),
        content: TextField(
          controller: _nameController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'e.g. Drink water',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (v) {
            _addHabit(v);
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              _addHabit(_nameController.text);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = _habits.isEmpty ? 0.0 : _completedCount / _habits.length;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // ── AppBar ──────────────────────────────────────────────────────────
      appBar: AppBar(
        title: const Text('Habit Tracker',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // ── Body ────────────────────────────────────────────────────────────
      body: Column(
        children: [
          // Progress header
          _ProgressHeader(
            completed: _completedCount,
            total: _habits.length,
            progress: progress,
          ),

          // Habit list
          Expanded(
            child: _habits.isEmpty
                ? const _EmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    itemCount: _habits.length,
                    itemBuilder: (_, i) => _HabitCard(
                      habit: _habits[i],
                      onToggle: () => _toggleHabit(_habits[i]),
                      onDelete: () => _deleteHabit(_habits[i].id),
                    ),
                  ),
          ),
        ],
      ),

      // ── FAB ─────────────────────────────────────────────────────────────
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDialog,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Habit'),
      ),
    );
  }
}

// ── Progress Header Widget ───────────────────────────────────────────────────

class _ProgressHeader extends StatelessWidget {
  final int completed;
  final int total;
  final double progress;

  const _ProgressHeader({
    required this.completed,
    required this.total,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            completed == total && total > 0
                ? '🎉 All done for today!'
                : "Today's Progress",
            style: const TextStyle(
                color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            '$completed / $total habits',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.white24,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Habit Card Widget ────────────────────────────────────────────────────────

class _HabitCard extends StatelessWidget {
  final Habit habit;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const _HabitCard({
    required this.habit,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(habit.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDelete(),
      child: GestureDetector(
        onTap: onToggle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: habit.isCompletedToday
                ? habit.color.withOpacity(0.15)
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: habit.isCompletedToday ? habit.color : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Row(
            children: [
              // Icon circle
              CircleAvatar(
                backgroundColor: habit.color.withOpacity(0.2),
                child: Icon(habit.icon, color: habit.color, size: 22),
              ),
              const SizedBox(width: 14),

              // Name & streak
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habit.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        decoration: habit.isCompletedToday
                            ? TextDecoration.lineThrough
                            : null,
                        color: habit.isCompletedToday
                            ? Colors.grey
                            : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.local_fire_department,
                            size: 14, color: Colors.deepOrange),
                        const SizedBox(width: 3),
                        Text(
                          '${habit.streak} day streak',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Checkbox
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  key: ValueKey(habit.isCompletedToday),
                  habit.isCompletedToday
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: habit.isCompletedToday ? habit.color : Colors.grey,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Empty State ──────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.playlist_add, size: 72, color: Colors.grey),
          SizedBox(height: 12),
          Text('No habits yet!',
              style: TextStyle(fontSize: 18, color: Colors.grey)),
          SizedBox(height: 4),
          Text('Tap "+ Add Habit" to get started.',
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}