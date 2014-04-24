.macro bump addr 
.word \addr+0x200000
.endm

 ehdr:                                                     @ Elf32_Ehdr
                 .byte      0x7F, 'E', 'L', 'F'             @   e_ident
                 .word      1                               @                          @ p_type
                 .word      0                               @                          @ p_offset
                 .word      0x200000                        @                          @ p_vaddr
                 .word      0x280002                        @   e_type & e_machine     @ p_paddr
                 bump       main                            @   e_version              @ p_filesz
                 bump       main                            @   e_entry                @ p_memsz
                 .word      4                               @   e_phoff                @ p_flags
loop_count:      .word      0x00000BB9                      @   e_shoff                @ p_allign
rand_multiplyer: .word      0x41A7                          @   e_flags
rand_seed:       .word      0x200034                        @   e_ehsize & e_phentsize
                 .word      1                               @   e_phnum & e_shentsize
symboltable:     .ascii     ".:;!]&@#"
main:            ldr        r4, rand_seed
                 ldr        r0, loop_count
                 push       {r0,r4}
loop:            pop        {r0,r4}
                 subs       r0, r0, #1
                 beq        end
                 ldr        r5, rand_multiplyer
                 mov        r3, #1
                 mla        r3, r4, r5, r3
                 push       {r0,r3}
                 and        r3, r3, #458752
                 asr        r3, r3, #16
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
