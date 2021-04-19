#CSV deve conter primeiro campo com computer e os demais um host por linha
Start-Transcript -path '\\domhcor.local\comum$\inventario$\Atualiza_Senior\Atualizados.txt'


#$outFileName="C:\Temp\PC_RONDA-done.TXT"
$inFileName="\\SERVIDOR\COMPARTILHAMENTO\Senior_Atualiza\PC_RONDA.csv"
$computador=Import-Csv $inFileName
$DeploySenior='\\SERVIDOR\COMPARTILHAMENTO\Senior_Atualiza\Atalhos\*.lnk'
$DeploySeniorCTRL='\\SERVIDOR\COMPARTILHAMENTO\Senior_Atualiza\inst.ctrl'

ForEach ($_ in $computador.computer){

#New-Item -Force -Path '\\$_\C$\Users\Public\Desktop\Senior\Vetorh' -ItemType Directory 
New-Item -Force -Path "\\$_\C$\Users\Public\Desktop\Senior\Vetorh" -ItemType Directory


#Copy-Item "$DeploySenior" -Destination \\$_\C$\Users\public\Desktop\Senior\Vetorh\
Copy-Item $DeploySenior -Destination "\\$_\C$\Users\public\Desktop\Senior\Vetorh" -Recurse -Force -Verbose
Copy-Item $DeploySeniorCTRL "\\$_\C$\Senior"  -Force -Verbose

#$pc | Export-Csv $outFileName
# dir \\SIST27839\c$\temp\teste2021
}
Stop-Transcript
