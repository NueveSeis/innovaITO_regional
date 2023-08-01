import 'package:go_router/go_router.dart';
import 'package:innova_ito/screens/screens.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/menu_lateral',
  routes: [
    GoRoute(
      path: '/inicio',
      name: InicioScreen.name,
      builder: (context, state) => const InicioScreen(),
    ),
    GoRoute(
      path: '/detalles',
      name: DetallesScreen.name,
      builder: (context, state) => const DetallesScreen(),
    ),
    GoRoute(
      path: '/acceso',
      name: AccesoScreen.name,
      builder: (context, state) => AccesoScreen(),
    ),
    GoRoute(
      path: '/menu_lateral',
      name: MenuLateral.name,
      builder: (context, state) => const MenuLateral(),
    ),
    GoRoute(
      path: '/proyectos',
      name: ProyectosPendientesScreen.name,
      builder: (context, state) => const ProyectosPendientesScreen(),
    ),
    GoRoute(
      path: '/registro_usuario',
      name: RegistroUsuarioScreen.name,
      builder: (context, state) => const RegistroUsuarioScreen(),
    ),
    GoRoute(
      path: '/registro_usuario_lider',
      name: RegistroUsuarioLiderScreen.name,
      builder: (context, state) => const RegistroUsuarioLiderScreen(),
    ),
    GoRoute(
      path: '/registro_usuario_asesor',
      name: RegistroUsuarioAsesorScreen.name,
      builder: (context, state) => const RegistroUsuarioAsesorScreen(),
    ),
    GoRoute(
      path: '/ficha_tecnica',
      name: FichaTecnicaScreen.name,
      builder: (context, state) => FichaTecnicaScreen(),
    ),
    GoRoute(
      path: '/carrera',
      name: CarreraScreen.name,
      builder: (context, state) => const CarreraScreen(),
    ),
    GoRoute(
      path: '/departamento',
      name: DepartamentoScreen.name,
      builder: (context, state) => DepartamentoScreen(),
    ),
    GoRoute(
      path: '/agregar_carrera',
      name: AgregarCarreraScreen.name,
      builder: (context, state) => const AgregarCarreraScreen(),
    ),
    GoRoute(
      path: '/asignacion_fechas',
      name: AsignacionFechasScreen.name,
      builder: (context, state) => const AsignacionFechasScreen(),
    ),
    GoRoute(
      path: '/seleccionar_categoria',
      name: SeleccionCategoriaScreen.name,
      builder: (context, state) => SeleccionCategoriaScreen(),
    ),
    GoRoute(
      path: '/memoria_tecnica',
      name: MemoriaTecnicaScreen.name,
      builder: (context, state) => MemoriaTecnicaScreen(),
    ),
    GoRoute(
      path: '/menu',
      name: MenuScreen.name,
      builder: (context, state) => MenuScreen(),
    ),
    GoRoute(
      path: '/tabla_posiciones',
      name: TablaPosicionesScreen.name,
      builder: (context, state) => TablaPosicionesScreen(),
    ),
    GoRoute(
      path: '/RecuperarContrasena',
      name: RecuperarContrasenaScreen.name,
      builder: (context, state) => RecuperarContrasenaScreen(),
    ),
    //  GoRoute(
    //   path: '/pdf',
    //   name: PdfScreen.name,
    //   builder: (context, state) => PdfScreen(),
    // ),
  ],
);
