cls
$digits = (0x7e,0x12,0xbc,0xb6,0xd2,0xe6,0xee,0x32,0xfe,0xf2,0xfa,0xce,0x6c,0x9e,0xec,0xe8)
$neg = '80'
$out = "v2.0 raw`n"

# Unsigned Decimal 0 to 255
for ($addr = 0; $addr -le 255; $addr++) {
    $units =    $addr % 10
    $tens  =    [math]::floor($addr/10) % 10
    $hundreds = [math]::floor($addr/100) % 10
    if ($hundreds -ne 0) {
        $out += '{0:x2}{1:x2}{2:x2}' -f $digits[$hundreds],$digits[$tens],$digits[$units]
    }
    elseif ($tens -ne 0) {
        $out += '{0:x2}{1:x2}' -f $digits[$tens],$digits[$units]
    }
    else {
        $out += '{0:x2}' -f $digits[$units]
    }
    if (($addr + 1) % 8 -eq 0) {
        $out += "`n"
    }
    else {
        $out += " "
    }
}
$out += "`n"

# Signed Decimal -128 to 127
for ($addr = 0; $addr -le 127; $addr++) {
    $units =    $addr % 10
    $tens  =    [math]::floor($addr/10) % 10
    $hundreds = [math]::floor($addr/100) % 10
    if ($hundreds -ne 0) {
        $out += '{0:x2}{1:x2}{2:x2}' -f $digits[$hundreds],$digits[$tens],$digits[$units]
    }
    elseif ($tens -ne 0) {
        $out += '{0:x2}{1:x2}' -f $digits[$tens],$digits[$units]
    }
    else {
        $out += '{0:x2}' -f $digits[$units]
    }
    if (($addr + 1) % 8 -eq 0) {
        $out += "`n"
    }
    else {
        $out += " "
    }
}
for ($addr = 128; $addr -gt 0; $addr--) {
    $units =    $addr % 10
    $tens  =    [math]::floor($addr/10) % 10
    $hundreds = [math]::floor($addr/100) % 10
    $out += $neg
    if ($hundreds -ne 0) {
        $out += '{0:x2}{1:x2}{2:x2}' -f $digits[$hundreds],$digits[$tens],$digits[$units]
    }
    elseif ($tens -ne 0) {
        $out += '00{0:x2}{1:x2}' -f $digits[$tens],$digits[$units]
    }
    else {
        $out += '0000{0:x2}' -f $digits[$units]
    }
    if (($addr - 1) % 8 -eq 0) {
        $out += "`n"
    }
    else {
        $out += " "
    }
}
$out += "`n"

# Hexadecimal 00 to FF
for ($addr = 0; $addr -le 255; $addr++) {
    $units =    $addr % 16
    $tens  =    [math]::floor($addr/16) % 16
    $out += '{0:x2}{1:x2}00' -f $digits[$tens],$digits[$units]
    if (($addr + 1) % 8 -eq 0) {
        $out += "`n"
    }
    else {
        $out += " "
    }
}
$out += "`n"

# Octal 000 to 377
for ($addr = 0; $addr -le 255; $addr++) {
    $units =    $addr % 8
    $tens  =    [math]::floor($addr/8) % 8
    $hundreds = [math]::floor($addr/64) % 8
    $out += '{0:x2}{1:x2}{2:x2}' -f $digits[$hundreds],$digits[$tens],$digits[$units]
    if (($addr + 1) % 8 -eq 0) {
        $out += "`n"
    }
    else {
        $out += " "
    }
}
$out += "`n"

# Output
$out
$outFile = [Environment]::GetFolderPath('MyDocuments')
$outfile += "\Logisim\My Sap_Display_Decoder_PS.ROM"
Out-File -FilePath $outFile -InputObject $out -Encoding utf8