
	.orig	x3000


	LEA	R0, test_S1
	LEA	R1, test_C
	JSR	CONTAVOC_MAIU
	LEA	R0, test_S2
	JSR	CONTAVOC_MAIU
	LEA	R0, test_S3
	JSR	CONTAVOC_MAIU
	TRAP	x22

test_C	.blkw		5
test_S1	.stringz	"BUON LAVORO"
test_S2	.stringz	"La festa della mamma cade sempre in una domenica di maggio"
test_S3	.stringz	"ATTENZIONE! Le cinque vocali sono AEIOU"


CONTAVOC_MAIU

	ST	R2, st_R2	; salvo il contenuto di R2
	ST	R3, st_R3	; salvo il contenuto di R3
	ST	R4, st_R4	; salvo il contenuto di R4

	AND	R2, R2, #0	; azzero R2
	STR	R2, R1, #0	; azzero il contatore di A
	STR	R2, R1, #1	; azzero il contatore di E
	STR	R2, R1, #2	; azzero il contatore di I
	STR	R2, R1, #3	; azzero il contatore di O
	STR	R2, R1, #4	; azzero il contatore di U

loop	LDR	R2, R0, #0	; R2 contiene il carattere corrente
	BRZ	fine		; fine della stringa
	LD	R3, val_A	; R3 contiene il valore opposto di A
	ADD	R4, R2, R3	; R4 = carattere corrente - valore di A
	BRZ	voc_A		; carattere corrente A
	LD	R3, val_E	; R3 contiene il valore opposto di E
	ADD	R4, R2, R3	; R4 = carattere corrente - valore di E
	BRZ	voc_E		; carattere corrente E
	LD	R3, val_I	; R3 contiene il valore opposto di I
	ADD	R4, R2, R3	; R4 = carattere corrente - valore di I
	BRZ	voc_I		; carattere corrente I
	LD	R3, val_O	; R3 contiene il valore opposto di O
	ADD	R4, R2, R3	; R4 = carattere corrente - valore di O
	BRZ	voc_O		; carattere corrente O
	LD	R3, val_U	; R3 contiene il valore opposto di U
	ADD	R4, R2, R3	; R4 = carattere corrente - valore di U
	BRZ	voc_U		; carattere corrente U
next	ADD	R0, R0, #1	; incremento il puntatore alla stringa
	BRNZP	loop		; ciclo

voc_A	LDR	R2, R1, #0	; R2 contiene il contatore per A
	ADD	R2, R2, #1	; incremento il contatore
	STR	R2, R1, #0	; aggiorno il contatore
	BRNZP	next		; proseguo con il ciclo

voc_E	LDR	R2, R1, #1	; R2 contiene il contatore per E
	ADD	R2, R2, #1	; incremento il contatore
	STR	R2, R1, #1	; aggiorno il contatore
	BRNZP	next		; proseguo con il ciclo

voc_I	LDR	R2, R1, #2	; R2 contiene il contatore per I
	ADD	R2, R2, #1	; incremento il contatore
	STR	R2, R1, #2	; aggiorno il contatore
	BRNZP	next		; proseguo con il ciclo

voc_O	LDR	R2, R1, #3	; R2 contiene il contatore per O
	ADD	R2, R2, #1	; incremento il contatore
	STR	R2, R1, #3	; aggiorno il contatore
	BRNZP	next		; proseguo con il ciclo

voc_U	LDR	R2, R1, #4	; R2 contiene il contatore per U
	ADD	R2, R2, #1	; incremento il contatore
	STR	R2, R1, #4	; aggiorno il contatore
	BRNZP	next		; proseguo con il ciclo

fine	LD	R2, st_R2	; ripristino il contenuto di R2
	LD	R3, st_R3	; ripristino il contenuto di R3
	LD	R4, st_R4	; ripristino il contenuto di R4
	RET			; ritorno al programma chiamante

st_R2	.blkw	1
st_R3	.blkw	1
st_R4	.blkw	1

val_A	.fill	-65
val_E	.fill	-69
val_I	.fill	-73
val_O	.fill	-79
val_U	.fill	-85


	.end
