section .text
	global sort

; struct node {
;     	int val;
;    	struct node* next;
; };

;; struct node* sort(int n, struct node* node);
; 	The function will link the nodes in the array
;	in ascending order and will return the address
;	of the new found head of the list
; @params:
;	n -> the number of nodes in the array
;	node -> a pointer to the beginning in the array
; @returns:
;	the address of the head of the sorted list
sort:
	enter 0, 0

	mov edx, [ebp + 8]	; n
	mov ebx, [ebp + 12]	; node
	xor eax, eax
	xor esi, esi
	xor edi, edi
	xor ecx, ecx

scroll:
	mov esi, [ebx + 8 * ecx]
	cmp edx, esi
	je push_elem

cont_sort:
	inc ecx
	cmp edx, 0
	jg scroll
	xor ecx, ecx
	jmp end

push_elem:
	push ecx 	;salvam pozitia fiecarui element
	dec edx
	xor ecx, ecx
	jmp scroll

end:
	pop edx
	pop edi
	cmp dword [ebx + 8 * edx], 1
	jne not_head
	lea eax, [ebx + 8 * edx] ; salvam prima pozitie

not_head:
	lea esi, [ebx + 8 * edi]
	mov [ebx + 8*edx + 4], esi
	push edi
	mov edx, [ebp + 8]
	dec edx
	inc ecx
	cmp ecx, edx
	jne end

	leave
	ret
