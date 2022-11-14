import 'package:flutter/material.dart';
import 'package:thelistv1/MedicModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thelistv1/acc.dart';
import 'package:thelistv1/main.dart';

class PharmaPage extends StatelessWidget {
  List<MedicModel> selectedProd = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: ProdView(),
      bottomNavigationBar: BottomNavBarSection(),
    );
  }
}

//gestion banderole
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.health_and_safety,
          color: Colors.grey[800],
          size: 20,
        ),
        onPressed: null,
      ),
      title: Text(
        'Ma Pharmacie',
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

//listview
class ProdView extends StatelessWidget {
  //Produits
  List<MedicModel> produits = [
    MedicModel("Dafalgant", "Périme le 15/12/22", false),
    MedicModel("Fervex", "Périme le 17/11/22", false),
    MedicModel("Lipikar", "Périme le 12/12/22", false),
    MedicModel("bandage", "Périme le 9/12/22", false),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Expanded(child: ListView.builder(
              itemBuilder: ((context, index) {
                return ProdItem(
                  produits[index].name,
                  produits[index].description,
                  produits[index].isSelect,
                  index,
                );
              }),
            ))
          ],
        ),
      ),
    );
  }
}

Widget ProdItem(String name, String description, bool isSelect, int ind) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: Colors.green,
      child: Icon(
        Icons.health_and_safety,
        color: Colors.white,
      ),
    ),
    title: Text(
      name,
      style: TextStyle(
        fontWeight: FontWeight.w500,
      ),
    ),
    subtitle: Text(description),
    trailing: isSelect
        ? Icon(
            Icons.check_circle,
            color: Colors.green[700],
          )
        : Icon(
            Icons.check_circle_outline,
            color: Colors.grey,
          ),
    /*onTap: () {
        setState(() {
          produits[index].isSelect = ! produits[index].isSelect;
          if ( produits[index].isSelect == true) {
            selected produits.add( produitsModel(name, description, true));
          } else if ( produits[index].isSelected == false) {
            selected produits
                .removeWhere((element) => element.name ==  produits[index].name);
          }
        });

  }*/
  );
}

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
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Acc();
            }));
            break;
          default:
        }
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.arrow_back,
            color: d_green,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add,
            color: d_green,
          ),
          label: 'Ajouter',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: d_green,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
