
	.orig	x3000


	LEA	R0, s1		; R0 punta alla prima stringa di test
	LEA	R1, c1		; R1 punta al primo output di test
	JSR	CONTACIFRE	; chiamo il sottoprogramma
	LEA	R0, s2		; R0 punta alla seconda stringa di test
	LEA	R1, c2		; R1 punta al secondo output di test
	JSR	CONTACIFRE	; chiamo il sottoprogramma
	LEA	R0, s3		; R0 punta alla terza stringa di test
	LEA	R1, c3		; R1 punta al terzo output di test
	JSR	CONTACIFRE	; chiamo il sottoprogramma
	TRAP	x25		; arresto il processore

s1	.stringz	"Oggi è il 13 settembre 2016, che si può scrivere anche 13/09/2016"
c1	.blkw		10
s2	.stringz	"La festa della mamma cade sempre in una domenica di maggio"
c2	.blkw		10
s3	.stringz	"Ecco una strana sequenza di cifre: 0 11 222 33 4 55 666 7777 88888 999999"
c3	.blkw		10


CONTACIFRE

	ST	R2, save_r2	; salvo il contenuto di R2
	ST	R3, save_r3	; salvo il contenuto di R3
	ST	R4, save_r4	; salvo il contenuto di R4

loop	LDR	R2, R0, #0	; R2 contiene il carattere corrente
	BRZ	fine		; fine della stringa
	LD	R3, meno9	; R3 contiene il negativo del codice ASCII di 9
	ADD	R3, R3, R2	; R3 = carattere corrente - ASCII(9)
	BRP	next		; carattere corrente non numerico
	LD	R3, meno0	; R3 contiene il negativo del codice ASCII di 0
	ADD	R3, R3, R2	; R3 = carattere corrente - ASCII(0)
	BRN	next		; carattere corrente non numerico
	ADD	R3, R3, R1	; R3 contiene l'indirizzo del contatore del valore corrente
	LDR	R4, R3, #0	; R4 contiene il contatore del valore corrente
	ADD	R4, R4, #1	; incremento il contatore
	STR	R4, R3, #0	; scrivo il contatore aggiornato
next	ADD	R0, R0, #1	; incremento il puntatore alla stringa
	BRNZP	loop		; ciclo

fine	ST	R2, save_r2	; ripristino il valore di R2
	ST	R3, save_r3	; ripristino il valore di R3
	ST	R4, save_r4	; ripristino il valore di R4
	RET			; ritorno al programma chiamante


meno0	.fill	#-48
meno9	.fill	#-57

save_r2	.blkw	1
save_r3	.blkw	1
save_r4	.blkw	1


	.end
