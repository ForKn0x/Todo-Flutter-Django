import 'dart:io';

import 'package:flutter/material.dart';
import 'package:office_flutter/api.dart';
import 'package:office_flutter/constants.dart';
import 'package:office_flutter/file_models.dart';
import 'package:provider/provider.dart';


class ShowFile extends StatefulWidget {

  final File file;
  const ShowFile(this.file);

  @override
  _ShowFileState createState() => _ShowFileState();
}

class _ShowFileState extends State<ShowFile> {

  TextEditingController descController = new TextEditingController();

  @override
  void initState(){
    super.initState();
    descController = TextEditingController(text: widget.file.content);
  }

  @override
  void dispose(){
    isUpdate = false;
    descController.dispose();
    super.dispose();
  }

  void onUpdate(){
    final String descval = descController.text;

    if(descval.isNotEmpty){
      widget.file.content = descval;
      Provider.of<FilesProvider>(context, listen: false).updateFile(widget.file);
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
            widget.file.title,
            style: appBarTextStyle,
          ),
        ),
        body: _showFileBody(),
      ),
    );
  }

  _showFileBody() {
    return Column(
      children: [
        _placeHolder(),
        _deleteButton(),
        _updateButton(),
      ],
    );
  }

  _placeHolder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: isUpdate ?  TextFormField(
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
            ) : Text(
              widget.file.content,
              style:  TextStyle(
                fontSize: 30,
                fontFamily: 'Montserrat',
                color: Colors.black45,
              ),
            ) ,
          ),
        ),
      ),
    );
  }

  _deleteButton() {
    return InkWell(
      onTap: (){
        Provider.of<FilesProvider>(context, listen: false).deleteFile(widget.file);
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
            child: Text('Delete', style: TextStyle(color: Colors.white, fontSize: 20),),
          ),
        ),
      ),
    );
  }

  _updateButton() {
    return InkWell(
      onTap: (){
        if (!isUpdate){
          setState(() {
            isUpdate = true;
          });
        } else {
          onUpdate();
          Navigator.pop(context);
        }
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
            child: Text(isUpdate ? 'Save' : 'Update', style: TextStyle(color: Colors.white, fontSize: 20),),
          ),
        ),
      ),
    );
  }
}
