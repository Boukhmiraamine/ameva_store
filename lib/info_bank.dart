import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app11/mydrawer.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class InfoBank extends StatefulWidget {
  const InfoBank({Key? key}) : super(key: key);

  @override
  State<InfoBank> createState() => _InfoBankState();
}

class _InfoBankState extends State<InfoBank> {
  var numberForm = GlobalKey<FormState>();
  TextEditingController _date = TextEditingController() ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Iformations Banquaires"),
      ),
      drawer: Mydrawer(),
      body: SingleChildScrollView(
          child: Form(
            key: numberForm,
            child: Column(
              children: [
                SizedBox(height: 60.0,),
                Center(
                  child: SvgPicture.asset(
                    "images/credit.svg",
                    height: 160,
                    width: 160,
                  ),
                ),
                SizedBox(height: 90.0,),
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: Offset(0.4, 0.4),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black.withOpacity(0.1)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Carte Bancaires :",
                            style: GoogleFonts.mavenPro(fontSize: 17,fontWeight: FontWeight.w400),
                          ),
                          SizedBox(width: 75,),
                          Image(image: AssetImage("images/icons8-visa-48.png",),height: 40,width: 40,),
                          SizedBox(width: 5,),
                          Image(image: AssetImage("images/icons8-mastercard-48.png"),height: 40,width: 40,),
                          SizedBox(width: 5,),
                          Image(image: AssetImage("images/icons8-paypal-48.png"),height: 40,width: 40,),
                        ],
                      ),
                      SizedBox(height: 20.0,),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty)
                            return "Enter votre numero de carte!";
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Numero de la carte",
                          hintText: "Exemple : 57XX XXXX XXXX XXXX",
                        ),
                      ),
                      SizedBox(height: 40.0,),
                      Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: TextFormField(
                              controller: _date,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.calendar_month),
                                labelText: "Date d'expiration",
                                hintText: "Selectioner votre date",
                              ),
                              onTap: () async{
                                DateTime? pickeddate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1980),
                                    lastDate: DateTime(2100),
                                );
                                if(pickeddate!=null){
                                  setState(() {
                                    _date.text = DateFormat('yyyy-MM-dd').format(pickeddate) ;
                                  });
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 15,),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                            validator: (val) {
                              if (val!.isEmpty)
                                return "Enter votre numero de carte !";
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "CVV",
                              hintText: "XXX",
                            ),
                          ),
                          ),
                        ],
                      ),
                      SizedBox(height: 60,),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(140.0, 5.0, 140.0, 5.0)),
                        ),
                        child: Text(
                          "Modifier",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}
