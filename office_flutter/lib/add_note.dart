import 'package:flutter/material.dart';
import 'package:office_flutter/api.dart';
import 'package:office_flutter/constants.dart';
import 'package:office_flutter/file_models.dart';
import 'package:provider/provider.dart';

class AddFile extends StatefulWidget {
  @override
  _AddFileState createState() => _AddFileState();
}

class _AddFileState extends State<AddFile> {

  final titleController = new TextEditingController();
  final descController = new TextEditingController();

  void onAdd(){
    final String textVal = titleController.text;
    final String descval = descController.text;

    if(textVal.isNotEmpty && descval.isNotEmpty){
      final File file = File(
        title: textVal,
        content: descval,
      );
      Provider.of<FilesProvider>(context, listen: false).addFiles(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Add Files',
            style: appBarTextStyle,
          ),
        ),
        body: _bodyAddText(),
      ),
    );
  }

  _bodyAddText() {
    return Container(
      child: Column(
        children: [
          //SizedBox(height: 20,),
          _titleTextfiled(),
          _textDescfield(),
          _submitButton(),
        ],
      ),
    );
  }

  _titleTextfiled() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: TextFormField(
        controller: titleController,
        decoration: InputDecoration(
          labelText: 'Title',
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )
        ),
      ),
    );
  }


  _textDescfield() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        controller: descController,
        decoration: InputDecoration(
            labelText: 'Description',
            labelStyle: TextStyle(
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            )
        ),
      ),
    );
  }

  _submitButton() {
    return InkWell(
      onTap: (){
        onAdd();
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(30),
      //radius: 1000,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 20),),
          ),
        ),
      ),
    );
  }
}
