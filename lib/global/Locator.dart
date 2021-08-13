import 'package:chat/repository_impl/AuthRepository_impl.dart';
import 'package:chat/repository_impl/ChatRepository_impl.dart';
import 'package:chat/repository_impl/UserRepository_impl.dart';
import 'package:chat/services/AuthServices.dart';
import 'package:chat/services/ChatServices.dart';
import 'package:chat/services/UserServices.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AuthServices>(AuthServices());
  getIt.registerSingleton<UserServices>(UserServices());
  getIt.registerSingleton<ChatServices>(ChatServices());

  getIt.registerSingleton<AuthRepository_Impl>(AuthRepository_Impl());
  getIt.registerSingleton<UserRepository_Impl>(UserRepository_Impl());
  getIt.registerSingleton<ChatRepository_impl>(ChatRepository_impl());
}
