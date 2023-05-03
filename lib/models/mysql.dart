import 'package:mysql1/mysql1.dart';

class Mysql{
  static String host = 'sql155.main-hosting.eu', 
                user = 'u958218691_Innovaito', 
                password = 'SmtVfUqCZj*Ot1',
                db = 'u958218691_Innovaito';

  static int port = 3306; 

  Mysql();

  Future<MySqlConnection> getConnection() async{
    var settings = new ConnectionSettings(
      host: host,
      user: user,
      password: password,
      port: port,
      db: db,
    );

    return await MySqlConnection.connect(settings);
    
  }

}