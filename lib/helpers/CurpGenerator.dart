import 'dart:math';

class CurpGenerator {
  static String generateCurp(
      String nombre,
      String apellidoPaterno,
      String apellidoMaterno,
      DateTime fechaNacimiento,
      String genero,
      String estado) {
    String getPrimerLetraApellido(String apellido) {
      return apellido.substring(0, 1);
    }

    String getPrimerVocalApellido(String apellido) {
      const vocales = 'AEIOU';
      for (var letra in apellido.codeUnits) {
        final letraStr = String.fromCharCode(letra).toUpperCase();
        if (vocales.contains(letraStr)) {
          return letraStr;
        }
      }
      return 'X';
    }

    String getPrimerConsonante(String palabra) {
      const consonantes = 'BCDFGHJKLMNPQRSTVWXYZ';
      for (var letra in palabra.codeUnits) {
        final letraStr = String.fromCharCode(letra).toUpperCase();
        if (consonantes.contains(letraStr)) {
          return letraStr;
        }
      }
      return 'X';
    }

    String getSegundaConsonante(String palabra) {
      const consonantes = 'BCDFGHJKLMNPQRSTVWXYZ';
      var consonanteEncontrada = false;
      for (var letra in palabra.codeUnits) {
        final letraStr = String.fromCharCode(letra).toUpperCase();
        if (consonantes.contains(letraStr)) {
          if (consonanteEncontrada) {
            return letraStr;
          } else {
            consonanteEncontrada = true;
          }
        }
      }
      return 'X';
    }

    String getEntidad(String estado) {
      const entidadMap = {
        'AGUASCALIENTES': 'AS',
        'BAJA CALIFORNIA': 'BC',
        'BAJA CALIFORNIA SUR': 'BS',
        'CAMPECHE': 'CC',
        'COAHUILA': 'CL',
        'COLIMA': 'CM',
        'CHIAPAS': 'CS',
        'CHIHUAHUA': 'CH',
        'DISTRITO FEDERAL': 'DF',
        'DURANGO': 'DG',
        'GUANAJUATO': 'GT',
        'GUERRERO': 'GR',
        'HIDALGO': 'HG',
        'JALISCO': 'JC',
        'ESTADO DE MEXICO': 'MC',
        'MICHOACAN': 'MN',
        'MORELOS': 'MS',
        'NAYARIT': 'NT',
        'NUEVO LEON': 'NL',
        'OAXACA': 'OC',
        'PUEBLA': 'PL',
        'QUERETARO': 'QT',
        'QUINTANA ROO': 'QR',
        'SAN LUIS POTOSI': 'SP',
        'SINALOA': 'SL',
        'SONORA': 'SR',
        'TABASCO': 'TC',
        'TAMAULIPAS': 'TS',
        'TLAXCALA': 'TL',
        'VERACRUZ': 'VZ',
        'YUCATAN': 'YN',
        'ZACATECAS': 'ZS',
        'DOBLE NACIONALIDAD': 'NE',
        'NACIDO EXTRANJERO O NATURALIZADO': 'NE',
        // Agrega aquí otros estados
      };

      return entidadMap[estado] ?? 'NE';
    }

    final primerLetraApellidoPaterno = getPrimerLetraApellido(apellidoPaterno);
    final primerVocalApellidoPaterno = getPrimerVocalApellido(apellidoPaterno);
    final primerLetraApellidoMaterno = getPrimerLetraApellido(apellidoMaterno);
    final primerLetraNombre = nombre.substring(0, 1);
    final fechaNacimientoFormatted =
        '${fechaNacimiento.year.toString().substring(2)}${fechaNacimiento.month.toString().padLeft(2, '0')}${fechaNacimiento.day.toString().padLeft(2, '0')}';
    final entidad = getEntidad(estado);
    final segundaConsonanteApellidoPaterno =
        getSegundaConsonante(apellidoPaterno);
    final segundaConsonanteApellidoMaterno =
        getSegundaConsonante(apellidoMaterno);

    // Obtener la segunda consonante del nombre correctamente
    String segundaConsonanteNombre = 'X';
    for (var i = 1; i < nombre.length; i++) {
      final letra = nombre[i];
      if ('AEIOU'.contains(letra.toUpperCase())) {
        continue;
      }
      if ('BCDFGHJKLMNPQRSTVWXYZ'.contains(letra.toUpperCase())) {
        segundaConsonanteNombre = letra.toUpperCase();
        break;
      }
    }

    final homoclave = '${Random().nextInt(100).toString().padLeft(2, '0')}';

    final curp =
        '$primerLetraApellidoPaterno$primerVocalApellidoPaterno$primerLetraApellidoMaterno$primerLetraNombre$fechaNacimientoFormatted$genero$entidad$segundaConsonanteApellidoPaterno$segundaConsonanteApellidoMaterno$segundaConsonanteNombre$homoclave';

    return curp;
  }
}
