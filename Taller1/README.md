# ComputacionVisual

# Taller 1 - Análisis de imágenes por software

## Propósito

Introducir el análisis de imágenes/video en el lenguaje de [Processing](https://processing.org/).

## Tareas

Implementar las siguientes operaciones de análisis para imágenes/video:

* Conversión a escala de grises: promedio _rgb_ y [luma](https://en.wikipedia.org/wiki/HSL_and_HSV#Disadvantages).
* Aplicación de algunas [máscaras de convolución](https://en.wikipedia.org/wiki/Kernel_(image_processing)).
* (solo para imágenes) Despliegue del histograma.
* (solo para imágenes) Segmentación de la imagen a partir del histograma.
* (solo para video) Medición de la [eficiencia computacional](https://processing.org/reference/frameRate.html) para las operaciones realizadas.

Emplear dos [canvas](https://processing.org/reference/PGraphics.html), uno para desplegar la imagen/video original y el otro para el resultado del análisis.

### Alternativas para video en Linux y `gstreamer >=1`

Distribuciones recientes de Linux que emplean `gstreamer >=1`, requieren alguna de las siguientes librerías de video:

1. [Beta oficial](https://github.com/processing/processing-video/releases).
2. [Gohai port](https://github.com/gohai/processing-video/releases/tag/v1.0.2).

Descompriman el archivo `*.zip` en la caperta de `libraries` de su sketchbook (e.g., `$HOME/sketchbook/libraries`) y probar cuál de las dos va mejor.

## Integrantes

| Integrante           | Github Nick  |
|----------------------|--------------|
| Luis Enrique Guzmán  | [leguzman](https://github.com/leguzman)|
| Daniel Caita         | [dacaitac](https://github.com/dacaitac)|
| Andrés Felipe Forero | [afforeroc](https://github.com/afforeroc)|

## Discusión
Se aplicaron varios filtros tanto a imagen como a video. Se elaboró un histograma para la escala de grises en el caso de la imagen.
Para la realización de este taller se reutilizo código de ejemplos de histrograma y escala de grises en la pagina de processing:
https://processing.org/examples/

(describa brevemente las actividades realizadas y los resultados obtenidos)
