
	.orig	x3000


	LEA	R0, str1	; R0 punta alla stringa di test
	LD	R1, car1	; R1 contiene il primo carattere di test
	LD	R2, car2	; R2 contiene il secondo carattere di test
	JSR	TROVA_COPPIA	; chiamata alla subroutine
	TRAP	x25		; arresto il processore

str1	.stringz	"ciao mamma"
str2	.stringz	"ciao papà"
car1	.stringz	"m"
car2	.stringz	"a"


TROVA_COPPIA

	ST	R3, save_r3	; salvo il contenuto di R3
	ST	R4, save_r4	; salvo il contenuto di R4

	AND	R3, R3, #0	; azzero R3
	ADD	R3, R3, #1	; R3 contiene l'indice dell'eventuale occorrenza

loop	LDR	R4, R0, #0	; R4 contiene il carattere corrente
	BRZ	fine		; fine della stringa
	NOT	R4, R4		; nego R4
	ADD	R4, R4, #1	; R4 = - carattere corrente
	ADD	R4, R4, R1	; R4 = primo carattere - carattere corrente
	BRZ	occpr		; occorrenza del primo carattere
next	ADD	R0, R0, #1	; incremento il puntatore alla stringa
	ADD	R3, R3, #1	; incremento l'indice dell'eventuale occorrenza
	BRNZP	loop		; ciclo

occpr	LDR	R4, R0, #1	; R4 contiene il carattere successivo
	BRZ	fine		; fine della stringa
	NOT	R4, R4		; nego R4
	ADD	R4, R4, #1	; R4 = - carattere successivo
	ADD	R4, R4, R2	; R4 = secondo carattere - carattere successivo
	BRZ	occse		; occorrenza del secondo carattere
	BRNP	next		; continuo il ciclo

occse	ADD	R0, R3, #0	; scrivo R3 in R0
	BRNZP	load_r		; ricarico il contenuto dei registri

fine	AND	R0, R0, #0	; azzero R0
	BRNZP	load_r		; ricarico il contenuto dei registri

load_r	LD	R3, save_r3	; ripristino il valore di R3
	LD	R4, save_r4	; ripristino il valore di R4
	RET			; ritorno al programma chiamante


save_r3	.blkw	1
save_r4	.blkw	1


	.end
