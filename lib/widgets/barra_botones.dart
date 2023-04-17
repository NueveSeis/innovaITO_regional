import 'package:flutter/material.dart';
import 'package:innova_ito/theme/cambiar_tema.dart';
import 'package:provider/provider.dart';

class BarraBotones extends StatefulWidget {
  const BarraBotones({
    super.key,
  });

  @override
  State<BarraBotones> createState() => _BarraBotonesState();
}

class _BarraBotonesState extends State<BarraBotones> {
  bool pendiente = false;
  bool aprobados = false;
  @override
  Widget build(BuildContext context) {
    //bool pendiente = false;
    // bool aprobados = false;

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
                color: (temaApp.temaOscuro)
                    ? (aprobados)
                        ? CambiarTema.pizazz
                        : CambiarTema.emperor
                    : (aprobados)
                        ? CambiarTema.pizazz
                        : CambiarTema.grey100,
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Text(
                      'Aprobados',
                      style: TextStyle(
                          color: (temaApp.temaOscuro)
                              ? Colors.white
                              : (aprobados)
                                  ? Colors.white
                                  : CambiarTema.bluegrey700),
                    )),
                onPressed: () {
                  setState(() {
                    aprobados = true;
                    pendiente = false;
                  });
                }),
            MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                disabledColor: CambiarTema.emperor,
                elevation: 10,
                height: 30,
                color: (temaApp.temaOscuro)
                    ? (pendiente)
                        ? CambiarTema.pizazz
                        : CambiarTema.emperor
                    : (pendiente)
                        ? CambiarTema.pizazz
                        : CambiarTema.grey100,
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Text(
                      'Pendientes',
                      style: TextStyle(
                          color: (temaApp.temaOscuro)
                              ? Colors.white
                              : (pendiente)
                                  ? Colors.white
                                  : CambiarTema.bluegrey700),
                    )),
                onPressed: () {
                  setState(() {
                    pendiente = true;
                    aprobados = false;
                  });
                })
          ],
        ),
      ),
    );
  }
}
