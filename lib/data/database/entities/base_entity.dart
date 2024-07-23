import 'package:floor/floor.dart';

class BaseEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'createTime')
  final String createdAt;

  @ColumnInfo(name: 'updateTime')
  final String updatedAt;

  BaseEntity({
    this.id,
    String? createdAt,
    String? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now().toString(),
        updatedAt = updatedAt ?? DateTime.now().toString();
}
