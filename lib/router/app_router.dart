import 'package:go_router/go_router.dart';
import 'package:innova_ito/screens/asesor_lider_screen.dart';
import 'package:innova_ito/screens/asignar_stand_screen.dart';
import 'package:innova_ito/screens/estado_admin_screen.dart';
import 'package:innova_ito/screens/screens.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/acceso',
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
      builder: (context, state) => CarreraScreen(),
    ),
    GoRoute(
      path: '/departamento',
      name: DepartamentoScreen.name,
      builder: (context, state) => DepartamentoScreen(),
    ),
    GoRoute(
      path: '/agregar_carrera',
      name: AgregarCarreraScreen.name,
      builder: (context, state) => AgregarCarreraScreen(),
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
    GoRoute(
      path: '/agregar_departamento',
      name: AgregarDepartamentoScreen.name,
      builder: (context, state) => AgregarDepartamentoScreen(),
    ),
    GoRoute(
      path: '/inicioLider',
      name: InicioLiderScreen.name,
      builder: (context, state) => InicioLiderScreen(),
    ),
    GoRoute(
      path: '/participantes',
      name: ParticipanteScreen.name,
      builder: (context, state) => ParticipanteScreen(),
    ),
    GoRoute(
      path: '/agregar_participantes',
      name: AgregarParticipanteScreen.name,
      builder: (context, state) => AgregarParticipanteScreen(),
    ),
    GoRoute(
      path: '/criterios',
      name: CriteriosScreen.name,
      builder: (context, state) => CriteriosScreen(),
    ),
    GoRoute(
      path: '/actualizar_lider',
      name: ActualizarDatosLiderScreen.name,
      builder: (context, state) => ActualizarDatosLiderScreen(),
    ),
    GoRoute(
      path: '/requerimientos',
      name: RequerimientosScreen.name,
      builder: (context, state) => RequerimientosScreen(),
    ),
    GoRoute(
      path: '/categoria_admin',
      name: CategoriaAdminScreen.name,
      builder: (context, state) => CategoriaAdminScreen(),
    ),
    GoRoute(
      path: '/estado_admin',
      name: EstadoAdminScreen.name,
      builder: (context, state) => EstadoAdminScreen(),
    ),
    GoRoute(
      path: '/nivel_admin',
      name: NivelAdminScreen.name,
      builder: (context, state) => NivelAdminScreen(),
    ),
    GoRoute(
      path: '/naturaleza_admin',
      name: NaturalezaAdminScreen.name,
      builder: (context, state) => NaturalezaAdminScreen(),
    ),
    GoRoute(
      path: '/region_admin',
      name: RegionAdminScreen.name,
      builder: (context, state) => RegionAdminScreen(),
    ),
    GoRoute(
      path: '/genero_admin',
      name: GeneroAdminScreen.name,
      builder: (context, state) => GeneroAdminScreen(),
    ),
    GoRoute(
      path: '/modelo_negocio',
      name: ModeloNegocioScreen.name,
      builder: (context, state) => ModeloNegocioScreen(),
    ),
    GoRoute(
      path: '/agregar_rubrica',
      name: AgregarRubricaScreen.name,
      builder: (context, state) => AgregarRubricaScreen(),
    ),
    GoRoute(
      path: '/RubricaScreen',
      name: RubricaScreen.name,
      builder: (context, state) => RubricaScreen(),
    ),
    GoRoute(
      path: '/requerimientos_lider',
      name: RequerimientosLiderScreen.name,
      builder: (context, state) => RequerimientosLiderScreen(),
    ),
    GoRoute(
      path: '/asesor_lider',
      name: AsesorLiderScreen.name,
      builder: (context, state) => AsesorLiderScreen(),
    ),
    GoRoute(
      path: '/proyecto_asesor',
      name: ProyectoAsesorScreen.name,
      builder: (context, state) => ProyectoAsesorScreen(),
    ),
    GoRoute(
      path: '/proyecto_coordinador',
      name: ProyectoCoordinadorScreen.name,
      builder: (context, state) => ProyectoCoordinadorScreen(),
    ),
    GoRoute(
      path: '/asignar_sala',
      name: AsignarSalaScreen.name,
      builder: (context, state) => AsignarSalaScreen(),
    ),
    GoRoute(
      path: '/asignar_stand',
      name: AsignarStandScreen.name,
      builder: (context, state) => AsignarStandScreen(),
    ),
    GoRoute(
      path: '/sala',
      name: SalaScreen.name,
      builder: (context, state) => SalaScreen(),
    ),
    GoRoute(
      path: '/stand',
      name: StandScreen.name,
      builder: (context, state) => StandScreen(),
    ),
    GoRoute(
      path: '/registroUsuarioJurado',
      name: RegistroUsuarioJuradoScreen.name,
      builder: (context, state) => RegistroUsuarioJuradoScreen(),
    ),
    GoRoute(
      path: '/salaLiderScreen',
      name: SalaLiderScreen.name,
      builder: (context, state) => SalaLiderScreen(),
    ),
    GoRoute(
      path: '/proyectoEvaluarScreen',
      name: ProyectoEvaluarSreen.name,
      builder: (context, state) => ProyectoEvaluarSreen(),
    ),
    GoRoute(
      path: '/AsignarProyectoJuradoScreen',
      name: AsignarProyectoJuradoScreen.name,
      builder: (context, state) => AsignarProyectoJuradoScreen(),
    ),
    GoRoute(
      path: '/SeleccionaProyectoJuradoScreen',
      name: SeleccionaProyectoJuradoScreen.name,
      builder: (context, state) => SeleccionaProyectoJuradoScreen(),
    ),
    GoRoute(
      path: '/ProyectoEvaluarStandSreen',
      name: ProyectoEvaluarStandSreen.name,
      builder: (context, state) => ProyectoEvaluarStandSreen(),
    ),
    GoRoute(
      path: '/EvaluarSalaSreen',
      name: EvaluarSalaScreen.name,
      builder: (context, state) => EvaluarSalaScreen(),
    ),
    GoRoute(
      path: '/EvaluarStandSreen',
      name: EvaluarStandScreen.name,
      builder: (context, state) => EvaluarStandScreen(),
    ),
    GoRoute(
      path: '/GeneracionConstanciaScreen',
      name: GeneracionConstanciaScreen.name,
      builder: (context, state) => GeneracionConstanciaScreen(),
    ),
    GoRoute(
      path: '/GeneraPdfScreen',
      name: GeneraPdfScreen.name,
      builder: (context, state) => GeneraPdfScreen(),
    ),
  ],
);
