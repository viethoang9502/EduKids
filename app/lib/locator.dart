import 'package:Edukids/repository/auth_repository.dart';
import 'package:Edukids/repository/order_repository.dart';
import 'package:Edukids/repository/lesson_repository.dart';
import 'package:Edukids/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  locator
      .registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl());
  locator.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl());
}
