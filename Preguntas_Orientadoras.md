<h1>General</h1>

<h3><b>1. Describa brevemente los diferentes perfiles de familias de microprocesadores/microcontroladores de ARM. Explique alguna de sus diferencias características.</b><br></h3>
  La familia de arquitecturas ARM está comprendida por 3 perfiles:<br>
  <h4>Córtex A</h4> Corresponde a un microprocesador de alto rendimiento orientado a la implementación de sistemas operativos. La sigla "A" que lleva en su nombre hace referencia a que su procesamiento está destinado al de **Aplicaciones**. Ejemplo: Smartphone.<br>
  <h4>Córtex R</h4> Los procesadores de este perfil están orientados a sistemas que requieran baja latencia y alta capacidad de procesamiento. La sigla "R" indica que su implementación está destinada a sistemas **Real Time** ya que garantiza que las tareas serán atendidas en un tiempo determinado. Corresponden a la versión en tiempo real de los córtex A. Ejemplo: Airbag.<br>
  <h4>Córtex M</h4> Serie diseñada para **Microcontroladores**, de ahí la "M" que lleva en su nombre. Está destinada para la producción de sistemas embebidos compactos. Debido     al objeto de su implementación son limitados en memoria y potencia. Ejemplo: Dispositivos de consumo masivo.<br>


<h1>Córtex M</h1>

<h3><b>1. Describa brevemente las diferencias entre las familias de procesadores Cortex M0, M3 y M4.</b><br></h3>
  <h4>M0</h4>
  Corresponde al procesador ARM más simple de consumo energético ultra bajo. Como componente opcional consta solamente del timer SysTick ya que no está destinado a correr un RTOS. Su arquitectura es Von Neumann y cuenta con un set de solo 56 instrucciones. Todas estas características lo convierte en la opción más económica.<br>
  <h4>M3</h4>
  A diferencia del ejemplar anterior consta de una arquitectura Harvard y provee un set con mayor número de instrucciones. Incluso al ofrecer mayor capacidad de procesamiento logra gestionar la energía, destacándose por su oferta de performance y bajo consumo. Incluye timer SysTick y de manera opcional componentes como Bit-Band memory, MPU y VTOR.  
  <h4>M4</h4>
  Su principal característica consiste en su capacidad de procesamiento de señales digitales. De manera similar a la familia M3 consta de una arquitectura Harvard, provee un set con mayor número de instrucciones y destaca por su bajo consumo energético. Igualmente incluye los mismos componentes que M3.<br>

<h3><b>2. ¿Por qué se dice que el set de instrucciones Thumb permite mayor densidad de código? Explique</b><br></h3>
Al ser un set de instrucciones de 16 bits, la mitad del tamaño de las instrucciones estándar de ARM, actúan como una abreviatura compacta de un subconjunto de dichas instrucciones decrementando la densidad de código. <br>

<h3><b>3. ¿Qué entiende por arquitectura load-store? ¿Qué tipo de instrucciones no posee este tipo de arquitectura?</b><br></h3>
La arquitectura Load Store es aquella que no permite operar directamente sobre datos en memoria RAM. Las instrucciones de propósito general operan en registros y luego guardan datos de registro sobre la memoria. Esto significa que el incremento de un valor de 32 bits en una dirección de memoria específica en ARM requiere cargar primero el valor en una dirección concreta en un registro, incrementarlo dentro del registro y almacenarlo de nuevo en la memoria desde el registro.<br>
Las instrucciones de los microprocesadores de la arquitectura x86, en su mayoría, operan directamente en memoria.<br>

<h3><b>4. ¿Cómo es el mapa de memoria de la familia?</b><br></h3>
La familia Córtex M tiene un espacio para direcciones de memoria de 4Gb, particionado en las siguientes secciones:<br>
  Región de código de programa - Memoria FLASH.<br>
  Región de datos - Memoria SRAM.<br>
  Región de periféricos.<br>
  Control interno - Bus privado.<br>
<h3><b>5. ¿Qué ventajas presenta el uso de los “shadowed pointers” del PSP y el MSP?</b><br></h3>
Los shadowed pointers permiten ubicar código en diferentes regiones de la memoria. MSP para OS e interrupciones y PSP para tareas.<br>

Al manejar punteros de manera independiente entre el sistema operativo y la tareas, garantizamos que si se da un error de stack en una de estas últimas, el kernel seguirá corriendo sin corromperse, garantizando la eficiencia del sistema en esa perspectiva.<br>

<h3><b>6. Describa los diferentes modos de privilegio y operación del Cortex M, sus relaciones y como se conmuta de uno al otro. Describa un ejemplo en el que se pasa del modo privilegiado a no privilegiado y nuevamente a privilegiado.</b><br></h3>
  <h4>Modos de privilegio</h4>
Los microprocesadores Córtex M3 y M4 cuentan con dos modos de privilegio o niveles de acceso: privilegiado y no privilegiado. En el primero, es posible interactuar con todas las areas de memoria, a diferencia del no privilegiado donde se restringen accesos mediante la activación del MPU.<br>
  <h4>Modos de operación</h4>
Los microprocesadores Córtex M3 y M4 tienen dos modos de operación: Handler, en donde se ejecutan las excepciones y Thread, que constituye al modo por defecto en donde corre código común, este a su vez puede ser privilegiado o no privilegiado.<br>
  <h4>Ejemplo de cambio de modo de privilegio</h4>

Por defecto los procesadores inician en modo privilegiado. El software puede cambiar el procesador en modo Thread privilegiado a modo Thread no privilegiado (no puede hacerlo viceversa) escribiendo en el registro de CONTROL, que sólo puede ser modificado en el modo privilegiado. Modificando nPRIV a 1 se definiría el nivel de privilegio en el modo Thread como no privilegiado.

<h3><b>7. ¿Qué se entiende por modelo de registros ortogonal? Dé un ejemplo.</b><br></h3>
Registro que puede hacer uso de diferentes modos de direccionamiento mismo que es independiente de la instrucción.

```assembly
mov PC, #0
```

<h3><b>8. ¿Qué ventajas presenta el uso de intrucciones de ejecución condicional (IT)? Dé un ejemplo</b><br></h3>
Las instrucciones IT (IF-THEN) permiten que hasta 4 instrucciones precedentes, ya sean de procesamiento de datos o acceso de memoria, puedan ser ejecutadas condicionalmente. Esto da lugar a la optimización del largo de código evitando el costo que representa la implementación de branches, sobretodo en casos cuando se requieren branches condicionales y no condicionales.<br>
Ejemplo: <br>

```assembly
CMP R0, #0			@Compara el dato del registro R0 y el valor 0.
ITT GT				@Las siguientes instrucciones se ejecutan si R0 es GREATER THAN 0. Actualiza las banderas APSR.
MULGT R0, R0, R1	@Si es GREATER THAN Multiplica R0 x R1 y guarda el resultado en R0.
MOVGT R1, R0		@Si es GREATER THAN Mueve los datos de R0 al registro destino R1.
```

<h3><b>9. Describa brevemente las excepciones más prioritarias (reset, NMI, Hardfault).</b><br></h3>
 Los microprocesadores Córtex M cuentan con un mecanismo de excepciones incluido para que, en el caso de que ocurra un error, se activen diferentes tipos de handlers. Entre las principales excepciones podemos encontrar:<br>
<h4>Reset</h4> Ocurre con el reinicio del microprocesador, deteniendo su operación en cualquier instrucción.<br>
<h4>Non-Maskable Interrupt (NMI)</h4> Está siempre habilitada debido a que, en el escenario de que fallen otros handlers de excepciones, se genere una interrupción.<br>
<h4>Hardfault</h4> Un HardFault es una excepción que se produce debido a un fallo de sistema. Gestiona diferentes errores como accesos no pemitidos o a mala memoria, entre otros.
<h3><b>10. Describa las funciones principales de la pila. ¿Cómo resuelve la arquitectura el llamado a funciones y su retorno?</b><br></h3>
En los procesadores ARM, la pila funciona como un mecanismo de uso de memoria que da lugar a que una porción de la misma sea utilizada como un buffer para almacenamiento de datos. La pila o stack es usada para transferir informacion a diferentes rutinas, almacenar variables locales, así como para el almacenamiento temporal durante operaciones con registros y también guarda el estado del procesador y los registros al momento de una excepción.<br>
En el caso específico de funciones, se hace uso de las instrucciones PUSH y POP. Cuando se llama una función los valores de los registros son guardados en el stack mediante la instrucción PUSH y luego son retornados a sus valores originales utilizando POP.
<h3><b>11. Describa la secuencia de reset del microprocesador.</b><br></h3>
1. Actualizar el valor del MSP.<br>
2. El inicio del espacio de memoria contiene la tabla de vectores, por lo que lo siguiente es leer dos primeras palabras que son: valor del MSP y vector de reset (dirección de inicio del manejador de reset).<br>
3. Configurar el MSP y el Contador de Programa con los valores leídos.<br>

<h3><b>12. ¿Qué entiende por “core peripherals”? ¿Qué diferencia existe entre estos y el resto de los periféricos?</b><br></h3>

Los core peripherals son componentes periféricos con un funcionamiento definido dependientes del procesador y cuyo comportamiento es estándar y reusable en toda la gama de procesadores Córtex M. <br>
Los periféricos que no entran en esta clasificación no requieren una interacción del procesador y pueden presentar características adicionales para implementar diversas funciones.

<h3><b>13. ¿Cómo se implementan las prioridades de las interrupciones? Dé un ejemplo</b><br></h3>
La implementación de prioridades de interrupción mejora la capacidad de respuesta del sistema. A las interrupciones de diferentes periféricos se les pueden atribuir distintos niveles de prioridad y, en Cortex-M3 y Cortex-M4, los niveles de prioridad se pueden cambiar dinámicamente en tiempo de ejecución.<br>
A los periféricos relevantes se les puede asignar un nivel de prioridad más alto que el de cualquier otra tarea, mismas que se suspenderán dando paso inmediato a la interrupción y su servicio.<br>
La forma más adecuada de asignar prioridades es a través de las funciones de acceso de CMSIS-Core, por ejemplo:

```c
void NVIC_SetPriority (IRQn_Type IRQn,uint32_t priority)
```
<h3><b>14. ¿Qué es el CMSIS? ¿Qué función cumple? ¿Quién lo provee? ¿Qué ventajas aporta?</b><br></h3>

El estándar de interfaz de software para microcontroladores Cortex, CMSIS por sus siglas en inglés, es un framework de software desarrollado por ARM que abarca la mayoría de los procesadores Cortex-M y sus productos. El objetivo de su creación es estandarizar y garantizar la compatibilidad del software con varias herramientas de desarrollo y entre diferentes soluciones de software.

Las ventajas de CMSIS incluyen:<br>
Mejora de la reutilización del software.<br>
Mayor compatibilidad del software.<br>
Facilidad de aprendizaje.<br>
Independencia de toolchain.<br>

<h3><b>15. Cuando ocurre una interrupción, asumiendo que está habilitada ¿Cómo opera el microprocesador para atender a la subrutina correspondiente? Explique con un ejemplo</b><br></h3>
<h3><b>16. ¿Cómo cambia la operación de stacking al utilizar la unidad de punto flotante?</b><br></h3>
<h3><b>17. Explique las características avanzadas de atención a interrupciones: tail chaining y late arrival.</b><br></h3>
<h3><b>18. ¿Qué es el systick? ¿Por qué puede afirmarse que su implementación favorece la portabilidad de los sistemas operativos embebidos?</b><br></h3>
Es un timer decremental de 24 bits integrado de manera opcional o fija en los Córtex M. Funciona como parte del NVIC por lo que al llegar a cero genera un interrupción. Se considera como un aporte a la portabilidad del OS embebido porque el timer en mención está incluido y es estándar dentro de todos los procesadores por lo que el sistema operativo escrito para un microprocesador en específico puede ser reusado.
<h3><b>19. ¿Qué funciones cumple la unidad de protección de memoria (MPU)?</b><br></h3>
La unidad de protección de memoria es un componente presente de manera opcional en los procesadores ARM a partir del Córtex M3 y en el Córtex M0+. Es utilizado para establecer condiciones de acceso a memoria, definir regiones de memoria, asignar permisos de acceso y definir los atributos de dichas regiones. Usualmente en sistemas bare-metal es usada bajo una configuración estática para manipular la RAM/SRAM. Se puede implementar lo mismo en sistemas embebidos con sistemas operativos, pero, es posible también llevar a cabo acciones de protección en cada cambio de contexto.
<h3><b>20. ¿Cuántas regiones pueden configurarse como máximo? ¿Qué ocurre en caso de haber solapamientos de las regiones? ¿Qué ocurre con las zonas de memoria no cubiertas por las regiones definidas?</b><br></h3>
En Córtex M, la MPU soporta 8 regiones, en el caso de haber solapamientos los permisos de acceso y los atributos serán asignados a la dirección de memoria ubicada en la región de mayor número. En el caso que una ubicación de memoria no esté definida en una región del MPU, se genera una excepción de error y la transferencia de datos es bloqueada.
<h3><b>21. ¿Para qué se suele utilizar la excepción PendSV? ¿Cómo se relaciona su uso con el resto de las excepciones? Dé un ejemplo.</b><br></h3>
<h3><b>22. ¿Para qué se suele utilizar la excepción SVC? Expliquelo dentro de un marco de un sistema operativo embebido.</b><br></h3>
El mecanismo de excepción SVC (Supervisor Call) proporciona la transición de no privilegiado a privilegiado. En el marco de un sistema operativo embebido, el SVC se utiliza por una tarea de aplicación que se ejecuta sin privilegios para solicitar servicios al sistema operativo, mismo que corre en un estado de ejecución con privilegios. 
<h1>ISA</h1>
<h3><b>1. ¿Qué son los sufijos y para qué se los utiliza? Dé un ejemplo.</b><br></h3>
En los procesadores ARM los sufijos son un conjunto de letras -afijo- que preceden una instrucción. Estos son utilizados para actualizar las banderas del registro de estado APSR como el caso del sufijo "S"; para la ejecución condicional de instrucciones, ejemplo la condición mayor que "GT"; así como para especificar los bits de uso, ".N" de narrow o 16-bit, y la precisión de los datos, ".32".<br>
Ejemplo:<br>

```assembly
bgt case_saturate @Branch a case_saturate si la instrucción anterior da true a la condición mayor que.
```

<h3><b>2. ¿Para qué se utiliza el sufijo ‘s’? Dé un ejemplo.</b><br></h3>
El sufijo s es opcional y se utiliza para actualizar las banderas del registro de estado APSR: N, Z, C, V, Q, GE. Estas banderas son analizadas en la ejecución condicional de instrucciones, indicar saturación, entre otros casos.
Ejemplo: <br>

```assembly
movs r2,r1 @Mueve los datos de R1 al registro destino R2 y a su vez actualiza las banderas APSR.
```

<h3><b>3. ¿Qué utilidad tiene la implementación de instrucciones de aritmética saturada? Dé un ejemplo con operaciones con datos de 8 bits.</b><br></h3>
Las instrucciones de aritmética saturada son aquellas que evitan problemas de desbordamiento y la consecuente distorsión de operaciones al limitar un valor máximo y mínimo del dato. En este tipo de escenarios, estas instrucciones dan lugar a la activación de la bandera Q.<br>
Ejemplo:<br>En una operación con datos de 8 bits no signados, si el resultado es mayor a 255 pues siempre retornará 255 debido a que es el valor máximo que se puede representar con la cantidad de bits disponible. Si el resultado llegara a ser negativo, pues la operación devolverá cero.<br>

```assembly
mov r1, #255 
mov r2, #3
uqadd8 r0, r1,r2 @R0 tendrá un valor de 255
```

<h3><b>4. Describa brevemente la interfaz entre assembler y C ¿Cómo se reciben los argumentos de las funciones? ¿Cómo se devuelve el resultado? ¿Qué registros deben guardarse en la pila antes de ser modificados?</b><br></h3>
Para poder implementar funciones assembler en C, es necesario definir los prototipos assembly en un fichero .h y codificarlas en el fichero .S en donde se define la variable global que será exportada a C.<br>
Para devolver un resultado es necesario cargar el valor en R0. Sin embargo, si la función requiere de parámetros se pueden utilizar R0, R1, R2, R3.<br>
En el caso de utilizar más registros en la función (a partir de R4) es necesario guardarlos en la pila mediante un push y liberarlos con una instrucción pop.  

<h3><b>5. ¿Qué es una instrucción SIMD? ¿En qué se aplican y que ventajas reporta su uso? Dé un ejemplo.</b><br></h3>

Una instrucción SIMD (Single Instruction Multiple Data), tal como indica su nombre, constituye una sola instrucción que procesa de manera paralela múltiples datos en una sola operación.<br>
Este tipo de instrucciones es utilizado en aplicaciones que trabajen con una cantidad considerable de datos, usualmente en el campo multimedia, como el procesamiento de señales de audio o edición de imágenes.
De manera general la implementación de instrucciones SIMD da lugar a que el rendimiento del sistema pueda mejorar ya que la velocidad de procesamiento es mayor.
