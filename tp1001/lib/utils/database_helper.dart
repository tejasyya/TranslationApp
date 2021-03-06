import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:tp1001/models/data.dart';

class DatabaseHelper{
    static DatabaseHelper _databaseHelper;   //Singleton DatabaseHelper
    static Database _database;

    String dTable='d_table';
    String colId='id';
    String colInput='input';
    String colICode='iCode';
    String colOutput='output';
    String colOCode='oCode';
    String colEmotion='emotion';
    String colUserId='userId';
    String colRating='rating';

    DatabaseHelper._createInstance();   // Named constructor to create instance of DatabaseHelper
    factory DatabaseHelper(){
      if(_databaseHelper==null){
      _databaseHelper=DatabaseHelper._createInstance();
      }
      return _databaseHelper;
    }
    Future<Database> get database async{
      if(_database==null)
      {
        _database=await initializeDatabase();
      }
      return _database;
    }
    Future<Database> initializeDatabase() async{
      Directory directory= await getApplicationDocumentsDirectory();
      String path=directory.path + 'data.db';
      var dataDatabase=await openDatabase(path, version: 1, onCreate: _createDb);
      return dataDatabase;
    }
    void _createDb(Database db,int newVersion) async{
      await db.execute('CREATE TABLE $dTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colInput TEXT,'
                       '$colICode TEXT, $colOutput TEXT, $colOCode TEXT, $colEmotion TEXT, $colUserId TEXT, $colRating INTEGER)');
    }
    
    //Fetch Operations:
    Future<List<Map<String,dynamic>>> getDataMapList() async{
      Database db=await this.database;  
      var result= await db.query(dTable, orderBy:'$colRating DESC'); //It same using helper functions
      return result;
    }
    //Fetch results for main translation area
    Future<List<Map<String,dynamic>>> getDataMapList2(String i,String iC,String oC) async{
      Database db=await this.database;
      //var result= await db.rawQuery('SELECT * FROM $dTable order by $colRating DESC WHERE $colInput=$i AND $colICode=$iC AND $colOCode=$oC');
      var result= await db.rawQuery('SELECT * FROM $dTable WHERE $colInput="$i" AND $colICode="$iC" AND $colOCode="$oC" order by $colRating DESC');
      //result= await db.query(dTable,where: 'colId =?,colInput=?',whereArgs: [data.id,data.input]);    
      //var result= await db.query(dTable, orderBy:'$colRating DESC'); //It same using helper functions
      return result;
    }
    //Insert Operations:
    Future<int> insertData(DataModel data) async{
      Database db=await this.database;
      var result= await db.insert(dTable, data.toMap());
      return result;
    }
    //Update Operations:
    Future<int> updateData(DataModel data) async{
      Database db=await this.database;
      //var result= await db.update(dTable, data.toMap(),where: 'colId =?',whereArgs: [data.id]);
      var result= await db.rawUpdate('UPDATE $dTable SET $colRating=$data.rating WHERE $colUserId=$data.userId AND $colOutput="$data.output"');
      return result;
    }
    //Delete Operations:
    /*
    Future<int> deleteData(int id) async{
      Database db=await this.database;
      var result= await db.rawDelete('DELETE FROM $dTable WHERE $colId = $id');
      return result;
    }
    */
    //Get no. records in dB
    Future<int> getCount() async{
      Database db=await this.database;
      List<Map<String, dynamic>> x= await db.rawQuery('SELECT COUNT (*) from $dTable');
      int result = Sqflite.firstIntValue(x);
      return result;
    } 
    //Convert Map list to Note list for community user list view
    Future<List<DataModel>> getDataList() async {
      var dataMapList = await getDataMapList();
      int count=dataMapList.length;
      List<DataModel> dataList = List<DataModel>();
      for(int i=0; i<count;i++)
      {
        dataList.add(DataModel.fromMapObject(dataMapList[i]));
      }
      return dataList;
    }
    //Convert Map list to Note list for main translation
    Future<List<DataModel>> getDataList2(String i,String iC,String oC) async {
      var dataMapList = await getDataMapList2(i,iC,oC);
      int count=dataMapList.length;
      List<DataModel> dataList = List<DataModel>();
      for(int i=0; i<count;i++)
      {
        dataList.add(DataModel.fromMapObject(dataMapList[i]));
      }
      return dataList;
    }
} 