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
.global asm_filtroVentana10
.global asm_pack32to16
.global asm_max
.global asm_downsampleM
.global asm_invertir

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
    push {r4-r5}
    ldr r4, [r0]			@ Carga en r4 el primer componente de r0
    .asm_pE32_for:			@ Inicio el loop for
        mul r5, r4, r3		@ Multiplica r4*r3 y lo carga en r5.
        str r5, [r1], 4		@ Guarda en r1+=4 el valor de r5.
        ldr r4,[r0, 4]!     @ Carga en r4 el componente de r0+=4
        subs r2, 1 			@ resto para saber que me da cero y finalizo el loop.
        bne .asm_pE32_for   @si el resultado de la resta no es cero Z=0
        pop {r4-r5}
        bx lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   productoEscalar16 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar);
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
    push {r4-r5}
    ldrsh r4, [r0]			@ Carga en r4 el primer componente de r0
    .asm_pE16_for:			@ Inicio el loop for
        mul r5, r4, r3		@ Multiplica r4*r3 y lo carga en r5.
        str r5, [r1], 2		@ Guarda en r1+=4 el valor de r5.
        ldrsh r4,[r0, 2]!     @ Carga en r4 el componente de r0+=4
        subs r2, 1 			@ resto para saber que me da cero y finalizo el loop.
        bne .asm_pE16_for   @si el resultado de la resta no es cero Z=0
        pop {r4-r5}
        bx lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void productoEscalar12 (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar)
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
    push {r4-r6}
    ldrsh r4, [r0,#0]			@ Carga en r4 el primer componente de r0
    ldr r6, =4095
    .asm_pE12_for:			@ Inicio el loop for
        mul r5, r4, r3		@ Multiplica r4*r3 y lo carga en r5.
        cmp r5, r6    @Error: invalid constant (fff) after fixup
        bgt case_saturate
        str r5, [r1], 2		@ Guarda en r1+=4 el valor de r5.
    	b end
   	end:
   		ldrsh r4,[r0, 2]!     @ Carga en r4 el componente de r0+=4
        subs r2, 1 			@ resto para saber que me da cero y finalizo el loop.
        bne .asm_pE12_for   @si el resultado de la resta no es cero Z=0
        pop {r4-r6}
        bx lr
   	case_saturate:
    	ldrsh r5, =4095
    	str r5, [r1], 2
    	b end
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void filtroVentana10(uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitudVectorIn);
@
@ Parametros recibidos:
@   r0: vectorIn, puntero al vector de muestras donde se aplicará el filtro.
@   r1: vectorOut, puntero al vector de salida que contiene los promedios. Se han considerado 3 elementos por ventana.
@   r2: longitud del vector.
@
@	r3 N, r4 sum, r5 temp, r6 aux idx, r7 i, r8 j ,r9 cond j
@ Valor de retorno:
@   void
@
.thumb_func
    asm_filtroVentana10:
    push {r4-r10}
    ldr r3,=3				@ Cargo el número de elementos a promediar en r3.

    .asm_v10i_for:			@ Inicio el loop for para recorrer el vector de muestras.
    	ldr r4, =0			@ Cargo 0 en r4 quien será el registro que almacenará la suma parcial.
    	mov r8, r7			@ Inicio j con el valor de i
    	.asm_v10j_for:		@ Inicio el loop for para recorrer elementos que serán promediados.
    		adds r9, r3, r7	@ N_FLTR+i
    		cmp r8, r9
    		blt end_for_j	@ j<(N_FLTR+i)
    		udiv r6, r8, r2		@ Divide j para longitud.
    		mul r10, r2, r8		@ Reconstruyendo msub r6, r6, r2, r8.
    		subs r6, r10, r6
        	ldrsh r6, [r0,r6]	 @ Carga en r6 el componente idx = módulo de r0.
        	add r4, r4, r6		@ sum+=aux
    		add r8, r8, #1	@ j++
    		b .asm_v10j_for
        end_for_j:
        udiv r5, r4, r3    	@ promedio
        str r5, [r1], 2		@ Guarda en r1+=2 el valor de r5.
        adds r7, r7, #1	    @ i++
    	cmp r7, r2
        blt end_for_i		@ i<longitud
        b .asm_v10i_for
    end_for_i:
        pop {r4-r10}
        bx lr
