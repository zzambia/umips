main:  
        addiu $s0, $0, 6 
        add $s1, $s0, $0
        add $s2, $s0, $0
        add $s3, $s0, $0
        lw $s0, 0($gp)
        sw $s0, 8($gp)

