
	.orig	x3000


	LEA	R0, seq		; R0 punta alla sequenza di test
	LEA	R1, end		; R1 punta all'ultima cella della sequenza
	JSR	CONTA_N_Z_P	; richiamo il sottoprogramma
	TRAP	x25		; arresto il processore

seq	.fill	#-56
	.fill	#15
	.fill	#-9
	.fill	#0
	.fill	#27
end	.fill	#12
	

CONTA_N_Z_P

	ST	R3, save_r3	; salvo il contenuto di R3
	ST	R4, save_r4	; salvo il contenuto di R4
	ST	R5, save_r5	; salvo il contenuto di R5

	AND	R3, R3, #0	; R3 conteggia i numeri negativi
	AND	R4, R4, #0	; R4 conteggia i numeri nulli
	AND	R5, R5, #0	; R5 conteggia i numeri positivi

	NOT	R1, R1		; R1 = -(indirizzo ultima cella + 1)

loop	LDR	R2, R0, #0	; R2 contiene il numero corrente
	BRN	neg		; numero corrente negativo
	BRZ	nul		; numero corrente nullo
	BRP	pos		; numero corrente positivo

next	ADD	R0, R0, #1	; incremento il puntatore alla sequenza
	ADD	R2, R0, R1	; R2 = R0 - (indirizzo ultima cella + 1)
	BRZ	fine		; fine della sequenza
	BRNP	loop		; ciclo

neg	ADD	R3, R3, #1	; incremento il contatore dei negativi
	BRNZP	next		; continuo con il ciclo

nul	ADD	R4, R4, #1	; incremento il contatore dei nulli
	BRNZP	next		; continuo con il ciclo

pos	ADD	R5, R5, #1	; incremento il contatore dei positivi
	BRNZP	next		; continuo con il ciclo

fine	ADD	R0, R3, #0	; scrivo R3 in R0
	ADD	R1, R4, #0	; scrivo R4 in R1
	ADD	R2, R5, #0	; scrivo R5 in R2
	LD	R3, save_r3	; ripristino il contenuto di R3
	LD	R4, save_r4	; ripristino il contenuto di R4
	LD	R5, save_r5	; ripristino il contenuto di R5
	RET			; ritorno al programma chiamante


save_r3	.blkw	1
save_r4	.blkw	1
save_r5	.blkw	1


	.end
