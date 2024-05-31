import 'dart:io';

import 'package:blog_app/constant.dart';
import 'package:blog_app/models/api_response.dart';
import 'package:blog_app/models/post.dart';
import 'package:blog_app/screens/login.dart';
import 'package:blog_app/services/post_service.dart';
import 'package:blog_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class PostForm extends StatefulWidget {
 final Post? post;
 final String? title;

 PostForm ({
  this.post,
  this.title
 });

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _txtControllerBody = TextEditingController();
  bool _loading = false;

  File? _imageFile;
  final _picker = ImagePicker();


  Future getImage() async {
    final pickedFile = await _picker.getImage(source:ImageSource.gallery);
    if(pickedFile!= null){
     setState(() {
       _imageFile = File(pickedFile.path);
     });
    }
  }



  // create post

   void _createPost() async {
    String? image = _imageFile ==  null ? null : getStringImage(_imageFile);
    ApiResponse response = await createPost(_txtControllerBody.text, image);

    if(response.error ==  null) {
      Navigator.of(context).pop();
    }
    else if (response.error == unauthorized){
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false)
      });
    }
    else {
       ScaffoldMessenger.of(context).showSnackBar(
        
        SnackBar(
          
        duration: Duration(seconds: 3),
        
        content: Container(
          
           height: 30.0,
          child: Text(
            
            '${response.error}',
            style: GoogleFonts.nunito(
              color: Colors.white,
            fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
            ),),
            backgroundColor: Colors.red,
        )
      );
      setState(() {
        _loading = !_loading;
      });
    }
  }


// edit post
  void _editPost(int postId) async {
    ApiResponse response = await editPost(postId, _txtControllerBody.text);
    if (response.error == null) {
      Navigator.of(context).pop();
    }
    else if(response.error == unauthorized){
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false)
      });
    }
    else {
       ScaffoldMessenger.of(context).showSnackBar(
        
        SnackBar(
          
        duration: Duration(seconds: 3),
        
        content: Container(
          
           height: 30.0,
          child: Text(
            
            '${response.error}',
            style: GoogleFonts.nunito(
              color: Colors.white,
            fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
            ),),
            backgroundColor: Colors.red,
        )
      );
      setState(() {
        _loading = !_loading;
      });
    }
  }

@override
  void initState() {
    if (widget.post != null){
      _txtControllerBody.text = widget.post!.body??'';
    }
     super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.title}')),
      body:_loading? const Center(child: CircularProgressIndicator(),):
       ListView(
        children: [
          widget.post != null ? SizedBox():
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              image: _imageFile == null? null : DecorationImage(
                image: FileImage(_imageFile ?? File('')),
              fit: BoxFit.cover)
              ),
            
            child: Center(child: IconButton(
              icon:const Icon(Icons.image,size: 50, color : Colors.black38) ,
              onPressed: () {
                  getImage();
              },
              )),
          ),
          Form(
            key: _formkey,
            child: Padding(padding: const EdgeInsets.all(8),
          child: TextFormField(
            
            controller: _txtControllerBody,
            keyboardType:TextInputType.multiline ,
            maxLines:10,
            validator:(val) => val!.isEmpty ? 'Post body is required ': null,
            decoration: const InputDecoration(
              hintText: 'Post Body... ',
              border: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.black38))
            ),
            ),
          ),),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: kTextButton('Post', (){

              if(_formkey.currentState!.validate()){
                setState(() {
                  _loading = !_loading;
                });

                if (widget.post == null) {
                _createPost();

                } else {
                  _editPost(widget.post!.id??0);
                }


              }
               
            }),
          ),
        ],
      ),
    );
  }
}