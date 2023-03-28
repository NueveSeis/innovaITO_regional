import 'package:flutter/material.dart';
import 'package:innova_ito/theme/cambiar_tema.dart';

class BarraBotones extends StatelessWidget {
  const BarraBotones({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: CambiarTema.balticSea),
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                disabledColor: CambiarTema.emperor,
                elevation: 10,
                height: 30,
                color: CambiarTema.pizazz,
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: const Text(
                      'Aprobados',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: null),
            MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                disabledColor: CambiarTema.emperor,
                elevation: 10,
                height: 30,
                color: CambiarTema.pizazz,
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: const Text(
                      'Pendientes',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: () {})
          ],
        ),
      ),
    );
  }
}
