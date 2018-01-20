cls
$cSig = @{
    'PC_OUT'     = 0x000001;
    'PC_IN'      = 0x000002;
    'PC_INC'     = 0x000004;
    'ADDR_IN'    = 0x000008;
     
    'RAM_OUT'    = 0x000010;
    'RAM_IN'     = 0x000020;
    'HALT'       = 0x000040;
    'IR_IN'      = 0x000080;
     
    'A_OUT'      = 0x000100;
    'A_IN'       = 0x000200;
    'B_OUT'      = 0x000400;
    'B_IN'       = 0x000800;
     
    'ALU_OUT'    = 0x001000;
    'ALU_IN'     = 0x002000;
    'T_RESET'    = 0x004000;
    'DISP_IN'    = 0x008000;
     
    'C_OUT'      = 0x010000;
    'Z_OUT'      = 0x020000;
    'S_OUT'      = 0x040000;
    'FLAG_INV'   = 0x080000;
     
    'ALU_STC'    = 0x100000;
    'ALU_CLC'    = 0x200000;
    'ALU_SUB'    = 0x400000;
    'CS23'       = 0x800000; 
}
$ops = @{
    'HALT'       = $cSig['HALT'];
    'T_RESET'    = $cSig['T_RESET'];
    'PC2ADDR'    = $cSig['PC_OUT'] -bor $cSig['ADDR_IN'];
    'FETCH_IR'   = $cSig['RAM_OUT'] -bor $cSig['PC_INC'] -bor $cSig['IR_IN'];
    'FETCH_ADDR' = $cSig['RAM_OUT'] -bor $cSig['PC_INC'] -bor $cSig['ADDR_IN'];
    'FETCH_A'    = $cSig['RAM_OUT'] -bor $cSig['PC_INC'] -bor $cSig['A_IN'];
    'FETCH_B'    = $cSig['RAM_OUT'] -bor $cSig['PC_INC'] -bor $cSig['B_IN'];
    'FETCH_ALU'  = $cSig['RAM_OUT'] -bor $cSig['PC_INC'] -bor $cSig['ALU_IN']
    'RAM2A'      = $cSig['RAM_OUT'] -bor $cSig['A_IN'];
    'RAM2B'      = $cSig['RAM_OUT'] -bor $cSig['B_IN'];
    'RAM2ALU'    = $cSig['RAM_OUT'] -bor $cSig['ALU_IN'];
    'RAM2DISP'   = $cSig['RAM_OUT'] -bor $cSig['DISP_IN'];
    'RAM2PC'     = $cSig['RAM_OUT'] -bor $cSig['PC_IN'];
    'RAM2PC_C'   = $cSig['RAM_OUT'] -bor $cSig['PC_IN'] -bor $cSig['C_OUT'];
    'RAM2PC_NC'  = $cSig['RAM_OUT'] -bor $cSig['PC_IN'] -bor $cSig['C_OUT'] -bor $cSig['FLAG_INV'];
    'RAM2PC_Z'   = $cSig['RAM_OUT'] -bor $cSig['PC_IN'] -bor $cSig['Z_OUT'];
    'RAM2PC_NZ'  = $cSig['RAM_OUT'] -bor $cSig['PC_IN'] -bor $cSig['Z_OUT'] -bor $cSig['FLAG_INV'];
    'RAM2PC_S'   = $cSig['RAM_OUT'] -bor $cSig['PC_IN'] -bor $cSig['S_OUT'];
    'RAM2PC_NS'  = $cSig['RAM_OUT'] -bor $cSig['PC_IN'] -bor $cSig['S_OUT'] -bor $cSig['FLAG_INV'];
    'A2B'        = $cSig['A_OUT'] -bor $cSig['B_IN'];
    'A2ALU'      = $cSig['A_OUT'] -bor $cSig['ALU_IN'];
    'A2RAM'      = $cSig['A_OUT'] -bor $cSig['RAM_IN'];
    'A2DISP'     = $cSig['A_OUT'] -bor $cSig['DISP_IN'];
    'B2A'        = $cSig['B_OUT'] -bor $cSig['A_IN'];
    'B2ALU'      = $cSig['B_OUT'] -bor $cSig['ALU_IN'];
    'B2RAM'      = $cSig['B_OUT'] -bor $cSig['RAM_IN'];
    'B2DISP'     = $cSig['B_OUT'] -bor $cSig['DISP_IN'];
    'ALU2A'      = $cSig['ALU_OUT'] -bor $cSig['A_IN'];
    'ALU_ADD'    = $cSig['ALU_IN'];
    'ALU_ADC'    = $cSig['ALU_IN'] -bor $cSig['C_OUT'];
    'ALU_SUB'    = $cSig['ALU_IN'] -bor $cSig['ALU_SUB'];
    'ALU_SBB'    = $cSig['ALU_IN'] -bor $cSig['ALU_SUB'] -bor $cSig['C_OUT'];
    'ALU_STC'    = $cSig['ALU_STC'];
    'ALU_CLC'    = $cSig['ALU_CLC'];
}

$out = "v2.0 raw`n"
# OP BYTES/T-STATES MNEMONIC
# LOAD
# 00 2/5 LDXA (DD)
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['FETCH_ADDR'],$ops['RAM2A'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 01 2/5 LDXB (DD)
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['FETCH_ADDR'],$ops['RAM2B'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 02 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 03 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 04 2/4 LDIA DD
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['FETCH_A'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 05 2/4 LDIB DD
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['FETCH_B'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 06 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 07 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"

# STORE/TRANSFER
# 08 2/5 STXA (DD)
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['FETCH_ADDR'],$ops['A2RAM'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 09 2/5 STXB (DD)
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['FETCH_ADDR'],$ops['B2RAM'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 0A 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 0B 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 0C 1/3 TAB
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['A2B'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 0D 1/3 TBA
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['B2A'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 0E 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 0F 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"

# ADD
# 10 2/6 ADDX (DD)
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['FETCH_ADDR'],($ops['RAM2ALU'] -bor $ops['ALU_ADD']),$ops['ALU2A'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 11 2/5 ADDI DD
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],($ops['FETCH_ALU'] -bor $ops['ALU_ADD']),$ops['ALU2A'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 12 1/4 ADDA
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],($ops['A2ALU'] -bor $ops['ALU_ADD']),$ops['ALU2A'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 13 1/4 ADDB
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],($ops['B2ALU'] -bor $ops['ALU_ADD']),$ops['ALU2A'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 14 2/6 ADCX (DD)
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['FETCH_ADDR'],($ops['RAM2ALU'] -bor $ops['ALU_ADC']),$ops['ALU2A'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 15 2/5 ADCI DD
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],($ops['FETCH_ALU'] -bor $ops['ALU_ADC']),$ops['ALU2A'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 16 1/4 ADCA
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],($ops['A2ALU'] -bor $ops['ALU_ADC']),$ops['ALU2A'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 17 1/4 ADCB
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],($ops['B2ALU'] -bor $ops['ALU_ADC']),$ops['ALU2A'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"

# SUB
# 18 2/6 SUBX (DD)
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['FETCH_ADDR'],($ops['RAM2ALU'] -bor $ops['ALU_SUB']),$ops['ALU2A'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 19 2/5 SUBI DD
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],($ops['FETCH_ALU'] -bor $ops['ALU_SUB']),$ops['ALU2A'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 1A 1/4 SUBA
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],($ops['A2ALU'] -bor $ops['ALU_SUB']),$ops['ALU2A'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 1B 1/4 SUBB
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],($ops['B2ALU'] -bor $ops['ALU_SUB']),$ops['ALU2A'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 1C 2/6 SBBX (DD)
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['FETCH_ADDR'],($ops['RAM2ALU'] -bor $ops['ALU_SBB']),$ops['ALU2A'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 1D 2/5 SBBI DD
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],($ops['FETCH_ALU'] -bor $ops['ALU_SBB']),$ops['ALU2A'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 1E 1/4 SBBA
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],($ops['A2ALU'] -bor $ops['ALU_SBB']),$ops['ALU2A'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 1F 1/4 SBBB
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],($ops['B2ALU'] -bor $ops['ALU_SBB']),$ops['ALU2A'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"

# FLAGS
# 20 1/3 CLC
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['ALU_CLC'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 21 1/3 STC
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['ALU_STC'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 22 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 23 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 24 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 25 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 26 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 27 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"

# BOOLEAN
# 28 2/6 CMPX (DD)
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['FETCH_ADDR'],($ops['RAM2ALU'] -bor $ops['ALU_SUB']),$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 29 2/5 CMPI DD
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],($ops['FETCH_ALU'] -bor $ops['ALU_SUB']),$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 2A 1/4 CMPA
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],($ops['A2ALU'] -bor $ops['ALU_SUB']),$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 2B 1/4 CMPB
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],($ops['B2ALU'] -bor $ops['ALU_SUB']),$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 2C 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 2D 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 2E 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 2F 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"

# JUMP
# 30 2/4 JMP DD
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['RAM2PC'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 31 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 32 1/2 JC DD
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['RAM2PC_C'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 33 1/2 JNC DD
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['RAM2PC_NC'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 34 1/2 JZ DD
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['RAM2PC_C'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 35 1/2 JNZ DD
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['RAM2PC_C'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 36 1/2 JS DD
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['RAM2PC_C'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 37 1/2 JNS DD
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['RAM2PC_C'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"

# CONTROL
# 38 1/4 OUTX (DD)
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['FETCH_ADDR'],$ops['RAM2DISP'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 39 1/4 OUTI DD
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['PC2ADDR'],$ops['RAM2DISP'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 3A 1/4 OUTA
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['A2DISP'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 3B 1/4 OUTB
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['B2DISP'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 3C 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 3D 1/2 nop
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 3E 1/2 NOP
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"
# 3F 1/3 HALT
$out += '{0:x} {1:x} {2:x} {3:x} {4:x} {5:x} {6:x} {7:x}' -f $ops['PC2ADDR'],$ops['FETCH_IR'],$ops['HALT'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET'],$ops['T_RESET']
$out += "`n8*ffffff`n"

# Output Results
$out
$outFile = [Environment]::GetFolderPath('MyDocuments')
$outFile += "\Logisim\My Sap_Instruction_Decoder_PS.ROM"
$outFile
Out-File -FilePath $outFile -InputObject $out -Encoding utf8