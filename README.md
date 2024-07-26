# App-Seguridad-Ciudadana
## Descripción
Esta es una aplicacion diseñada para La Dirección de Seguridad Pública y Protección Civil de la Municipalidad de San Pedro de la Paz en la cual se pueden emitir emergencias y resivirlas desde otro dispositivo
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
## Instrucciones de uso
