import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Phone extends StatefulWidget {
  const Phone({Key? key}) : super(key: key);

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Numero De Telephone"),
        leading: Builder(
          builder: (BuildContext context){
            return IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 60.0,),
              Center(
                child: SvgPicture.asset(
                  "images/phone.svg",
                  height: 160,
                  width: 160,
                ),
              ),
              SizedBox(height: 120.0,),
              Text(
                "Changer votre numero de telephone :",
                style: GoogleFonts.questrial(
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
              ),
              SizedBox(height: 20.0,),
              Container(
                 margin: EdgeInsets.all(15.0),
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
                child: Stack(
                  children: [
                    InternationalPhoneNumberInput(
                        onInputChanged: (value) {},
                      cursorColor: Colors.blue,
                      formatInput: false,
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.DIALOG
                      ),
                      inputDecoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 15,left: 0),
                        border: InputBorder.none,
                        hintText: "Numero De Telephone",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 17,
                        )
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30.0,),
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
        ),
      )
    );
  }
}

