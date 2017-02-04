# Práctica Fundamentos iOS KeepCoding - HackerBooks

##Esta hecho:

- Procesado del JSON (**OK**)

- Carga del JSON desde URL (**OK**) 

No compruebo con NSUserDefaults, busco en la carpeta de documentos si ya me lo he descargado antes.
He creado unas funciones en el fichero *Files.swift* que busca ficheros y/o los crea

- Tabla con celdas personalizadas (**OK**)

- Orden en los tags con primero el Favourite (**OK**)

- Persistencia de los libros marcados como favoritos (**OK**)

He creado una clase, *Favourites.swift* que guarda, elimina y busca si un libro esta entre los favoritos. He usado UserDefaults que me permite guardar objetos enteros, en este caso un array de los nombres de los libros en hash. 
Se podria hacer guardando una lista de libros en un fichero del File System, con CoreData, guardandolo en un plist.
He escogido UserDefaults porque me permite guardar cosas pequeñitas en la memòria del teléfono. Primero pensé de guardar todo el objeto Book, con imagen incluida. Però luego recordé que estoy en un sitio donde la memória es limitada y pense en solo guardar el nombre que ya me sirve para distinguir entre cada uno de ellos. 
Cualquiera de las soluciones era correcta, UserDefaults me pareció fácil!

- Actualizar tabla cuando se marca un favorito (**OK**)

He creado una notificación en el BookViewController. Se notifica al LibraryTableViewController y este hace un reload de toda la tabla.
También se podria hacer que el BookViewController es delegado del LibraryTableViewController y este a su vez del BookViewController (para mostrar la info del libro seleccionado). Creo que las dos opciones són correctas. Aunque me decanté por la primera por sencillez.

Hacer un reload de toda la tabla, en este caso no es tan preocupante. Creo recordar que UITableViewController tiene lazy loading por defecto o se puede implementar. Podria ser interesante cuando hay muchos datos ir cargando cada vez que los pida el usuario (lo que ve en pantalla) no todo de golpe.

- Controlador de libros (**OK**)

- Controlador de PDF (**OK**)

- App Universal con SplitView (**OK**)


##Extras

- a) Le añadiria un buscador encima del LibraryTableViewController por nombre y autor. Un selector de idioma de los libros. Una exportación de los libros pdf y que se puedan enviar por email, slack,... Un apartado de notas por cada libro, para poder hacer anotaciones personales. Que el usuario pudiera subir sus propios libros...

- b) Mañana la subo a la AppStore que es muy tarde :_D

- c) Se podria contactar con alguna editorial de revistas que quisiera publicar sus revistas en pdf a una app. Estos publicarian el json con cada una de las revistas que van publicando y se autopublicarian a la app. Al ser publicaciones no gratuïtas de una editorial, esta app se podria vender. 
Podriamos hacer una versión lite con anuncios y menos funcionalidades como las notas y la actualización automática de libros. Y una versión PRO con todas las funcionalidads y sin anuncios




