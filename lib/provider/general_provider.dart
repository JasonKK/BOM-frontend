import 'package:bom_front/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/plan_repository.dart';

final todoRepository = Provider.family<TodoRepository, DateTime>((_, day) => TodoRepository(day));
final userRepository = Provider((_) => UserRepository());