

	.orig	x3000


	LEA	R0, test	; R0 contiene l'indirizzo della stringa
	JSR	MAIUSC		; chiamata a sottoprogramma
	TRAP	x25		; terminazione del programma

test	.stringz	"La sigla USA significa United States of America"	


MAIUSC	ST	R1, st_R1	; salvo il contenuto di R1
	ST	R2, st_R2	; salvo il contenuto di R2
	ST	R3, st_R3	; salvo il contenuto di R3
	ST	R4, st_R4	; salvo il contenuto di R4

	AND	R1, R1, #0	; R1 è il contatore della minuscole

loop	LDR	R2, R0, #0	; R2 contiene il carattere corrente
	BRZ	fine		; fine della stringa
	LD	R3, m122		; R3 contiene il valore -122
	ADD	R4, R2, R3	; R4 = carattere corrente - 122
	BRP	next		; carattere corrente non minuscolo
	LD	R3, m97		; R3 contiene il valore -97
	ADD	R4, R2, R3	; R4 = carattere corrente - 97
	BRZP	maiu		; carattere corrente minuscolo
next	ADD	R0, R0, #1	; incremento il puntatore alla stringa
	BRNZP	loop		; ciclo

maiu	ADD	R1, R1, #1	; incremento il contatore delle minuscole
	LD	R3, m32		; R3 contiene il valore -32
	ADD	R2, R2, R3	; R2 = carattere corrente - 32
	STR	R2, R0, #0	; scrivo il carattere maiuscolo
	BRNZP	next		; continuo con il ciclo

fine	ADD	R0, R1, #0	; scrivo R1 in R0
	LD	R1, st_R1	; ripristino il contenuto di R1
	LD	R2, st_R2	; ripristino il contenuto di R2
	LD	R3, st_R3	; ripristino il contenuto di R3
	LD	R4, st_R4	; ripristino il contenuto di R4
	RET			; ritorno al programma chiamante

st_R1	.blkw	1
st_R2	.blkw	1
st_R3	.blkw	1
st_R4	.blkw	1

m122	.fill	#-122
m97	.fill	#-97
m32	.fill	#-32


	.end
