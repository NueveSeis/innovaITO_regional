import 'dart:io';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:innova_ito/models/models.dart';

import 'package:path_provider/path_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class pdf {
  static Future<String> registro(String titulo) async {
    var htmlContent = """
<!DOCTYPE html>
<html>
<head>
  <style>
  table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
  }
  th, td, p {
    padding: 5px;
    text-align: left;
  }
  </style>
</head>
  <body>
    <h2>$titulo</h2>
    <table style="width:100%">
      <caption>Sample HTML Table</caption>
      <tr>
        <th>Month</th>
        <th>Savings</th>
      </tr>
      <tr>
        <td>January</td>
        <td>100</td>
      </tr>
      <tr>
        <td>February</td>
        <td>50</td>
      </tr>
    </table>
    <p>Image loaded from web</p>
    <img src="https://i.imgur.com/wxaJsXF.png" alt="web-img">
  </body>
</html>
""";

    Directory appDocDir = await getApplicationDocumentsDirectory();
    final targetPath = appDocDir.path;
    final targetFileName = "example-pdf";

    final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        htmlContent, targetPath, targetFileName);
    String generatedPdfFilePath = generatedPdfFile.path;
    return generatedPdfFilePath;
  }

  static Future<String> fichaTecnica(
      String folio,
      String nombre_corto,
      String objetivo,
      String descripcion_general,
      String prospecto_resultados,
      String nombre_area,
      String nombre_categoria,
      String memoria,
      String descripcion_problematica,
      String estado_arte,
      String descripcion_innovacion,
      String propuesta_valor,
      String mercado_potencial,
      String viabilidad_tecnica,
      String viabilidad_financiera,
      String estrategia_propiedadIntelectual,
      String interpretacion_resultados,
      String fuentes_consultadas,
      String nombre_proyecto,
      String tipo_naturaleza) async {
    var htmlContent = """
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Imágenes Alineadas</title>
<style>
  .image-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }

  .image-container img {
    max-height: 50px;
  }
</style>
</head>
<body>
<div class="image-container">
  
  <img src="https://myfiles.space/user_files/172617_410aa649f7ffd136/172617_custom_files/img1693028316.png" alt="Imagen 2">
  <img src="https://myfiles.space/user_files/172617_410aa649f7ffd136/172617_custom_files/img1693024292.png" alt="Imagen 1">

  <img src="https://myfiles.space/user_files/172617_410aa649f7ffd136/172617_custom_files/img1693024324.png" alt="Imagen 3">
</div>
<p><br></p>
<p><strong>Cumbre Nacional de Desarrollo Tecnológico, Investigación e Innovación, InnovaITO 2023</strong></p>
<p><strong>Instituto Tecnológico de Oaxaca</strong></p>
<p><strong>Etapa Local</strong></p>
<p><br></p>

<p style="text-align: center;"><strong>MEMORIA DEL PROYECTO</strong></p>
<table style="width: 100%; background-color: rgb(255, 255, 255); border-collapse: collapse; border: 1px solid rgb(0, 0, 0);">
    <tbody>
        <tr>
            <td style="width: 31.0672%; border: 1px solid rgb(0, 0, 0);">Folio:</td>
            <td style="width: 68.9328%; text-align: center; border: 1px solid rgb(0, 0, 0);">$folio</td>
        </tr>
        <tr>
            <td style="width: 31.0672%; border: 1px solid rgb(0, 0, 0);">Nombre corto:</td>
            <td style="width: 68.9328%; text-align: center; border: 1px solid rgb(0, 0, 0);">$nombre_corto</td>
        </tr>
        <tr>
            <td style="width: 31.0672%; border: 1px solid rgb(0, 0, 0);">Nombre descriptivo:</td>
            <td style="width: 68.9328%; text-align: center; border: 1px solid rgb(0, 0, 0);">$nombre_proyecto</td>
        </tr>
        <tr>
            <td style="width: 31.0672%; border: 1px solid rgb(0, 0, 0);">Categoría:</td>
            <td style="width: 68.9328%; text-align: center; border: 1px solid rgb(0, 0, 0);">$nombre_categoria</td>
        </tr>
        <tr>
            <td style="width: 31.0672%; border: 1px solid rgb(0, 0, 0);">Sector estratégico:</td>
            <td style="width: 68.9328%; text-align: center; border: 1px solid rgb(0, 0, 0);">$nombre_area</td>
        </tr>
        <tr>
            <td style="width: 31.0672%; border: 1px solid rgb(0, 0, 0);">Naturaleza técnica:</td>
            <td style="width: 68.9328%; text-align: center; border: 1px solid rgb(0, 0, 0);">$tipo_naturaleza</td>
        </tr>
    </tbody>
</table>
<p><br></p>
<table style="width: 100%; background-color: rgb(255, 255, 255); border-collapse: collapse; border: 1px solid rgb(0, 0, 0);">

</table>
<p><br></p>
<table style="width: 100%;">
    <tbody>
        <tr>
            <td style="width: 100%; background-color: rgb(204, 204, 204);">
                <div style="text-align: center;"><strong>Descripción de la problemática y justificación;n</strong></div>
            </td>
        </tr>
    </tbody>
</table>
<p>$descripcion_problematica</p>

<p><br></p>
<table style="width: 100%;">
    <tbody>
        <tr>
            <td style="width: 100%; background-color: rgb(204, 204, 204);">
                <div style="text-align: center;"><strong>Estado de la técnica (estado del arte)</strong></div>
            </td>
        </tr>
    </tbody>
</table>
<p>$estado_arte</p>

<p><br></p>
<table style="width: 100%;">
    <tbody>
        <tr>
            <td style="width: 100%; background-color: rgb(204, 204, 204);">
                <div style="text-align: center;"><strong>Descripción de la innovación</strong></div>
            </td>
        </tr>
    </tbody>
</table>
<p>$descripcion_innovacion</p>

<p><br></p>
<table style="width: 100%;">
    <tbody>
        <tr>
            <td style="width: 100%; background-color: rgb(204, 204, 204);">
                <div style="text-align: center;"><strong>Propuesta de valor e impacto en el sector estratégico</strong></div>
            </td>
        </tr>
    </tbody>
</table>
<p>$propuesta_valor</p>
<p><br></p>
<table style="width: 100%;">
    <tbody>
        <tr>
            <td style="width: 100%; background-color: rgb(204, 204, 204);">
                <div style="text-align: center;"><strong>Mercado potencial objetivo</strong></div>
            </td>
        </tr>
    </tbody>
</table>
<p>$mercado_potencial</p>

<p><br></p>
<table style="width: 100%;">
    <tbody>
        <tr>
            <td style="width: 100%; background-color: rgb(204, 204, 204);">
                <div style="text-align: center;"><strong>Viabilidad técnica</strong></div>
            </td>
        </tr>
    </tbody>
</table>
<p>$viabilidad_tecnica</p>
<p><br></p>
<table style="width: 100%;">
    <tbody>
        <tr>
            <td style="width: 100%; background-color: rgb(204, 204, 204);">
                <div style="text-align: center;"><strong>Viabilidad financiera</strong></div>
            </td>
        </tr>
    </tbody>
</table>
<p>$viabilidad_financiera</p>
<p><br></p>
<table style="width: 100%;">
    <tbody>
        <tr>
            <td style="width: 100%; background-color: rgb(204, 204, 204);">
                <div style="text-align: center;"><strong>Estrategia de propiedad intelectual</strong></div>
            </td>
        </tr>
    </tbody>
</table>
<p>$estrategia_propiedadIntelectual</p>
<p><br></p>
<table style="width: 100%;">
    <tbody>
        <tr>
            <td style="width: 100%; background-color: rgb(204, 204, 204);">
                <div style="text-align: center;"><strong>Interpretación de resultados</strong></div>
            </td>
        </tr>
    </tbody>
</table>
<p>$interpretacion_resultados</p>
<p><br></p>
<table style="width: 100%;">
    <tbody>
        <tr>
            <td style="width: 100%; background-color: rgb(204, 204, 204);">
                <div style="text-align: center;"><strong>Fuentes consultadas</strong></div>
            </td>
        </tr>
    </tbody>
</table>
<p>$fuentes_consultadas</p>
</html>
""";

    Directory appDocDir = await getApplicationDocumentsDirectory();
    final targetPath = appDocDir.path;
    final targetFileName = "FichaTecnica-$nombre_corto";

    final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        htmlContent, targetPath, targetFileName);
    String generatedPdfFilePath = generatedPdfFile.path;
    return generatedPdfFilePath;
  }

  static Future<String> constancia(
      String tecnologico,
      String nombreParticipante,
      String rol,
      String nombreProyecto,
      String categoria,
      String etapa,
      String nombreDirector,
      String dia,
      String mes,
      String ano,
      String fechaIni,
      String fechaFin,
      String nombreCo,
      String cargo) async {
    var htmlContent = """
<!DOCTYPE html>
<html>

<head>
    <title>Constancia</title>
    <meta charset="UTF-8"> 
</head>

<body>
    <img src="${dotenv.env['HOST_REST']}logos/sep.png" alt="" style="position: absolute; left: 0; top: 10; height: 60px;">
    <img src="${dotenv.env['HOST_REST']}logos/tecnm.png" alt="Imagen 2"
        style="position: absolute; right: 0; top: 10;  height: 60px;">
    <br>
    <br>

    <div style="text-align: center; margin-top: 140px;">
        <br>
        <h3>EL TECNOLÓGICO NACIONAL DE MÉXICO A TRAVES DEL $tecnologico OTORGAN EL PRESENTE</h3>
        <br>
        <h2>RECONOCIMIENTO</h2>
        <h2>A</h2>
        <h2>$nombreParticipante</h2>
        <br>
        <h3>POR SU DESTACADA PARTICIPACIÓN EN EL PROYECTO $nombreProyecto, EN LA CATEGORÍA $categoria </h3>
        <br>
        
        <h3>EN EL EVENTO INNOVATEC $ano</h3>
        <h3>CELEBRADO $fechaIni AL $fechaFin DEL $mes DE $ano</h3>
        
        <br>
        <br>
        <br>
        <br>
        <br>
    </div>
    <div style="display: flex; justify-content: space-between; margin-top: 40px;">
        <div style="text-align: center; position: absolute; left: 0; top: 600; width: 50%;">
            <h3>$nombreCo</h3>
            <h3>$cargo</h3>
        </div>
        <div style="text-align: center; position: absolute; right: 0; top: 600; width: 50%;">
            <h3>$nombreDirector</h3>
            <h3>DIRECTOR DEL $tecnologico</h3>
        </div>
    </div>
</body>

</html>
""";

    Directory appDocDir = await getApplicationDocumentsDirectory();
    final targetPath = appDocDir.path;
    final targetFileName = "Constancia-$nombreParticipante";

    final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        htmlContent, targetPath, targetFileName);
    String generatedPdfFilePath = generatedPdfFile.path;
    return generatedPdfFilePath;
  }

//   static Future<String> fichaTecnica(
//       String folio,
//       String nombre_corto,
//       String objetivo,
//       String descripcion_general,
//       String prospecto_resultados,
//       String nombre_area,
//       String nombre_categoria,
//       String memoria,
//       String descripcion_problematica,
//       String estado_arte,
//       String descripcion_innovacion,
//       String propuesta_valor,
//       String mercado_potencial,
//       String viabilidad_tecnica,
//       String viabilidad_financiera,
//       String estrategia_propiedadIntelectual,
//       String interpretacion_resultados,
//       String fuentes_consultadas) async {
//     var htmlContent = """
// <!DOCTYPE html>
// <html lang="en">
// <head>
//     <meta charset="UTF-8">
//     <meta name="viewport" content="width=device-width, initial-scale=1.0">
//     <title>Document</title>
//     <style>
//         body {
//             font-family: Arial, sans-serif;
//             padding: 20px;
//         }
//         .header {
//             text-align: center; /* Cambio a "center" para centrar el texto */
//             margin-bottom: 20px;
//         }
//         .header img {
//             height: 60px;
//             margin: 0 auto; /* Centrar horizontalmente las imágenes */
//             display: block; /* Agregar esta línea para alinear correctamente las imágenes */
//         }
//         .content {
//             text-align: center;
//             margin-bottom: 20px;
//         }
//         .table {
//             width: 100%;
//             border-collapse: collapse;
//         }
//         .table th, .table td {
//             border: 1px solid #000;
//             padding: 8px;
//             text-align: left;
//         }
//     </style>
// </head>
// <body>
//     <div class="header">
//     <img src="${dotenv.env['HOST_REST']}logos/sep.png" alt="">
//         <img src="${dotenv.env['HOST_REST']}logos/tecNM.png" alt="">
//         <img src="${dotenv.env['HOST_REST']}logos/logo_innovaITO.png" alt="">

//     </div>

//     <div class="content">
//         <h2>Detalles del Proyecto</h2>
//     </div>

//     <table class="table">
//         <tr>
//             <th>Folio del proyecto</th>
//             <td>$folio</td>
//         </tr>
//         <tr>
//             <th>Nombre del proyecto</th>
//             <td>$nombre_corto</td>
//         </tr>
//         <tr>
//             <th>Objetivo</th>
//             <td>$objetivo</td>
//         </tr>
//         <tr>
//             <th>Descripción general</th>
//             <td>$descripcion_general</td>
//         </tr>
//         <tr>
//             <th>Prospecto resultados</th>
//             <td>$prospecto_resultados</td>
//         </tr>
//         <tr>
//             <th>Área</th>
//             <td>$nombre_area</td>
//         </tr>
//         <tr>
//             <th>Categoría</th>
//             <td>$nombre_categoria</td>
//         </tr>
//         @if ($memoria!=null)
//         <tr>
//             <th colspan="2">Memoria técnica</th>
//         </tr>
//         <tr>
//             <th>Descripción problemática</th>
//             <td>$descripcion_problematica</td>
//         </tr>
//         <tr>
//             <th>Estado del arte</th>
//             <td>$estado_arte</td>
//         </tr>
//         <tr>
//             <th>Descripción de la innovación</th>
//             <td>$descripcion_innovacion</td>
//         </tr>
//         <tr>
//             <th>Propuesta de valor</th>
//             <td>$propuesta_valor</td>
//         </tr>
//         <tr>
//             <th>Mercado potencial</th>
//             <td>$mercado_potencial</td>
//         </tr>
//         <tr>
//             <th>Viabilidad técnica</th>
//             <td>$viabilidad_tecnica</td>
//         </tr>
//         <tr>
//             <th>Viabilidad financiera</th>
//             <td>$viabilidad_financiera</td>
//         </tr>
//         <tr>
//             <th>Estrategia propiedad intelectual</th>
//             <td>$estrategia_propiedadIntelectual</td>
//         </tr>
//         <tr>
//             <th>Interpretación de resultados</th>
//             <td>$interpretacion_resultados</td>
//         </tr>
//         <tr>
//             <th>Fuentes consultadas</th>
//             <td>$fuentes_consultadas</td>
//         </tr>
//     @endif

// </table>
// </body>
// </html>
// """;

//     Directory appDocDir = await getApplicationDocumentsDirectory();
//     final targetPath = appDocDir.path;
//     final targetFileName = "FichaTecnica-$nombre_corto";

//     final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
//         htmlContent, targetPath, targetFileName);
//     String generatedPdfFilePath = generatedPdfFile.path;
//     return generatedPdfFilePath;
//   }

  static Future<String> salas(List<SalaHs> sala) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final targetPath = appDocDir.path;
    final targetFileName = "Salas_Proyectos";

    String combinedHtml = '''
      <!DOCTYPE html>
      <html lang="es">
      <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Tablas de Salas</title>
          <style>
              body {
                  font-family: Arial, sans-serif;
              }
              .header {
                  display: flex;
                  justify-content: space-between;
                  align-items: center;
                  padding: 0px;
                  background-color: #ffffff;
                  box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
              }
              .logo {
                  max-height: 70px;
              }
              .table-container {
                  margin: 0px;
                  padding: 0; /* Ajuste el padding a 0 */
                  box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
              }
              table {
                  width: 100%;
                  border-collapse: collapse;
                  border: 1px solid #e0e0e0;
              }
              th, td {
                  padding: 0px 10px;
                  text-align: left;
                  border-bottom: 1px solid #e0e0e0;
              }
              th {
                  background-color: #f2f2f2;
              }
              td {
                  font-size: 14px; 
              }
              h1 {
                  font-size: 24px;
                  color: #333333;
                  text-align: center;
                  margin-top: 30px;
              }
          </style>
      </head>
      <body>
          <div class="header">
              <img src="${dotenv.env['HOST_REST']}logos/tecnm.png" alt="Logo 1" class="logo">
              <img src="${dotenv.env['HOST_REST']}logos/logo_innova.png" alt="Logo 2" class="logo">
          </div>
  ''';

    Map<String, List<SalaHs>> categoriasSalas = {};

    for (var dato in sala) {
      if (!categoriasSalas.containsKey(dato.nombreCategoria)) {
        categoriasSalas[dato.nombreCategoria] = [];
      }
      categoriasSalas[dato.nombreCategoria]?.add(dato);
    }

    for (var categoria in categoriasSalas.keys) {
      combinedHtml += '''
          <h1>$categoria</h1>
          <div class="table-container">
              <table>
                  <thead>
                      <tr>
                          <th>Folio</th>
                          <th>Proyecto</th>
                          <th>Sala</th>
                          <th>Sala lugar</th>
                          <th>Hora inicio</th>
                          <th>Hora fin</th>
                      </tr>
                  </thead>
                  <tbody>
      ''';

      for (var dato in categoriasSalas[categoria]!) {
        combinedHtml += '''
          <tr>
            <td>${dato.folio}</td>
            <td>${dato.nombreCorto}</td>
            <td>${dato.nombreSala}</td>
            <td>${dato.lugarSala}</td>
            <td>${dato.horaInicio}</td>
            <td>${dato.horaFinal}</td>
          </tr>
        ''';
      }

      combinedHtml += '''
                  </tbody>
              </table>
          </div>
      ''';
    }

    combinedHtml += '''
      </body>
      </html>
  ''';

    final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        combinedHtml, targetPath, targetFileName);

    // Ruta del archivo PDF generado
    String generatedPdfFilePath = generatedPdfFile.path;
    return generatedPdfFilePath;
  }

  static Future<String> posiciones(List<Tablero> tablero) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final targetPath = appDocDir.path;
    final targetFileName = "posiciones";

    String tablaHtml = '''
      <!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Posiciones</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f7f7f7;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
        }
        .logo {
            max-height: 70px;
        }
        .table-container {
            margin: 20px;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid #cccccc;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #cccccc;
        }
        th {
            background-color: #f2f2f2;
        }
        h1 {
            text-align: center;
            font-size: 25px; /* Tamaño ajustado */
        }
    </style>
</head>
<body>
    <div class="header">
        <img src="${dotenv.env['HOST_REST']}logos/tecnm.png" alt="Logo 1" class="logo">
        <img src="${dotenv.env['HOST_REST']}logos/logo_innova.png" alt="Logo 2" class="logo">
    </div>
    <h1 style="text-align: center;">Tabla de resultados finales</h1>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                <th>Posición</th>
                <th>Folio</th>
                    <th>Proyecto</th>
                    <th>Categoría</th>
                    <th>Calificación</th>
                </tr>
            </thead>
            <tbody>

    ''';

    for (var dato in tablero) {
      tablaHtml += '''
        <tr>
          <td>${dato.posicionActual}</td>
          <td>${dato.folio}</td>
          <td>${dato.nombreProyecto}</td>
          <td>${dato.nombreCategoria}</td>
          <td>${dato.calificacionGlobal}</td>
        </tr>
      ''';
    }

    tablaHtml += '''
                  </tbody>
              </table>
          </div>
      </body>
      </html>
    ''';

    final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        tablaHtml, targetPath, targetFileName);

    // Ruta del archivo PDF generado
    String generatedPdfFilePath = generatedPdfFile.path;
    return generatedPdfFilePath;
  }

  static Future<String> stands(List<StandHs> sala) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final targetPath = appDocDir.path;
    final targetFileName = "Stands_Proyectos";

    String combinedHtml = '''
      <!DOCTYPE html>
      <html lang="es">
      <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Tablas de Salas</title>
          <style>
              body {
                  font-family: Arial, sans-serif;
              }
              .header {
                  display: flex;
                  justify-content: space-between;
                  align-items: center;
                  padding: 0px;
                  background-color: #ffffff;
                  box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
              }
              .logo {
                  max-height: 70px;
              }
              .table-container {
                  margin: 0px;
                  padding: 0; /* Ajuste el padding a 0 */
                  box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
              }
              table {
                  width: 100%;
                  border-collapse: collapse;
                  border: 1px solid #e0e0e0;
              }
              th, td {
                  padding: 0px 10px;
                  text-align: left;
                  border-bottom: 1px solid #e0e0e0;
              }
              th {
                  background-color: #f2f2f2;
              }
              td {
                  font-size: 14px; 
              }
              h1 {
                  font-size: 24px;
                  color: #333333;
                  text-align: center;
                  margin-top: 30px;
              }
          </style>
      </head>
      <body>
          <div class="header">
              <img src="${dotenv.env['HOST_REST']}logos/tecnm.png" alt="Logo 1" class="logo">
              <img src="${dotenv.env['HOST_REST']}logos/logo_innova.png" alt="Logo 2" class="logo">
          </div>
  ''';

    Map<String, List<StandHs>> categoriasSalas = {};

    for (var dato in sala) {
      if (!categoriasSalas.containsKey(dato.nombreCategoria)) {
        categoriasSalas[dato.nombreCategoria] = [];
      }
      categoriasSalas[dato.nombreCategoria]?.add(dato);
    }

    for (var categoria in categoriasSalas.keys) {
      combinedHtml += '''
          <h1>$categoria</h1>
          <div class="table-container">
              <table>
                  <thead>
                      <tr>
                          <th>Folio</th>
                          <th>Proyecto</th>
                          <th>Stand</th>
                          <th>Hora inicio</th>
                          <th>Hora fin</th>
                      </tr>
                  </thead>
                  <tbody>
      ''';

      for (var dato in categoriasSalas[categoria]!) {
        combinedHtml += '''
          <tr>
            <td>${dato.folio}</td>
            <td>${dato.nombreCorto}</td>
            <td>${dato.lugar}</td>
            <td>${dato.horaInicio}</td>
            <td>${dato.horaFinal}</td>
          </tr>
        ''';
      }

      combinedHtml += '''
                  </tbody>
              </table>
          </div>
      ''';
    }

    combinedHtml += '''
      </body>
      </html>
  ''';

    final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        combinedHtml, targetPath, targetFileName);

    // Ruta del archivo PDF generado
    String generatedPdfFilePath = generatedPdfFile.path;
    return generatedPdfFilePath;
  }
}
