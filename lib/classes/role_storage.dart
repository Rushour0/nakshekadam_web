import 'package:flutter_chat_types/flutter_chat_types.dart';

class RoleStorage {
  RoleStorage._internal();
  static final RoleStorage _roleStorage = RoleStorage._internal();
  static Role _role = Role.counsellor;

  static set setRole(Role role) => _role = role;

  static Role get role => _role;

  factory RoleStorage() => _roleStorage;
}
