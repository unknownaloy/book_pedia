import 'package:book_pedia/services/database_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<DatabaseService>(
    () => DatabaseService(),
  );
}
