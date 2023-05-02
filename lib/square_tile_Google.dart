import 'package:flutter/material.dart';


import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final Function()?onTap;
  const SquareTile({
    Key? key,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
        ),
        padding: const EdgeInsets.symmetric(horizontal:103.0 ,vertical: 9.0),// Ajuster le padding ici
        child: Row(

          children: [

            Image.asset(imagePath, height: 40),
            const SizedBox(width: 10),
            Text(
              'Se connecter avec Google',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black, // Changer la couleur du texte en noir
              ),
            ),
          ],
        ),
      ),
    );
  }
}
