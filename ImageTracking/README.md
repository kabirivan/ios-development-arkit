# Seguimiento de una imagen con ARKIT

### Este tutorial tiene como objetivo colocar un objeto 3D en una imagen que ha sido detectada. Se utilizará para animar cambios de rumbo y posición basandose en la transformación de la imagen.

### La api de *reconocimiento de imagen* provee una herramienta para detectar imagenes en el mundo real como una ancla para un objeto 3D o como un trigger para realizar alguna acción.

* Es importante mencionar que los objetos 3D deben estar correctamente alineados con la imagen y el objeto del mundo real para que las personas vean una realidad aumentada más natural. 

* Una de las técnicas más utilizadas es colocar contenido virtual sobre la imágenes estáticas. La ventaja principal que poseen las imágenes estáticas es preparar el entorno (luz constante) para una mejor deteción y sobre todo porque no se mueven.

#### Pero en la vida cotidiana la mayor parte de objetos que se mueven son muy atractivos para las personas. A veces se requiere que la posición del ancla sea dinámica en el mundo real para que el objeto 3D realice un seguimiento y sea más entretenido.





1. Después de encontrar alguna image, agregará o actualizará un **ARImageAnchor** correspondiente que representa la posición y orientación de la imagen detectada.
