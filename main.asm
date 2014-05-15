.macro bump addr 
.word \addr+0x00200000
.endm

 ehdr:                                                     @ Elf32_Ehdr
                 .byte      0x7F, 'E', 'L', 'F'             @   e_ident
                 .word      0x00010101                      @   e_ident                       
                 .word      0x00000000                      @   e_reserved                       
                 .word      0x00000000                      @   e_reserved                       
                 .word      0x00280002                      @   e_type & e_machine     
                 .word      0x00000001                      @   e_version              
                 bump       main                            @   e_entry                
                 .word      phdr                            @   e_phoff                
                 .word      0x00000000                      @   e_shoff                
                 .word      0x00000000                      @   e_flags
                 .word      0x00200034                      @   e_ehsize & e_phentsize
                 .word      0x00000001                      @   e_phnum & e_shentsize
                 .word      0x00000000                      @   e_shnum & e_shstrndx
 phdr:
                 .word      0x00000001                      @ p_type
                 .word      0x00000000                      @ p_offset
                 .word      0x00200000                      @ p_vaddr
                 .word      0x00200000                      @ p_paddr
                 .word      eof                             @ p_filesz
                 .word      eof                             @ p_memsz
                 .word      0x00000007                      @ p_flags
                 .word      0x00000000                      @ p_allign

loop_count:      .word      3001
rand_multiplier: .word      16807
rand_seed:       .word      2097205
symboltable:     .ascii     ".:;!]&@#"
main:            ldr        r4, rand_seed
                 ldr        r0, loop_count
                 ldr        r5, rand_multiplier
                 push       {r0, r4, r5}
loop:            pop        {r0, r4, r5}
                 subs       r0, r0, #1
                 beq        end
                 mov        r3, #1
                 mla        r3, r4, r5, r3
                 push       {r0, r3, r5}
                 and        r3, r3, #0x70000
                 asr        r3, r3, #0x10
print_char:      mov        r7, #4
                 mov        r0, #1
                 adr        r1, symboltable
                 add        r1, r1, r3
                 mov        r2, #1
                 svc        0
                 b          loop
end:             mov        r7, #1
                 mov        r0, #42
                 svc        0
eof:
