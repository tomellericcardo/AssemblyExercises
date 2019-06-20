

	.orig	x3000


	LEA	R0, test	; R0 contiene l'indirizzo della stringa
	JSR	MINUSC		; chiamata a sottoprogramma
	TRAP	x25		; terminazione del programma

test	.stringz	"La sigla USA significa United States of America"	


MINUSC	ST	R1, st_R1	; salvo il contenuto di R1
	ST	R2, st_R2	; salvo il contenuto di R2
	ST	R3, st_R3	; salvo il contenuto di R3
	ST	R4, st_R4	; salvo il contenuto di R4

	AND	R1, R1, #0	; R1 è il contatore della maiuscole

loop	LDR	R2, R0, #0	; R2 contiene il carattere corrente
	BRZ	fine		; fine della stringa
	LD	R3, m90		; R3 contiene il valore -90
	ADD	R4, R2, R3	; R4 = carattere corrente - 90
	BRP	next		; carattere corrente non maiuscolo
	LD	R3, m65		; R3 contiene il valore -65
	ADD	R4, R2, R3	; R4 = carattere corrente - 65
	BRZP	maiu		; carattere corrente maiuscolo
next	ADD	R0, R0, #1	; incremento il puntatore alla stringa
	BRNZP	loop		; ciclo

maiu	ADD	R1, R1, #1	; incremento il contatore delle maiuscole
	LD	R3, p32		; R3 contiene il valore +32
	ADD	R2, R2, R3	; R2 = carattere corrente + 32
	STR	R2, R0, #0	; scrivo il carattere minuscolo
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

m90	.fill	#-90
m65	.fill	#-65
p32	.fill	#32


	.end
