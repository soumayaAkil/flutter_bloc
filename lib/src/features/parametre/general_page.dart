import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/my_colors.dart';
import '../../../data/repository/dossier_repository.dart';
import '../../../data/web_services/dossier_web_services.dart';
import '../../../main.dart';
import '../../../router.dart';
import '../auth/login_bloc/login_bloc.dart';
import '../auth/login_user.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;
  late DossierAnalyseRepository  dossiersRepository = DossierAnalyseRepository(DossierWebService());

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerAdresse = TextEditingController(text: '41.227.27.130');
    TextEditingController _controllerPort = TextEditingController(text: '7733');
    TextEditingController _controllerNom = TextEditingController(text: 'prolab');
    TextEditingController _controllerPswd = TextEditingController(text: '___rootsama');
    String _encryptedText = "";
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),

        ),
        backgroundColor: MyColors.colorPrimary,
        centerTitle: true,
        title: Column(children: [
          Text(
            'Général',
            style: TextStyle(color: MyColors.white),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(height: 60.0),

                  const Text(
                    "Configuration",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Parametre base de données",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Form(
                child: Column(
                  children: <Widget>[
                    /*
                GestureDetector(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 25,top: 10),
                        height: 60,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: MyColors.colorPrimary.withOpacity(0.5),
                
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child:Column(
                         // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Adresse du serveur "),
                            Text("41.227.27.130 ")
                          ],
                        ),
                      ),
                    onTap: (){
                      showAdresseAlertDialog(context,"41.227.27.130");
                    },
                ),
                    const SizedBox(height: 30),
                    */
                    TextFormField(
                      controller: _controllerAdresse,
                      decoration: InputDecoration(
                        hintText: "Adresse du serveur ",
                        labelText: 'Adresse du serveur',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        //fillColor: Colors.purple.withOpacity(0.1),
                        fillColor:   MyColors.colorPrimary.withOpacity(0.5),
                        filled: true,
                      ),
                    ),
                
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _controllerPort,
                      decoration: InputDecoration(
                          hintText: "Numéro de port ",
                        labelText: 'Numéro de port',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          //fillColor: Colors.purple.withOpacity(0.1),
                        fillColor:   MyColors.colorPrimary.withOpacity(0.5),
                          filled: true,
                          ),
                    ),
                
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _controllerNom,
                      decoration: InputDecoration(
                        labelText: "Nom de la base de données",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        //fillColor: Colors.purple.withOpacity(0.1),
                        fillColor: MyColors.colorPrimary.withOpacity(0.5),
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _controllerPswd,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Mot de passe de la base de données",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        //fillColor: Colors.purple.withOpacity(0.1),
                        fillColor: MyColors.colorPrimary.withOpacity(0.5),
                        filled: true,
                      ),
                    ),
                /*
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.purple.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.email)),
                    ),
                
                    const SizedBox(height: 20),
                
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                
                    const SizedBox(height: 20),
                
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: MyColors.colorPrimary.withOpacity(0.5),
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                    */
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                          _createRoute(

                          BlocProvider(
                                create: (context) => LoginBloc( dossiersRepository),
                                child: LoginsPage(),
                              )




                          ) ,(e) => false
                             );
                      /*Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => LoginBloc( dossiersRepository),
                                child: LoginsPage(),
                              )



                          ),
                              (e) => false);

                       */
                    },
                    child: const Text(
                      "valider",
                      style: TextStyle(fontSize: 20,color: MyColors.white,fontWeight: FontWeight.w700),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: MyColors.colorPrimary,
                    ),
                  )
              ),


/*
              const Center(child: Text("Or")),

              Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.purple,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:   AssetImage('assets/images/login_signup/google.png'),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      ),

                      const SizedBox(width: 18),

                      const Text("Sign In with Google",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Already have an account?"),
                  TextButton(
                      onPressed: () {
                      },
                      child: const Text("Login", style: TextStyle(color: Colors.purple),)
                  )
                ],
              )
              */
            ],
          ),
        ),
      ),
    );
  }

  showAdresseAlertDialog(BuildContext contextt,String adresse) {
    // show the dialog
    int result = 0;
    late String valueRecherche = adresse;
    showDialog(
        context: contextt,
        builder: (BuildContext context2) {
          TextEditingController mycontroller = new TextEditingController();

                    return AlertDialog(
                        title: Text(
                          "Adresse du serveur ",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextFormField(
                                initialValue:(adresse!=null)? adresse:"",
                                // decoration: InputDecoration(hintText: "Enter your input here"),
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText: 'Adresse du serveur',
                                  //   fillColor: const Color(0xfff1f1f1),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "Adresse du serveur",
                                ),
                                onChanged: (value) {
                                  valueRecherche = value;
                                }),
                          ],
                        ),
                        actions: [
                          TextButton(
                            // textColor: Colors.purple,
                            onPressed: () =>
                            {mycontroller.clear(), Navigator.pop(context2)},
                            child: const Text('Annuler'),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context2);
                            },
                            child: Text('Ok'),
                          )
                        ]);

        });
    // return 0 pas d'action , return 1 api valider , return 2 annuler validation
    return result;
  }

  Route _createRoute(Widget Page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0); // Change to left-to-right animation
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

}

