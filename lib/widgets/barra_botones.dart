import 'package:flutter/material.dart';
import 'package:innova_ito/theme/cambiar_tema.dart';
import 'package:provider/provider.dart';

class BarraBotones extends StatelessWidget {
  const BarraBotones({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool pendiente = true;

    final temaApp = Provider.of<CambiarTema>(context);
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: (temaApp.temaOscuro)
              ? CambiarTema.balticSea
              : CambiarTema.indigo50,
        ),
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                disabledColor: (temaApp.temaOscuro)
                    ? CambiarTema.emperor
                    : CambiarTema.grey100,
                elevation: 10,
                height: 30,
                color: CambiarTema.pizazz,
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Text(
                      'Aprobados',
                      style: TextStyle(
                          color: (temaApp.temaOscuro)
                              ? Colors.white
                              : CambiarTema.bluegrey700),
                    )),
                onPressed: () {
                  pendiente = false;
                }),
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
                onPressed: () {
                  pendiente = true;
                })
          ],
        ),
      ),
    );
  }
}
