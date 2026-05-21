import 'package:go_router/go_router.dart';
import 'package:habit_app/screens/add_habit.dart';
import 'package:habit_app/widgets/navbar.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>const Navbar(),
    ),
    GoRoute(
      path:'/add-habit', 
      builder: (context, state) =>const AddHabitScreen(),),
  ],
);
