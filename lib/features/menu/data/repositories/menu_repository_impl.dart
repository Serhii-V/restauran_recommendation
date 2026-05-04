import '../../domain/entities/menu_item.dart';
import '../../domain/repositories/menu_repository.dart';
import '../datasources/menu_local_datasource.dart';

class MenuRepositoryImpl implements MenuRepository {
  final MenuLocalDataSource localDataSource;

  MenuRepositoryImpl({required this.localDataSource});

  @override
  Future<List<MenuItem>> getMenuItems() async {
    return await localDataSource.getMenuItems();
  }
}
