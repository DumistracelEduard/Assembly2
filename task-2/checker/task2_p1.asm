section .text
	global cmmmc
;; int cmmmc(int a, int b)
;
;; calculate least common multiple fow 2 numbers, a and b
cmmmc:
	push eax
	pop ecx
	imul ecx, edx ; cmmmc = (a * b)/ cmmdc
cmmdc:
	cmp eax, edx
	jg a_greater_b
	jl b_greater_a
	jmp finish	 ; a = 0
a_greater_b:
	sub eax, edx ; a =-b
	jmp cmmdc
b_greater_a:
	sub edx, eax ; b =-a
	jmp cmmdc
finish:
	push eax
	pop ebx
	push ecx
	pop eax
	xor edx, edx
	div ebx
	ret
