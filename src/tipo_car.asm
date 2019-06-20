
	.orig	x3000


	LD	R0, t1		; R0 contiene il primo valore di test
	JSR	TIPO_CAR	; chiamata a sottoprogramma
	LD	R0, t2		; R0 contiene il secondo valore di test
	JSR	TIPO_CAR	; chiamata a sottoprogramma
	LD	R0, t3		; R0 contiene il terzo valore di test
	JSR	TIPO_CAR	; chiamata a sottoprogramma
	TRAP	x25		; arresto il processore

t1	.fill	#109	; carattere "m"
t2	.fill	#36	; carattere "$"
t3	.fill	#55	; carattere "7"


TIPO_CAR

	NOT	R0, R0		; nego R0
	ADD	R0, R0, #1	; R0 = - valore corrente

	LD	R1, val32	; R1 contiene il valore #32
	ADD	R1, R1, R0	; R1 = #32 - valore corrente
	BRP	ctrl		; carattere di controllo

	LD	R1, val48	; R1 contiene il valore #48
	ADD	R1, R1, R0	; R1 = #48 - valore corrente
	BRP	altro		; altro carattere
	LD	R1, val57	; R1 contiene il valore #57
	ADD	R1, R1, R0	; R1 = #57 - valore corrente
	BRP	cifra		; carattere cifra

	LD	R1, val65	; R1 contiene il valore #65
	ADD	R1, R1, R0	; R1 = #65 - valore corrente
	BRP	altro		; altro carattere
	LD	R1, val90	; R1 contiene il valore #90
	ADD	R1, R1, R0	; R1 = #90 - valore corrente
	BRP	maiu		; lettera maiuscola

	LD	R1, val97	; R1 contiene il valore #97
	ADD	R1, R1, R0	; R1 = #97 - valore corrente
	BRP	altro		; altro carattere
	LD	R1, val122	; R1 contiene il valore #122
	ADD	R1, R1, R0	; R1 = #122 - valore corrente
	BRP	minu		; lettera minuscola

	BRNZ	altro		; altro carattere

ctrl	AND	R1, R1, #0	; azzero R1
	ADD	R1, R1, #1	; scrivo 1 in R1
	RET			; ritorno al programma chiamante

cifra	AND	R1, R1, #0	; azzero R1
	ADD	R1, R1, #2	; scrivo 2 in R1
	RET			; ritorno al programma chiamante

maiu	AND	R1, R1, #0	; azzero R1
	ADD	R1, R1, #3	; scrivo 3 in R1
	RET			; ritorno al programma chiamante

minu	AND	R1, R1, #0	; azzero R1
	ADD	R1, R1, #4	; scrivo 4 in R1
	RET			; ritorno al programma chiamante

altro	AND	R1, R1, #0	; azzero R1
	ADD	R1, R1, #5	; scrivo 5 in R1
	RET			; ritorno al programma chiamante

val32	.fill	#32
val48	.fill	#48
val57	.fill	#57
val65	.fill	#65
val90	.fill	#90
val97	.fill	#97
val122	.fill	#122


	.end
