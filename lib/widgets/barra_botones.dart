import 'package:flutter/material.dart';
import 'package:innova_ito/theme/app_tema.dart';
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

    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppTema.indigo50,
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
                disabledColor: AppTema.grey100,
                elevation: 10,
                height: 30,
                color: (aprobados) ? AppTema.pizazz : AppTema.grey100,
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Text(
                      'Aprobados',
                      style: TextStyle(
                          color:
                              (aprobados) ? Colors.white : AppTema.bluegrey700),
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
                disabledColor: AppTema.emperor,
                elevation: 10,
                height: 30,
                color: (pendiente) ? AppTema.pizazz : AppTema.grey100,
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Text(
                      'Pendientes',
                      style: TextStyle(
                          color:
                              (pendiente) ? Colors.white : AppTema.bluegrey700),
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
