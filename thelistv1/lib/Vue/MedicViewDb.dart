import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thelistv1/DB/MedicDb.dart';

import 'Acc.dart';
import 'MedicAdd.dart';
import '../Model/Medic.dart';

const d_green = Color.fromARGB(255, 73, 137, 129);

class MedicViewDb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: MedicsView(),
      bottomNavigationBar: BottomNavBarSection(),
    );
  }
}

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

//section liste Db
class MedicsView extends StatefulWidget {
  const MedicsView({super.key});

  @override
  State<MedicsView> createState() => _MedicsViewState();
}

class _MedicsViewState extends State<MedicsView> {
  int isselected = 0;
  bool supp = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<List<Medic>>(
              future: MedicDb.instance.medics(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  List<Medic>? medics = snapshot.data;
                  return ListView.builder(
                    itemCount: medics?.length,
                    itemBuilder: ((context, index) {
                      return Card(
                          child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.restaurant_menu,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          medics![index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(medics[index].description),
                        trailing: medics[index].isSelected
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.green[700],
                              )
                            : Icon(
                                Icons.check_circle_outline,
                                color: Colors.grey,
                              ),
                        //lors du clique sur un item

                        onTap: () {
                          setState(() {
                            if (medics[index].isSelected == false) {
                              isselected += 1;
                              MedicDb.instance.updateRecipe(Medic(
                                  medics[index].name,
                                  medics[index].description,
                                  true));
                            } else {
                              isselected -= 1;
                              MedicDb.instance.updateRecipe(Medic(
                                  medics[index].name,
                                  medics[index].description,
                                  false));
                            }
                            print(isselected);
                            if (isselected > 0) {
                              supp = true;
                            } else if (isselected <= 0) {
                              supp = false;
                            }
                          });
                        },
                      ));
                    }),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            )),
            Visibility(
                visible: supp,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: supp
                        ? () {
                            setState(() {
                              MedicDb.instance.deleteSelected();
                              isselected = 0;
                            });
                          }
                        : () {
                            setState(() {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const Expanded(
                                    child: AlertDialog(
                                      title: Icon(Icons.delete_forever),
                                      content: Text(
                                          'Sélectionnez un ou plusieurs élément à supprimer !'),
                                      actions: [],
                                    ),
                                  );
                                },
                              );
                            });
                          },
                    backgroundColor: Colors.white,
                    child: supp
                        ? Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          )
                        : Icon(Icons.delete_forever_outlined,
                            color: Colors.grey),
                  ),
                ))
          ],
        ),
      ),
    );
  }
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
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MedicAdd();
            }));
            break;
          case 2:
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
      ],
    );
  }
}
