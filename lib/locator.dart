import 'package:app_ecommerce_setup/routes/app_route.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<AppRoute>(() => AppRoute());
}
