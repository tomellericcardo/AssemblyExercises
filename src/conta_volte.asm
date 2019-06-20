
	.orig	x3000


	LEA	R0, stg		; R0 punta alla stringa di test
	LD	R1, car		; R1 contiene il carattere di test
	JSR	CONTA_VOLTE	; sottoprogramma conteggio occorrenze
	TRAP	x25		; arresto il processore

stg	.stringz	"Buon Sabato 7 febbraio 2015"	; stringa di test
car	.stringz	"b"				; carattere di test
	

CONTA_VOLTE

	ST	R2, st_r2	; salvo R2
	ST	R3, st_r3	; salvo R3
	ST	R4, st_r4	; salvo R4
	ST	R5, st_r5	; salvo R5

	NOT	R1, R1		; nego R1
	ADD	R1, R1, #1	; R1 = -R1

	AND 	R2, R2, #0	; R2 conta le occorrenze maiuscole
	AND 	R3, R3, #0	; R3 conta le occorrenze minuscole
	LD	R5, diff	; carico x20 in R5

loop	LDR	R4, R0, #0	; R4 contiene il carattere corrente
	BRZ	fine		; fine della stringa
	ADD	R4, R4, R1	; R4 = R4 - R1
	BRZ	occ_mi		; se R4 - R1 = 0, occorrenza minuscola
	ADD	R4, R4, R5	; R4 = R4 - R1 + x20
	BRZ	occ_ma		; se R4 - R1 + x20 = 0, occorrenza maiuscola
next	ADD	R0, R0, #1	; incremento puntatore alla stringa
	BRNZP	loop		; ciclo

occ_ma	ADD	R2, R2, #1	; incremento contatore maiuscole
	BRNZP	next		; continuo il ciclo

occ_mi	ADD	R3, R3, #1	; incremento contatore minuscole
	BRNZP	next		; continuo il ciclo

fine	ADD	R0, R2, #0	; copio R2 in R0
	ADD	R1, R3, #0	; copio R3 in R1
	LD	R2, st_r2	; ripristino R2
	LD	R3, st_r3	; ripristino R3
	LD	R4, st_r4	; ripristino R4
	LD	R5, st_r5	; ripristino R5
	RET			; ritorno al programma chiamante


st_r2	.blkw	1	; zona salvataggio R2
st_r3	.blkw	1	; zona salvataggio R3
st_r4	.blkw	1	; zona salvataggio R4
st_r5	.blkw	1	; zona salvataggio R5


diff	.fill	x20	; differenza maiuscole e minuscole


	.end
