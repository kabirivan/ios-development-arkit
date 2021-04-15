# Primeros pasos con ARKIT

## ¿Qué es ARKIT ?

> Arkit es un framework que nos ayuda a crear realidad aumentada en nuestras aplicaciones iOS. ARKit utiliza una técnica llamada Odometría Visual Inercial (VIO) la cual combina  información de los sensores de movimiento junto con la cámara del dispositivo.

[<img src="imagesReadme/logo.png" width="400"/>](imagesReadme/logo.png)


Para este ejemplo se ha escogido la tecnología SceneKit la cual es enfocada para objetos en 3D. Si escogemos un template propio de ARKIT en ios, el ejemplo nos muestra un avioncito en nuestra realidad.


[<img src="imagesReadme/plane.jpeg" height="400"/>](imagesReadme/plane.jpeg)


El archivo para entender lo que esta realizando este codigo es el siguiente **ViewController.swift**


Primero se debe definir la clase *ViewController* como:

> `ARSCNViewDelegate :`
> `class ViewController: UIViewController, ARSCNViewDelegate { } `


Ahora se necesita crear una escena para mostrar una imagen virtual. Para esto necesitas crear an *IBOutlet*. El nombre *IBOutlet* puede ser cualquiera que usted desea. Luego la plantilla de la aplicacion de realidad virtual *IBOutlet sceneView* nombra a un objeto *ARSCNView*

> ` @IBOutlet var sceneView: ARSCNView!`

