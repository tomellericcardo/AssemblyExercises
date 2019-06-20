
	.orig	x3000


	LEA	R0, seq
	LD	R1, val
	JSR	CONTA_MIN_UGU_MAG
	TRAP	x25

seq	.fill	#112
	.fill	#-27
	.fill	#-12
	.fill	#-20
	.fill	#-12
	.fill	#-15
	.fill	#0
val	.fill	#-12


CONTA_MIN_UGU_MAG

	ST	R3, st_r3	; salvo il contenuto di R3
	ST	R4, st_r4	; salvo il contenuto di R4
	ST	R5, st_r5	; salvo il contenuto di R5
	ST	R6, st_r6	; salvo il contenuto di R6

	NOT	R1, R1		; nego R1
	ADD	R1, R1, #1	; R1 = -R1

	AND	R3, R3, #0	; R3 conta i numeri minori
	AND	R4, R4, #0	; R4 conta i numeri uguali
	AND	R5, R5, #0	; R5 conta i numeri maggiori

loop	LDR	R6, R0, #0	; R6 contiene il numero corrente
	BRZ	fine		; fine della sequenza
	ADD	R6, R6, R1	; R6 = R6 - R1
	BRN	min		; R6 - R1 < 0, corrente minore
	BRZ	ugu		; R6 - R1 = 0, corrente uguale
	BRP	mag		; R6 - R1 > 0, corrente maggiore
next	ADD	R0, R0, #1	; incremento il puntatore alla sequenza
	BRNZP	loop		; ciclo

min	ADD	R3, R3, #1	; incremento il contatore dei minori
	BRNZP	next		; continuo il ciclo

ugu	ADD	R4, R4, #1	; incremento il contatore degli uguali
	BRNZP	next		; continuo il ciclo

mag	ADD	R5, R5, #1	; incremento il contatore dei maggiori
	BRNZP	next		; continuo il ciclo

fine	ADD	R0, R3, #0	; scrivo R3 in R0
	ADD	R1, R4, #0	; scrivo R4 in R1
	ADD	R2, R5, #0	; scrivo R5 in R2

	LD	R3, st_r3	; ripristino il contenuto di R3
	LD	R4, st_r4	; ripristino il contenuto di R4
	LD	R5, st_r5	; ripristino il contenuto di R5
	LD	R6, st_r6	; ripristino il contenuto di R6

	RET


st_r3	.blkw	1	; zona salvataggio R3
st_r4	.blkw	1	; zona salvataggio R4
st_r5	.blkw	1	; zona salvataggio R5
st_r6	.blkw	1	; zona salvataggio R6


	.end
