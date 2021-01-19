import 'package:sqflite/sqflite.dart';

void createV1(Batch batch) {
  batch.execute('''  
  CREATE TABLE endereco(
    id Integer primary key autoincrement,
    endereco varchar(1000) not null,
    latitude varchar(1000),
    longitude varchar(1000),
    complemento varchar(1000)
  )
  ''');
}
