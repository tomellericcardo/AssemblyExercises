
	.orig	x3000


	AND	R0, R0, #0
	ADD	R0, R0, #6
	JSR	SEQ2
	AND	R0, R0, #0
	ADD	R0, R0, #2
	JSR	SEQ2
	AND	R0, R0, #0
	ADD	R0, R0, #-4
	JSR	SEQ2
	TRAP	x25


SEQ2	ST	R1, st_r1	; salvo il contenuto di R1
	ST	R2, st_r2	; salvo il contenuto di R2
	ST	R3, st_r3	; salvo il contenuto di R3

	AND	R3, R3, #0	; azzero R3
	AND	R0, R0, R0	; controllo R0
	BRNZ	fine		; n <= 0
	ADD	R3, R3, #1	; scrivo 1 in R3
	ADD	R0, R0, #-2	; decremento R0 di 2
	BRNZ	fine		; n = 1 o n = 2

	LEA	R1, seq		; R1 punta alla sequenza
loop	LDR	R2, R1, #1	; R2 contiene S(n-1)
	ADD	R2, R2, R2	; R2 contiene 2 * S(n-1)
	ADD	R3, R2, #0	; R3 contiene 2 * S(n-1)
	LDR	R2, R1, #0	; R2 contiene S(n-2)
	BRN	ass		; S(n-1) negativo
cont	ADD	R2, R2, R2	; R2 contiene 2 * |S(n-2)|
	NOT	R2, R2		; nego R2
	ADD	R2, R2, #1	; R2 contiene - 2 * |S(n-2)|
	ADD	R3, R3, R2	; R3 contiene 2 * S(n-1) - 2 * |S(n-2)|
	STR	R3, R1, #2	; scrivo R3 all'n-esimo posto della sequenza
	ADD	R0, R0, #-1	; decremento R0 di 1
	BRZ	fine		; fine della sequenza
	ADD	R1, R1, #1	; incremento il puntatore di 1
	BRNZP	loop		; ciclo

ass	NOT	R2, R2		; nego R2
	ADD	R2, R2, #1	; R2 contiene |S(n-2)|
	BRNZP	cont		; continuo

fine	ADD	R0, R3, #0	; scrivo R3 in R0
	LD	R1, st_r1	; ripristino il contenuto di R1
	LD	R2, st_r2	; ripristino il contenuto di R2
	LD	R3, st_r3	; ripristino il contenuto di R3
	RET			; ritorno al programma chiamante

seq	.fill	#1
	.fill	#1
	.blkw	100

st_r1	.blkw	1
st_r2	.blkw	1
st_r3	.blkw	1


	.end
