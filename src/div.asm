
	.orig	x3000


	LD	R0, n1		; R0 contiene il primo numeratore di test
	LD	R1, d1		; R1 contiene il primo denominatore di test
	JSR	DIV		; chiamo la subroutine
	LD	R0, n1		; R0 contiene il secondo numeratore di test
	LD	R1, d2		; R1 contiene il secondo denominatore di test
	JSR	DIV		; chiamo la subroutine
	LD	R0, n1		; R0 contiene il terzo numeratore di test
	LD	R1, d3		; R1 contiene il terzo denominatore di test
	JSR	DIV		; chiamo la subroutine
	LD	R0, n1		; R0 contiene il quarto numeratore di test
	LD	R1, d4		; R1 contiene il quarto denominatore di test
	JSR	DIV		; chiamo la subroutine
	TRAP	x25		; arresto il processore

n1	.fill	#100
d1	.fill	#5
d2	.fill	#6
d3	.fill	#1
d4	.fill	#110


DIV

	ST	R2, save_r2	; salvo il contenuto dI R2
	ST	R3, save_r3	; salvo il contenuto dI R3
	ST	R4, save_r4	; salvo il contenuto dI R4

	AND	R2, R2, #0	; azzero R2
	AND	R3, R3, #0	; R3 contiene il quoziente

	NOT	R0, R0		; nego R0
	ADD	R0, R0, #1	; R0 = - numeratore

loop	ADD	R2, R2, R1	; sommo il denominatore a R2
	ADD	R4, R2, R0	; R4 = ((R3 + 1) * denominatore) - numeratore
	BRP	fine		; fine della divisione
	ADD	R3, R3, #1	; incremento il quoziente
	BRNZP	loop		; ciclo

fine	ADD	R0, R3, #0	; scrivo R3 in R0
	LD	R2, save_r2	; ripristino il contenuto di R2
	LD	R3, save_r3	; ripristino il contenuto di R3
	LD	R4, save_r4	; ripristino il contenuto di R4
	RET			; ritorno al programma chiamante

save_r2	.blkw	1
save_r3	.blkw	1
save_r4	.blkw	1


	.end
