import 'package:blog_app/screens/post_form.dart';
import 'package:blog_app/screens/post_screen.dart';
import 'package:blog_app/screens/profile.dart';
import 'package:flutter/material.dart';

import '../services/user_service.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentIndex = 0;
   final iconList = <IconData>[
    Icons.home,
    Icons.person_2,
     
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [IconButton(
          icon:const Icon(Icons.exit_to_app),
           onPressed: () { 
            logout().then((value)=>{
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Login()), (route) => false)

            });    
            },
          )],

      ),

      body: currentIndex == 0? const PostScreen(): Profile(),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.amber,
        onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PostForm(
          title: 'Add new post',
        )));
      },
      child: const Icon(
        
        Icons.add),
      ),
    
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
         color: Colors.white24,
        notchMargin: 10,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),

        child: BottomNavigationBar(
          backgroundColor: Colors.white24,
        items: [
          
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: ''
        ),

        const BottomNavigationBarItem(
          icon: const Icon(Icons.person_2_sharp),
          label: ''
        ),



      ],
      currentIndex: currentIndex,

      onTap:(value) {
        setState(() {
          currentIndex = value;
        });
      },
      )),
    );
  }
}