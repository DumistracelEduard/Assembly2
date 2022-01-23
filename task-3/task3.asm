global get_words
global compare_func
global sort
section .data
    delimiter times 3 DB '.', ' ', ','
section .text

extern strtok
extern strlen
extern strcmp
extern qsort

compare:
    enter 0, 0
    push ebx
    push ecx
    push edx
    mov eax, [ebp + 8]      ; primul cuvant
    push DWORD[eax]
    call strlen
    add esp, 4
    push eax                ; lung primului cuvant
    mov ecx, [ebp + 12]     ; al doilea cuvant
    push DWORD[ecx]
    call strlen             ;lung al doilea cuv
    add esp, 4
    pop ecx
    sub ecx, eax            ; diferenta dintre lungimi
    mov eax, ecx            ; salvez in eax
    cmp eax, 0              ; daca este 0 fac lexico
    jne final
    mov eax, [ebp + 8]      ; primul cuvant
    mov ebx, [ebp + 12]     ; al doilea cuvant
    push dword[ebx]
    push dword[eax]
    call strcmp             ; raspuns pus in eax
    add esp, 8
final:
    pop edx
    pop ecx
    pop ebx
    leave
    ret

;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix
sort:
    enter 0, 0
    mov eax, [ebp + 8]      ; words
    mov ebx, [ebp + 12]     ; number of words
    mov ecx, [ebp + 16]     ; size
    push compare
    push ecx
    push ebx
    push eax
    call qsort              ; apelez qsort
    add esp, 16
    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    enter 0, 0
    ;eax contine number_of_words
    mov eax, [ebp + 8]      ; string de despartit
    mov esi, [ebp + 12]     ; de salvat cuvintele
    mov ecx, [ebp + 16]     ; number_of_words
    push ecx
    push delimiter
    push eax
    call strtok
    add esp, 7
    xor edi, edi
    mov [esi + 4 * edi], eax ; salvez primul
    inc edi
loop_word:
    push delimiter
    push 0
    call strtok
    add esp, 7
    mov [esi + 4 * edi], eax ; salvez restul de cuvinte
    inc edi
    cmp edi, [ebp + 16]
    jne loop_word
    leave
    ret
