import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thelistv1/Vue/ProdsViews.dart';

import 'MedicViewDb.dart';

// couleur perso
const d_green = Color.fromARGB(255, 73, 137, 129);

class Acc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //recup orientation
    final orient = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: MyAppBar(),
      body: orient == Orientation.portrait
          ? CentralSection()
          : CentralSectionPaysage(),
      /*body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),*/
      bottomNavigationBar: BottomNavBarSection(),
    );
  }
}

// gestion banderole
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50))),
      leading: IconButton(
        icon: Icon(
          Icons.app_registration,
          color: Colors.grey[800],
          size: 20,
        ),
        onPressed: null,
      ),
      title: Text(
        'The List',
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}

//section boutons
class CentralSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(height: 50),
          Center(
            child: SizedBox(
              height: 200, //height of button
              width: 350,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProdsViewsDB();
                  }));
                  print("La gagne à ou la !");
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(40)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                ),
                icon: const Icon(
                    Icons.restaurant_menu), //icon data for elevated button
                label: const Text("Mon Frigo"), //label text
              ), //width of button
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
            height: 200, //height of button
            width: 350,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MedicViewDb();
                }));
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(40)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green)),
              icon: const Icon(
                  Icons.health_and_safety), //icon data for elevated button
              label: const Text("Ma Pharmacie"),

              //label text
            ), //width of button)
          ),
          const SizedBox(height: 50),
        ]),
      ),
    );
  }
}

//section boutons paysage
class CentralSectionPaysage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Row(children: <Widget>[
          SizedBox(width: 50),
          SizedBox(
            height: 200, //height of button
            width: 350,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProdsViewsDB();
                }));
                print("La gagne à ou la !");
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(40)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
              ),
              icon: const Icon(
                  Icons.restaurant_menu), //icon data for elevated button
              label: const Text("Mon Frigo"), //label text
            ), //width of button
          ),
          const SizedBox(width: 50),
          SizedBox(
            height: 200, //height of button
            width: 350,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MedicViewDb();
                }));
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(40)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green)),
              icon: const Icon(
                  Icons.health_and_safety), //icon data for elevated button
              label: const Text("Ma Pharmacie"),

              //label text
            ), //width of button)
          ),
          const SizedBox(width: 50),
        ]),
      ),
    );
  }
}

/*class CentralSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: 500,
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: ElevatedButton.icon(
          onPressed: () {
            print("La gagne à ou la !");
          },
          icon: Icon(Icons.save), //icon data for elevated button
          label: Text("Mon Frigo"), //label text
        ));
  }
}*/

// banderole du bas
class BottomNavBarSection extends StatelessWidget {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.grey[600],
      currentIndex: index,
      onTap: (index) {
        this.index = index;
        print(index);
        switch (index) {
          case 0:
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const Expanded(
                  child: AlertDialog(
                    title: Icon(Icons.help_center),
                    content: Text(
                        'Ajoutez vos produits ou médicaments avec les informations nécessaires pour les retracer !'),
                    actions: [],
                  ),
                );
              },
            );
            break;
          case 1:
            exit(0);
          default:
        }
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.help_center,
            color: d_green,
          ),
          label: 'Help',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.close,
            color: d_green,
          ),
          label: 'Quit',
        ),
      ],
    );
  }
}
