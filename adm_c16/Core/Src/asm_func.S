.syntax unified
.thumb
.text

@ Simbolos exportados
.global asm_svc
.global asm_sum
.global asm_zeros
.global asm_productoEscalar32
.global asm_productoEscalar16
.global asm_productoEscalar12

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_svc (void)
@
.thumb_func
    asm_svc:
        svc 0
        bx lr


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   uint32_t asmSum (uint32_t firstOperand, uint32_t secondOperand)
@
@ Parametros recibidos:
@   r0: firstOperand
@   r1: secondOperand
@
@ Valor de retorno:
@   r0: resultado de la suma de firstOperand y secondOperand
@
.thumb_func
    asm_sum:
        add r0, r1  @ r0 = r0 + r1
        bx lr       @ vuelve adonde fue llamada (especificamente, si "pc"
                    @ es la direccion, en el codigo del programa, de la
                    @ instruccion "bl asm_sum" usada para saltar a
                    @ esta funcion, entonces "lr" contiene ese "pc" + 4).
                    @ el valor de retorno debe quedar en el registro r0.
                    @ En este caso, r0 es el resultado de r0 + r1.

        @ Otras alternativas para el retorno
        @ mov pc,lr
        @ bx lr
        @ push {lr} ... pop {pc}

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_zeros (uint32_t * vector, uint32_t longitud);
@
@ Parametros recibidos:
@   r0: puntero al vector
@   r1: longitud del vector
@
@ Valor de retorno:
@   void
@
.thumb_func
    asm_zeros:
    	mov r2, 0
    .asm_zeros_for:
        str r2, [r0], 4  @ [r0] = *r0  todo eso es igual a  *vector=r2; vector+=4;
        subs r1, 1 @resto para saber que me da cero y finalizo el loop. con s para actualizar.
        bne .asm_zeros_for        @si el resultado de la resta no es cero Z=0
        bx lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_productoEscalar32 (uint32_t * vectorIn, uint32_t * vectorOut, uint32_t longitud, uint32_t escalar);
@
@ Parametros recibidos:
@   r0: vectorIn, puntero al vector que será multiplicado.
@   r1: vectorOut, puntero al vector que contiene la respuesta.
@   r2: longitud del vector
@   r3: escalar
@
@ Valor de retorno:
@   void
@
.thumb_func
    asm_productoEscalar32:
    ldr r4, [r0]			@ Carga en r4 el primer componente de r0
    .asm_pE32_for:			@ Inicio el loop for
        mul r5, r4, r3		@ Multiplica r4*r3 y lo carga en r5.
        str r5, [r1], 4		@ Guarda en r1+=4 el valor de r5.
        ldr r4,[r0, 4]!     @ Carga en r4 el componente de r0+=4
        subs r2, 1 			@ resto para saber que me da cero y finalizo el loop.
        bne .asm_pE32_for   @si el resultado de la resta no es cero Z=0
        bx lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_productoEscalar32 (uint32_t * vectorIn, uint32_t * vectorOut, uint32_t longitud, uint32_t escalar);
@
@ Parametros recibidos:
@   r0: vectorIn, puntero al vector que será multiplicado.
@   r1: vectorOut, puntero al vector que contiene la respuesta.
@   r2: longitud del vector
@   r3: escalar
@
@ Valor de retorno:
@   void
@
.thumb_func
    asm_productoEscalar16:
    ldr r4, [r0]			@ Carga en r4 el primer componente de r0
    .asm_pE16_for:			@ Inicio el loop for
        mul r5, r4, r3		@ Multiplica r4*r3 y lo carga en r5.
        str r5, [r1], 2		@ Guarda en r1+=4 el valor de r5.
        ldr r4,[r0, 2]!     @ Carga en r4 el componente de r0+=4
        subs r2, 1 			@ resto para saber que me da cero y finalizo el loop.
        bne .asm_pE16_for   @si el resultado de la resta no es cero Z=0
        bx lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_productoEscalar32 (uint32_t * vectorIn, uint32_t * vectorOut, uint32_t longitud, uint32_t escalar);
@
@ Parametros recibidos:
@   r0: vectorIn, puntero al vector que será multiplicado.
@   r1: vectorOut, puntero al vector que contiene la respuesta.
@   r2: longitud del vector
@   r3: escalar
@
@ Valor de retorno:
@   void
@
.thumb_func
    asm_productoEscalar12:
    ldr r4, [r0]			@ Carga en r4 el primer componente de r0
    .asm_pE12_for:			@ Inicio el loop for
        mul r5, r4, r3		@ Multiplica r4*r3 y lo carga en r5.
        str r5, [r1], 2		@ Guarda en r1+=4 el valor de r5.
        ldr r4,[r0, 2]!     @ Carga en r4 el componente de r0+=4
        subs r2, 1 			@ resto para saber que me da cero y finalizo el loop.
        bne .asm_pE12_for   @si el resultado de la resta no es cero Z=0
        bx lr
