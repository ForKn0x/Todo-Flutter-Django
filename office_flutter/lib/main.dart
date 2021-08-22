import 'package:flutter/material.dart';
import 'package:office_flutter/add_note.dart';
import 'package:office_flutter/api.dart';
import 'package:office_flutter/constants.dart';
import 'package:office_flutter/file_models.dart';
import 'package:office_flutter/show_file.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FilesProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryIconTheme: IconThemeData(color: Color(0xff342D50), size: 30),
          primarySwatch: Colors.blue,
          primaryTextTheme: TextTheme(),
        ),
        home: OfficeApp(),
      ),
    );
  }
}

class OfficeApp extends StatefulWidget {
  @override
  _OfficeAppState createState() => _OfficeAppState();
}

class _OfficeAppState extends State<OfficeApp> {
  @override
  Widget build(BuildContext context) {
    //final fileProvider = Provider.of<FilesProvider>(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              customBorder: CircleBorder(),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddFile()));
              },
              borderRadius: BorderRadius.circular(100),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Files',
          style: appBarTextStyle,
        ),
      ),
      backgroundColor: Color(0xffF1F4FA),
      body: Consumer<FilesProvider>(
        builder: (context, fileProvider, child){
          return ListView.builder(
              itemCount: fileProvider.files.length,
              itemBuilder: (context, index) => Gocard(
                file: fileProvider.files[index],
              ));
        },
      )
    ));
  }
}



class Gocard extends StatelessWidget {
  Gocard({this.file});
  final File file;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowFile(file)));
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            width: MediaQuery.of(context).size.width - 30,
            //height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xffB6C6E5),
                    Color(0xff342D50),
                  ],
                )),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      file.title,
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      file.content,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        color: Colors.white30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
