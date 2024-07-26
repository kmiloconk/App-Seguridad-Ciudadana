# App-Seguridad-Ciudadana
## Descripción
Esta es una aplicacion diseñada para La Dirección de Seguridad Pública y Protección Civil de la Municipalidad de San Pedro de la Paz en la cual se pueden emitir emergencias y resivirlas desde otro dispositivo 
<br>
Esta es una versión basica desarrollada para Taller de Desarrollo que puede evolucionar en un futuro proyecto de tesis
## Inicializacion
Esta aplicacion está creada con flutter por lo tanto debes tener [Flutter](https://docs.flutter.dev/get-started/install) instalado en un dispositivo <br>
Además se utiliza FireStore como base de datos por lo tanto para conectarse a la base de datos se necesita:
* Instalar Firebase CLI con ```npm install -g firebase-tools```
* Posteriormente tendras que iniciar sesion con  ```firebase login``` (en mi caso es mi cuenta personal de google por eso no la pongo)
  - para utilizar cualquier otra basa de datos  firestore simplemente vas ```lib\app\services\firebase_service.dart``` y en la linea ```CollectionReference collectionReferenceEmergenci = db.collection('people');``` cambias la palabra people por el nombre de la coleccion que vas a usar
* Luego activamos flutter cli en el proyecto con ```dart pub global activate flutterfire_cli```
* Y se termina la configuracion con ```flutterfire configure``` elegiendo el proyecto de FireBase y/o GoogleCould que vas a usar
## Descarga
Si simplemente deseas probar la aplicacion te dejo el link de descarga de la apk [AQUI](https://drive.google.com/file/d/11dMZ7gYr_k1Z3t9Q_RUV2_EIVYwa7IJt/view?usp=sharing)
# Instrucciones de uso
## Login
En el login solo estan validados 2 usuarios:
* El primero es ```user``` que es la vista del usuario (La persona que emite la emergencia) y la contraseña es ```1234```
* El segundo es ```admin``` que es la vista del encargado de realizar las emergencias y la contraseña es ```4321```
![image](https://github.com/user-attachments/assets/b0a6fc6d-3ce6-4a30-bc9b-6539b3040da8)
## Vista usuario
* Si entras como ```user``` veras tu posision en el mapa junto un moton en la parte inferior que dice ```Emergencia``` al oprimirlo le mostra la ventana de creacion de emergencias donde debes poner tu nombre, apellido y un mensaje describiendo la situación
  - ![image](https://github.com/user-attachments/assets/a1eed069-27e2-4359-aed9-4042a6c7678d)
* Al oprimirlo le mostra la ventana de creacion de emergencias donde debes poner tu nombre, apellido y un mensaje describiendo la situación
  - ![image](https://github.com/user-attachments/assets/38fca2d0-ec1e-4322-9011-dbc1ca2a59a3)
* Un vez enviada la emergencia se hara un zoom hacia tu posicion y se dejará una marca en el mapa
  - ![image](https://github.com/user-attachments/assets/ee684209-868b-448b-b38b-4a8f227c5268)
* Al momento de intentar realizar una nueva emergencia saltará un dialogo de advertencia
  - ![image](https://github.com/user-attachments/assets/e7aa2b57-3940-45fe-b303-043b4ac35fc4)

## Vista Administrador
* Si entras como ```admin``` verás una lista con todas las emergencias creadas
  - ![image](https://github.com/user-attachments/assets/8dcd89b6-cf63-43c3-b0e6-162c57fcf8ac)
* Al presionar una te saldrá un un dialogo de confirmación
  - ![image](https://github.com/user-attachments/assets/9190bd53-e74a-4fb5-809e-1127a4433efa)
* Al aceptar te llevará al mapa y te mostrará la ubicación donde se realizó la emergencia
  - ![image](https://github.com/user-attachments/assets/04a5cae5-1861-45aa-9090-cc60fff2b3d4)
* Por ultimo al darle en ```Terminar emergencia``` te saldrá un dialogo de confirmación
  - ![image](https://github.com/user-attachments/assets/59121ea0-add6-4fb4-bb75-f9e4c0f5ba1b)
* Y al aceptar te enviará de nuevo a la pagina de la lista de emergencia y se habrá eliminado la emergencia terminada
  - ![image](https://github.com/user-attachments/assets/300a27a8-fecf-4349-b212-bd7618b41396)
# Autores
Esta aplicacion fue desarrollada unicamente por Camilo Alejandro Figueroa Valderrama para el ramo de Taller de Desarrollo de la Universidad de Bio Bio

