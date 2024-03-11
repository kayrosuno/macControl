# macControl

Programa para control de redes en mac, ficheros, etc.
WIP

El programa está estructurado en varias partes:
* Interfaz gráfica en swoit para mostrar los datos
* Kernelextension para filtrar las conexiones

Pasos:
En developer.apple.com generar certificados de development, identificadores de la app con las capacidades y por ultimo los profiles para la app y networkextension, descargar y añadir (automaticamente aber una ventana de ajsutes para insertar profiles)

Configurar en xcode el signing manual, seleccionando los perfiles generados.
Añadir en xcode las capacidades de la app, en este caos netwoerk extension y system extension.
Añadir appGroup tambien (TODO, esto funciona??)

La app y el network extension se comunicaon porf medio de mecanismo IPC



