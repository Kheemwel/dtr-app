import 'package:floor/floor.dart';

class BaseEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'createTime')
  final String createTime;

  @ColumnInfo(name: 'updateTime')
  final String updateTime;

  BaseEntity({
    this.id,
    String? createTime,
    String? updateTime,
  })  : createTime = createTime ?? DateTime.now().toString(),
        updateTime = updateTime ?? DateTime.now().toString();
}
