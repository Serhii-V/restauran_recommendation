import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/menu_item_dto.dart';
import '../../domain/entities/menu_item.dart';

abstract class MenuLocalDataSource {
  Future<List<MenuItem>> getMenuItems();
}

class MenuLocalDataSourceImpl implements MenuLocalDataSource {
  @override
  Future<List<MenuItem>> getMenuItems() async {
    final String response = await rootBundle.loadString(
      'assets/menu/menu.json',
    );
    final data = await json.decode(response) as List;
    return data
        .map((item) => MenuItemDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
