import 'dart:io';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

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
      String fuentes_consultadas) async {
    var htmlContent = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        .header {
            text-align: center; /* Cambio a "center" para centrar el texto */
            margin-bottom: 20px;
        }
        .header img {
            height: 60px;
            margin: 0 auto; /* Centrar horizontalmente las imágenes */
            display: block; /* Agregar esta línea para alinear correctamente las imágenes */
        }
        .content {
            text-align: center;
            margin-bottom: 20px;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        .table th, .table td {
            border: 1px solid #000;
            padding: 8px;
            text-align: left;
        }
    </style>
</head>
<body>
    <div class="header">
    <img src="https://evarafael.com/Aplicacion/rest/logos/sep.png" alt="">
        <img src="https://evarafael.com/Aplicacion/rest/logos/tecNM.png" alt="">
        <img src="https://evarafael.com/Aplicacion/rest/logos/logo_innovaITO.png" alt="">
        
    </div>

    <div class="content">
        <h2>Detalles del Proyecto</h2>
    </div>

    <table class="table">
        <tr>
            <th>Folio del proyecto</th>
            <td>$folio</td>
        </tr>
        <tr>
            <th>Nombre del proyecto</th>
            <td>$nombre_corto</td>
        </tr>
        <tr>
            <th>Objetivo</th>
            <td>$objetivo</td>
        </tr>
        <tr>
            <th>Descripción general</th>
            <td>$descripcion_general</td>
        </tr>
        <tr>
            <th>Prospecto resultados</th>
            <td>$prospecto_resultados</td>
        </tr>
        <tr>
            <th>Área</th>
            <td>$nombre_area</td>
        </tr>
        <tr>
            <th>Categoría</th>
            <td>$nombre_categoria</td>
        </tr>
        @if ($memoria!=null)
        <tr>
            <th colspan="2">Memoria técnica</th>
        </tr>
        <tr>
            <th>Descripción problemática</th>
            <td>$descripcion_problematica</td>
        </tr>
        <tr>
            <th>Estado del arte</th>
            <td>$estado_arte</td>
        </tr>
        <tr>
            <th>Descripción de la innovación</th>
            <td>$descripcion_innovacion</td>
        </tr>
        <tr>
            <th>Propuesta de valor</th>
            <td>$propuesta_valor</td>
        </tr>
        <tr>
            <th>Mercado potencial</th>
            <td>$mercado_potencial</td>
        </tr>
        <tr>
            <th>Viabilidad técnica</th>
            <td>$viabilidad_tecnica</td>
        </tr>
        <tr>
            <th>Viabilidad financiera</th>
            <td>$viabilidad_financiera</td>
        </tr>
        <tr>
            <th>Estrategia propiedad intelectual</th>
            <td>$estrategia_propiedadIntelectual</td>
        </tr>
        <tr>
            <th>Interpretación de resultados</th>
            <td>$interpretacion_resultados</td>
        </tr>
        <tr>
            <th>Fuentes consultadas</th>
            <td>$fuentes_consultadas</td>
        </tr>
    @endif

</table>
</body>
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
      String instituto,
      String nombre_participante,
      String rol_participante,
      String nombreProyecto,
      String categoria,
      String coordinador,
      String director) async {
    var htmlContent = """
<!DOCTYPE html>
<html>

<head>
    <title>Constancia</title>
</head>

<body>
    <img src="https://evarafael.com/Aplicacion/rest/logos/sep.png" alt="" style="position: absolute; left: 0; top: 0; height: 60px;">
    <img src="https://evarafael.com/Aplicacion/rest/logos/tecNM.png" alt="Imagen 2"
        style="position: absolute; right: 0; top: 0;  height: 60px;">
    <br>
    <br>

    <div style="text-align: center; margin-top: 140px;">
        <h3>EL INSTITUTO TECNOLÓGICO NACIONAL DE MÉXICO </h3>
        <h3>A TRAVES DEL {{ strtoupper($instituto) }}</h3>
        <h3>OTORGAN EL PRESENTE</h3>
        <BR>
        <h2>RECONOCIMIENTO</h2>
        <h2>A {{strtoupper($nombre_participante)}}</h2>
        <h3>POR SU DESTACADA PARTICIPACIÓN COMO</h3>
        <h3>{{strtoupper($rol_participante)}} DEL PROYECTO {{ strtoupper($nombreProyecto) }}, </h3>
        <h3>EN LA CATEGORÍA {{strtoupper($categoria)}} </h3>
        <h3>EN EL EVENTO INNOVATEC 2023</h3>
        <h3>CELEBRADO DEL</h3> <h3>-AQUI VA LA FECHA-</h3>
        <div style="display: flex;">
            <div>
                <h3 style="flex: 1; text-align: left;">Coordinador: {{ strtoupper($coordinador) }}</h3> <h3 style="flex: 1; text-align: right;">Director: {{ $director }}</h3>     
        </div>
    </div>
</body>

</html>
""";

    Directory appDocDir = await getApplicationDocumentsDirectory();
    final targetPath = appDocDir.path;
    final targetFileName = "constancia";

    final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        htmlContent, targetPath, targetFileName);
    String generatedPdfFilePath = generatedPdfFile.path;
    return generatedPdfFilePath;
  }
}
