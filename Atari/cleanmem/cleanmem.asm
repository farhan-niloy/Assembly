    processor 6502;

    seg code;
    org $F000    ; Define the code origin at $F000

Start: 
    sei          ; Disable interrupts
    cld          ; Disable the BCD dicimal math mode
    ldx #$FF     ; Load the X resister with #$FF
    txs          ; Transfer the X resister to the (S)tack Pointer
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Clear the Page Zero region($00 to $FF)
; Meaning the entire Ram and the entire TIA resisters
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda #0       ; A = 0
    ldx #$FF     ; X = #SFF

MemLoop:
    sta $0,X     ; Store the value of A inside the memory adress $0 + X
    dex          ; X--
    bne          ; Loop until X is equal to zero (z-flag is set)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fill the ROM size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    org $FFFC
    .word start  ; Reset vector at $FFFC (where the program starts)
    .word start  ; Interrupt vector at $FFFC (unused in the VCS) 
