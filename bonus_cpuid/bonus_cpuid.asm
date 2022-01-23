section .text
	global cpu_manufact_id
	global features
	global l2_cache_info

;; void cpu_manufact_id(char *id_string);
;
;  reads the manufacturer id string from cpuid and stores it in id_string
cpu_manufact_id:
	enter 	0, 0
	mov esi, [ebp + 8]
	push ebx
	push esi
	xor eax, eax
	cpuid
	;stochez id-ul in esi
	pop esi
	mov [esi], ebx
	mov [esi + 4], edx
	mov [esi + 8], ecx
	pop ebx
	leave
	ret

;; void features(char *vmx, char *rdrand, char *avx)
;
;  checks whether vmx, rdrand and avx are supported by the cpu
;  if a feature is supported, 1 is written in the corresponding variable
;  0 is written otherwise
features:
	enter 	0, 0
	mov eax, 1
	push esi
	mov esi, [ebp + 8]
	push ebx
	cpuid
	mov eax, ecx ;pt vmx
	mov edx, ecx ;pt rdrand
	shr ecx, 29	 ;pt avx
	and ecx, 1	 ;obtin avx
	shr eax, 5	 ;pt vmx poz 5
	and eax, 1	 ;obtin vmx
	shr edx, 30	 ;pt rdrand poz 30
	and edx, 1	 ;obtin rdrand
	mov [esi], eax
	mov esi, [ebp + 12]
	mov [esi], edx
	mov esi, [ebp + 16]
	mov [esi], ecx
	pop ebx
	pop esi
	leave
	ret

;; void l2_cache_info(int *line_size, int *cache_size)
;
;  reads from cpuid the cache line size, and total cache size for the current
;  cpu, and stores them in the corresponding parameters
l2_cache_info:
	enter 	0, 0
	mov eax, 80000006h
	push esi
	push ebx
	cpuid
	mov esi, [ebp + 8]
	mov eax, ecx			;line_size
	and ecx, 0xff			;se obtine prin and cu 0xff
	mov [esi], ecx
	shr eax, 16				;cache_size
	and eax, 0xffff			;se obtine prin and cu 0xffff
	mov esi, [ebp + 12]
	mov [esi], eax
	pop ebx
	pop esi
	leave
	ret
