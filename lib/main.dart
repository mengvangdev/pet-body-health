import 'package:pet_body_health/resources/resources.dart';
import 'package:pet_body_health/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        /*
         Set BleProvider is the second element because call PetProvider 
         to BleProiver
         Tip: check on Widget Inspector or Widget Tree 
        */

        ChangeNotifierProvider(
          create: (context) => PetProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BleProvider(context),
        ),
        ChangeNotifierProvider(
          create: (context) => PetHealthProvider(sharedPref),
        )
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "pet body health",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 1.4,
              bodyColor: Colors.black,
            ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: themeColor,
          selectionHandleColor: themeColor,
        ),
        // focusColor: Colors.red,
      ),
      home: const MainScreen(),
    );
  }
}
