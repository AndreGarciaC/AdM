<h1>General</h1>

<h3><b>1. Describa brevemente los diferentes perfiles de familias de microprocesadores/microcontroladores de ARM. Explique alguna de sus diferencias características.</b></br></h3>
  La familia de arquitecturas ARM está comprendida por 3 perfiles:</br>
  <h4>Córtex A</h4> Corresponde a un microprocesador de alto rendimiento orientado a la implementación de sistemas operativos. La sigla "A" que lleva en su nombre hace referencia a que su procesamiento está destinado al de **Aplicaciones**. Ejemplo: Smartphone.</br>
  <h4>Córtex R</h4> Los procesadores de este perfil están orientados a sistemas que requieran baja latencia y alta capacidad de procesamiento. La sigla "R" indica que su implementación está destinada a sistemas **Real Time** ya que garantiza que las tareas serán atendidas en un tiempo determinado. Corresponden a la versión en tiempo real de los córtex A. Ejemplo: Airbag.</br>
  <h4>Córtex M</h4> Serie diseñada para **Microcontroladores**, de ahí la "M" que lleva en su nombre. Está destinada para la producción de sistemas embebidos compactos. Debido     al objeto de su implementación son limitados en memoria y potencia. Ejemplo: Dispositivos de consumo masivo.</br>


<h1>Córtex M</h1>

<h3><b>1. Describa brevemente las diferencias entre las familias de procesadores Cortex M0, M3 y M4.</b></br></h3>
  <h4>M0</h4>
  Corresponde al procesador ARM más simple de consumo energético ultra bajo. Como componente opcional consta solamente del timer SysTick ya que no está destinado a correr un RTOS. Su arquitectura es Von Neumann y cuenta con un set de solo 56 instrucciones. Todas estas características lo convierte en la opción más económica.</br>
  <h4>M3</h4>
  A diferencia del ejemplar anterior consta de una arquitectura Harvard y provee un set con mayor número de instrucciones. Incluso al ofrecer mayor capacidad de procesamiento logra gestionar la energía, destacándose por su oferta de performance y bajo consumo. Incluye timer SysTick y de manera opcional componentes como Bit-Band memory, MPU y VTOR.  
  <h4>M4</h4>
  Su principal característica consiste en su capacidad de procesamiento de señales digitales. De manera similar a la familia M3 consta de una arquitectura Harvard, provee un set con mayor número de instrucciones y destaca por su bajo consumo energético. Igualmente incluye los mismos componentes que M3.</br>

<h3><b>2. ¿Por qué se dice que el set de instrucciones Thumb permite mayor densidad de código? Explique</b></br></h3>
Al ser un set de instrucciones de 16 bits, la mitad del tamaño de las instrucciones estándar de ARM, actúan como una abreviatura compacta de un subconjunto de dichas instrucciones decrementando la densidad de código. </br>

<h3><b>3. ¿Qué entiende por arquitectura load-store? ¿Qué tipo de instrucciones no posee este tipo de arquitectura?</b></br></h3>
La arquitectura Load Store es aquella que no permite operar directamente sobre datos en memoria RAM. Las instrucciones de propósito general operan en registros y luego guardan datos de registro sobre la memoria. Esto significa que el incremento de un valor de 32 bits en una dirección de memoria específica en ARM requiere cargar primero el valor en una dirección concreta en un registro, incrementarlo dentro del registro y almacenarlo de nuevo en la memoria desde el registro.</br>
Las instrucciones de los microprocesadores de la arquitectura x86, en su mayoría, operan directamente en memoria.</br>

<h3><b>4. ¿Cómo es el mapa de memoria de la familia?</b></br></h3>
La familia Córtex M tiene un espacio para direcciones de memoria de 4Gb, particionado en las siguientes secciones:</br>
  Región de código de programa - Memoria FLASH.</br>
  Región de datos - Memoria SRAM.</br>
  Región de periféricos.</br>
  Control interno - Bus privado.</br>
<b>5. ¿Qué ventajas presenta el uso de los “shadowed pointers” del PSP y el MSP?<b></br>
  Los shadowed pointers permiten ubicar código en diferentes regiones de la memoria. MSP para OS y PSP para aplicaciones.</br>
<b>6. Describa los diferentes modos de privilegio y operación del Cortex M, sus relaciones y como se conmuta de uno al otro. Describa un ejemplo en el que se pasa del modo privilegiado a no privilegiado y nuevamente a privilegiado.<b></br>
  Los microprocesadores Córtex M3 y M4 cuentan con dos modos de privilegio o niveles de acceso: privilegiado y no privilegiado. En el primero, es posible interactuar con todos los recursos del microprocesador, a diferencia del no privilegiado donde se restringen accesos.
<b>7. ¿Qué se entiende por modelo de registros ortogonal? Dé un ejemplo<b></br>
<b>8. ¿Qué ventajas presenta el uso de intrucciones de ejecución condicional (IT)? Dé un ejemplo<b></br>
<b>9. Describa brevemente las excepciones más prioritarias (reset, NMI, Hardfault).<b></br>
<b>10. Describa las funciones principales de la pila. ¿Cómo resuelve la arquitectura el llamado a funciones y su retorno?<b></br>
<b>11. Describa la secuencia de reset del microprocesador.<b></br>
<b>12. ¿Qué entiende por “core peripherals”? ¿Qué diferencia existe entre estos y el resto de los periféricos?<b></br>
<b>13. ¿Cómo se implementan las prioridades de las interrupciones? Dé un ejemplo<b></br>
<b>14. ¿Qué es el CMSIS? ¿Qué función cumple? ¿Quién lo provee? ¿Qué ventajas aporta?<b></br>
<b>15. Cuando ocurre una interrupción, asumiendo que está habilitada ¿Cómo opera el microprocesador para atender a la subrutina correspondiente? Explique con un ejemplo<b></br>
<b>16. ¿Cómo cambia la operación de stacking al utilizar la unidad de punto flotante?<b></br>
<b>17. Explique las características avanzadas de atención a interrupciones: tail chaining y late arrival.<b></br>
<b>18. ¿Qué es el systick? ¿Por qué puede afirmarse que su implementación favorece la portabilidad de los sistemas operativos embebidos?<b></br>
<b>19. ¿Qué funciones cumple la unidad de protección de memoria (MPU)?<b></br>
<b>20. ¿Cuántas regiones pueden configurarse como máximo? ¿Qué ocurre en caso de haber solapamientos de las regiones? ¿Qué ocurre con las zonas de memoria no cubiertas por las regiones definidas?<b></br>
<b>21. ¿Para qué se suele utilizar la excepción PendSV? ¿Cómo se relaciona su uso con el resto de las excepciones? Dé un ejemplo.<b></br>
<b>22. ¿Para qué se suele utilizar la excepción SVC? Expliquelo dentro de un marco de un sistema operativo embebido.<b></br>
<h1>ISA</h1>
<b>1. ¿Qué son los sufijos y para qué se los utiliza? Dé un ejemplo.<b></br>
<b>2. ¿Para qué se utiliza el sufijo ‘s’? Dé un ejemplo.<b></br>
<b>3. ¿Qué utilidad tiene la implementación de instrucciones de aritmética saturada? Dé un ejemplo con operaciones con datos de 8 bits.<b></br>
<b>4. Describa brevemente la interfaz entre assembler y C ¿Cómo se reciben los argumentos de las funciones? ¿Cómo se devuelve el resultado? ¿Qué registros deben guardarse en la pila antes de ser modificados?<b></br>
<b>5. ¿Qué es una instrucción SIMD? ¿En qué se aplicany que ventajas reporta su uso? Dé un ejemplo.<b></br>
