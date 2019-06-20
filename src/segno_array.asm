
	.orig	x3000


	LEA	R0, A		; R1 punta la sequenza di input di test
	LEA	R1, R		; R2 punta la sequenza di output di test
	JSR	SEGNO_ARRAY	; chiamata al sottoprogramma
	TRAP	x25		; arresto il processore

A	.fill	#1
	.fill	#-32768
	.fill	#-5
	.fill	#12
	.fill	#0
R	.blkw	4


SEGNO_ARRAY

	ST	R2, save_r2	; salva il contenuto di R2
	ST	R3, save_r3	; salva il contenuto di R3

loop	LDR	R2, R0, #0	; R2 contiene il valore corrente
	BRZ	fine		; fine della sequenza
	BRN	neg		; valore corrente negativo
	BRP	pos		; valore corrento positivo

next	ADD	R0, R0, #1	; incremento il puntatore alla sequenza di input
	ADD	R1, R1, #1	; incremento il puntatore alla sequenza di output
	BRNZP	loop		; ciclo

neg	ADD	R3, R2, #-1	; R3 = corrente - 1
	BRP	maxneg		; undeflow, quindi il corrente è massimo negativo
	LD	R3, men1	; scrivo -1 in R3
	STR	R3, R1, #0	; scrivo -1 nella cella di output corrente
	BRNZP	next		; continuo il ciclo

maxneg	AND	R3, R3,	#0	; scrivo 0 in R3
	STR	R3, R1, #0	; scrivo 0 nella cella di output corrente
	BRNZP	next		; continuo il ciclo

pos	LD	R3, piu1	; scrivo 1 in R3
	STR	R3, R1, #0	; scrivo 1 nella cella di output corrente
	BRNZP	next		; continuo il ciclo

fine	LD	R2, save_r2	; ripristina il contenuto di R2
	LD	R3, save_r3	; ripristina il contenuto di R3
	RET			; ritorna al programma chiamante


men1	.fill	#-1
piu1	.fill	#1

save_r2	.blkw	1
save_r3	.blkw	1


	.end
