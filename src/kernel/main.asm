org 0x7C00
bits 16
%define ENDL 0x0D, 0x0A

start:
	jmp main
	
;;; Prints a string to the screen
;;; Params:
;;; 	-ds:si points to string

puts:
	;; Save the registers for modification
	push si
	push ax


.loop:

	lodsb			;Lods next character
	or al,al		;Verify if next character is null
	jz .done

	mov ah, 0x0e		;Call BIOS interupt
	int 0x10
	jmp .loop

.done:
	pop ax
	pop si
	ret
	
main:
	;; Setting up the data segments
	mov ax, 0		;Can't write data to ds/es directly
	mov ds, ax
	mov es, ax

	;; Setup the stack
	mov ss, ax
	mov sp, 0x7C00		;Points to start of OS

	;; Print Message
	mov si, msg_hello
	call puts
	
	hlt
	
.halt:
	jmp .halt

msg_hello:db 'Hello FlopOS',ENDL,0
	

times 510-($-$$)db 0
dw 0AA55h
