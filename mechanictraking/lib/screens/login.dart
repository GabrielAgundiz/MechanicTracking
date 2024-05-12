import 'package:email_validator/email_validator.dart'; // Importa el paquete email_validator para validar correos electrónicos.
import 'package:firebase_auth/firebase_auth.dart'; // Importa la autenticación de Firebase.
import 'package:flutter/material.dart'; // Importa el paquete flutter material.
import 'package:google_fonts/google_fonts.dart'; // Importa el paquete google_fonts para fuentes personalizadas.
import 'package:mechanictracking/screens/recovery.dart'; // Importa la pantalla de recuperación de contraseña.
import 'package:mechanictracking/screens/register.dart'; // Importa la pantalla de registro.
import 'package:mechanictracking/screens/user/home.dart'; // Importa la pantalla de inicio de la aplicación.
import 'package:mechanictracking/widgets/utils.dart'; // Importa utilidades personalizadas.

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() =>
      _LoginPageState(); // Define el estado para la página de inicio de sesión.
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HomePage(); // Si hay datos de usuario, muestra la página de inicio.
              } else {
                return LoginPage(); // Si no hay datos de usuario, muestra la página de inicio de sesión.
              }
            }),
      );
}

class _LoginPageState extends State<LoginPage> {
  final _emailController =
      TextEditingController(); // Controlador para el campo de correo electrónico.
  final _passwordController =
      TextEditingController(); // Controlador para el campo de contraseña.
  final formKey = GlobalKey<FormState>(); // Clave global para el formulario.

  bool obscureText =
      true; // Variable para controlar la visibilidad de la contraseña.

  @override
  void dispose() {
    _emailController.dispose(); // Limpia el controlador de correo electrónico.
    _passwordController.dispose(); // Limpia el controlador de contraseña.

    super.dispose();
  }

  Future signIn() async {
    final isValid = formKey.currentState!.validate(); // Valida el formulario.
    if (!isValid) return;
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text
            .trim(), // Obtiene el correo electrónico del controlador y elimina espacios en blanco.
        password: _passwordController.text
            .trim(), // Obtiene la contraseña del controlador y elimina espacios en blanco.
      );
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage()), // Navega a la página de inicio.
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Navigator.pop(context); // Cerrar el diálogo de carga.
      if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(seconds: 9), () {
              Navigator.of(context).pop(
                  true); // Cerrar el diálogo de error después de un segundo.
            });
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Contraseña incorrecta. Inténtalo de nuevo.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Cerrar el diálogo de error.
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
      } else {
        Utils.showSnackBar(e.message ?? 'Error desconocido');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Theme(
          data: ThemeData(
            fontFamily: 'Roboto',
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Accede',
                    style: GoogleFonts.roboto(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Container(
                    // Contenedor decorado para el campo de correo electrónico.
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Color de fondo del contenedor.
                      borderRadius: BorderRadius.circular(
                          10), // Bordes redondeados del contenedor.
                    ),
                    child: TextFormField(
                      controller:
                          _emailController, // Controlador para el campo de texto del correo electrónico.
                      decoration: const InputDecoration(
                        labelText: 'Email', // Etiqueta del campo de texto.
                        hintText:
                            'example@email.com', // Texto de sugerencia dentro del campo de texto.
                        prefixIcon: Icon(Icons
                            .email), // Icono del prefijo para el correo electrónico.
                        border: InputBorder
                            .none, // Sin borde alrededor del campo de texto.
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical:
                                12), // Espaciado interno del campo de texto.
                      ),
                      validator: (email) => email != null &&
                              !EmailValidator.validate(
                                  email) // Validación del correo electrónico utilizando el paquete 'email_validator'.
                          ? 'Ingresa un correo valido' // Mensaje de error si el correo electrónico no es válido.
                          : null, // Retorna null si el correo electrónico es válido.
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    // Contenedor decorado para el campo de contraseña.
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Color de fondo del contenedor.
                      borderRadius: BorderRadius.circular(
                          10), // Bordes redondeados del contenedor.
                    ),
                    child: TextFormField(
                      controller:
                          _passwordController, // Controlador para el campo de texto de la contraseña.
                      decoration: InputDecoration(
                        labelText: 'Contraseña', // Etiqueta del campo de texto.
                        hintText:
                            '••••••••', // Texto de sugerencia dentro del campo de texto.
                        prefixIcon: const Icon(Icons
                            .lock), // Icono del prefijo para la contraseña.
                        suffixIcon: IconButton(
                          // Icono del sufijo para alternar la visibilidad de la contraseña.
                          icon: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.remove_red_eye,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureText =
                                  !obscureText; // Cambia la visibilidad de la contraseña.
                            });
                          },
                        ),
                        border: InputBorder
                            .none, // Sin borde alrededor del campo de texto.
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical:
                                12), // Espaciado interno del campo de texto.
                      ),
                      obscureText:
                          obscureText, // Indica si el texto debe ser ocultado (contraseña).
                      autovalidateMode: AutovalidateMode
                          .onUserInteraction, // Valida automáticamente la entrada del usuario.
                      validator: (value) => value != null && value.length < 8
                          ? 'Contraseña Incorrecta' // Mensaje de error si la contraseña es incorrecta (menos de 8 caracteres).
                          : null, // Retorna null si la contraseña es válida.
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  ElevatedButton(
                    // Botón elevado para iniciar sesión.
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(
                          double.infinity, 50), // Tamaño mínimo del botón.
                      backgroundColor:
                          Colors.green[400], // Color de fondo del botón.
                      foregroundColor:
                          Colors.white, // Color del texto del botón.
                    ),
                    child:
                        const Text('Iniciar sesión'), // Texto dentro del botón.
                    onPressed: () async {
                      try {
                        await signIn(); // Intenta iniciar sesión utilizando el método signIn definido previamente.
                      } catch (e) {
                        if (e is FirebaseAuthException &&
                            e.code == 'wrong-password') {
                          // Si se produce un error de contraseña incorrecta, muestra un Snackbar.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Contraseña incorrecta'), // Mensaje de error.
                              backgroundColor:
                                  Colors.red, // Color de fondo del Snackbar.
                            ),
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 40.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RecoverPasswordPage()), // Navega a la página de recuperación de contraseña.
                      );
                    },
                    child: Text(
                      '¿Olvidaste tu contraseña?',
                      style: GoogleFonts.roboto(
                        color: const Color(0xFF5DB075),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisterPage()), // Navega a la página de registro.
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: '¿Aún no tienes una cuenta? ',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'Regístrate',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: const Color(0xFF5DB075),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
