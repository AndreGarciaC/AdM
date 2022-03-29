<h1>General</h1>
<b>1. Describa brevemente los diferentes perfiles de familias de microprocesadores/microcontroladores de ARM. Explique alguna de sus diferencias características.</b></br>
  La familia de arquitecturas ARM está comprendida por 3 perfiles:</br>
  <h2>Córtex A</h2> Corresponde a un microprocesador de alto rendimiento orientado a la implementación de sistemas operativos. La sigla "A" que lleva en su nombre hace referencia a que su procesamiento está destinado al de **Aplicaciones**. Ejemplo: Smartphone.</br>
  <h2>Córtex R</h2> Los procesadores de este perfil están orientados a sistemas que requieran baja latencia y alta capacidad de procesamiento. La sigla "R" indica que su implementación está destinada a sistemas **Real Time** ya que garantiza que las tareas serán atendidas en un tiempo determinado. Corresponden a la versión en tiempo real de los córtex A. Ejemplo: Airbag.</br>
  <h2>Córtex M</h2> Serie diseñada para **Microcontroladores**, de ahí la "M" que lleva en su nombre. Está destinada para la producción de sistemas embebidos compactos. Debido     al objeto de su implementación son limitados en memoria y potencia. Ejemplo: Dispositivos de consumo masivo.</br>
  <h1>Córtex M</h1>
<b>1. Describa brevemente las diferencias entre las familias de procesadores Cortex M0, M3 y M4.</b></br>
  <h2>M0</h2>
  Corresponde al procesador ARM más simple de consumo energético ultra bajo. Como componente opcional consta solamente del timer SysTick ya que no está destinado a correr un RTOS. Su arquitectura es Von Neumann y cuenta con un set de solo 56 instrucciones. Todas estas características lo convierte en la opción más económica.</br>
  <h2>M3</h2>
  A diferencia del ejemplar anterior consta de una arquitectura Harvard y provee un set con mayor número de instrucciones. Incluso al ofrecer mayor capacidad de procesamiento logra gestionar la energía, destacándose por su oferta de performance y bajo consumo. Incluye timer SysTick y de manera opcional componentes como Bit-Band memory, MPU y VTOR.  
  <h2>M4</h2>
  Su principal característica consiste en su capacidad de procesamiento de señales digitales. De manera similar a la familia M3 consta de una arquitectura Harvard, provee un set con mayor número de instrucciones y destaca por su bajo consumo energético. Igualemente incluye los mismos componentes que M3.</br>
<b>2. ¿Por qué se dice que el set de instrucciones Thumb permite mayor densidad de código? Explique</b></br>
Al ser un set de instrucciones de 16 bits, la mitad del tamaño de las instrucciones normales de ARM, incrementando la densidad de código </br>
<b>3. ¿Qué entiende por arquitectura load-store? ¿Qué tipo de instrucciones no posee este tipo de arquitectura?</b></br>
La arquitectura Load Store es aquella que no permite operar directamente sobre datos en memoria RAM. Las instrucciones de propósito general operan en registros y luego guardan datos de registro sobre la memoria. Contiene una pila que interactúa con las instrucciones de memoria independiente a otros componentes.
</br>
