import 'package:bom_front/model/user.dart';
import 'package:bom_front/provider/general_provider.dart';
import 'package:bom_front/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<theUser, User>((ref) {
  final userData = ref.read(userRepository);
  return theUser(userData, ref);
});

class theUser extends StateNotifier<User>{
  late final UserRepository _repository;
  final ref;

  theUser(this._repository, this.ref, [User? initState]) : super(User()){
    getUser();
  }

  Future<void> getUser() async{
    final user = await _repository.loadUser(); // final todos = await _repository!.loadTodos();
    if(mounted) { // check data
      state = user;
    }
  }
}