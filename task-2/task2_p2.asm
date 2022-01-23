section .text
	global par
;; int par(int str_length, char* str)
;
; check for balanced brackets in an expression
par:
	xor ecx, ecx
	xor ebx, ebx
loop_char:
	cmp byte[eax + ecx], '('
	je open
	cmp byte[eax + ecx], ')'
	je close
back:
	inc ecx
	cmp ecx, edx
	jne loop_char
	jmp compare
open:
	inc ebx ; in caz ca e ( inc
	jmp back
close:
	dec ebx	; in caz ca e ) dec
	jmp back
compare:
	xor eax, eax
	cmp ebx, 0
	jne final
	inc eax
final:
	ret
