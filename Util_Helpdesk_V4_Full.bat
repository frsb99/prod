
@echo off
REM chcp 65001

echo %computername% %username% %date% >> \\SERV26571\prod$\Usuarios_Menu_Full.txt
echo %computername% %username% %date% >> \\SERV26571\prod$\Usuarios_Menu_Full

cls
MENU
cls
color 0A

date /t

Set Deployserver0=\\SRV01
Set DeployServer1=\\SRV02
Set DeployServer2=\\SRV03
Set DeployServer3=\\SRV04
Set DeployServer4=\\SRV04

dir I:\ | FIND /i "Por_Maquina"
if %errorlevel%==1 goto MAP

dir I:\ | FIND /i "Por_Login"
if %errorlevel%==0 goto NOMES

:NOMES
REM timeout 15
del  %userprofile%\Desktop\Drive_Rename.vbs
echo Set oShell = CreateObject("Shell.Application") > %userprofile%\Desktop\Drive_Rename.vbs
echo oShell.NameSpace("I:\").Self.Name = "INVENTARIO" >> %userprofile%\Desktop\Drive_Rename.vbs
echo oShell.NameSpace("S:\").Self.Name = "SERVICEDESK" >> %userprofile%\Desktop\Drive_Rename.vbs
echo oShell.NameSpace("T:\").Self.Name = "TRANSFER" >> %userprofile%\Desktop\Drive_Rename.vbs
echo oShell.NameSpace("V:\").Self.Name = "SETUPS" >> %userprofile%\Desktop\Drive_Rename.vbs
echo oShell.NameSpace("U:\").Self.Name = "PROD$" >> %userprofile%\Desktop\Drive_Rename.vbs


:MAP
Net Use * /Del /Yes

Net use I: %DeployServer3%\Compartilhamento1
Net use S: %DeployServer2%\Compartilhamento2
Net use T: %DeployServer4%\Compartilhamento3
Net use V: %DeployServer1%
Net use U: %DeployServer0%


cd %userprofile%\Desktop

timeout 3
Drive_Rename.vbs
cls

dir C:\PStools | FIND /i "PSExec.exe" 

if %errorlevel%==1 goto CP_PST

:CP_PST
xcopy /S %DeployServer0%\PStools c:\Pstools\* /y

cls 
chcp 65001

:menu
echo                 Computador: %computername%        Usuario: %username%
 
echo                 -------------------------------------------------
echo                                # ACESSO RAPIDO #
echo                 -------------------------------------------------
echo                       ====================================
echo                       #   01. Prompt de Comando (Remoto) # 
echo                       ====================================
echo                       #   02. PowerShell (Remoto)        # 
echo                       ====================================
echo                       #   03. Wiki (Consulta)            # 
echo                       ====================================
echo                       #   04. OTRS (Chamados)            # 
echo                       ====================================
echo                       #   05. OTRS (Novo Chamado)        #  
echo                       ====================================
echo                       #   06. Inventario por Maquina     #
echo                       ====================================
echo                       #   07. Inventario por Usuario     #
echo                       ====================================
echo                       #   08. Whatsapp Web (chrome)      #
echo                       ====================================
echo                       #   09. Psexec (Remoto)            #
echo                       ====================================
echo                       #   10. PSinfo  (Remoto)           #
echo                       ====================================
echo                       #   11. PShutdown  (Remoto)        #
echo                       ====================================
echo                       #   12. Kace (Inventario)          #
echo                       ====================================
echo                       #   13. Reset de Senha (PS)        #
echo                       ====================================    
echo                       #   14. Map_Impressoras (Pasta)    #
echo                       ====================================
echo                       #   15. Acesso VNC (Acesso Direto) #
echo                       ====================================  
echo                       #   16. Copia Favoritos (Google)   #
echo                       ====================================
echo                       #   17. Remove Computador (PS)     #
echo                       ====================================
echo                       #   18. Config. de Rede (Explorer) #
echo                       ====================================
echo                       #   19. PST_Mapeadas (Explorer)    #
echo                       ====================================
echo                       #   20. Etiquetas Service Desk     #
echo                       ====================================

set /p opcao= Escolha uma opcao: 
echo ------------------------------
if %opcao% equ 1  goto opcao1
if %opcao% equ 2  goto opcao2
if %opcao% equ 3  goto opcao3
if %opcao% equ 4  goto opcao4
if %opcao% equ 5  goto opcao5
if %opcao% equ 6  goto opcao6
if %opcao% equ 7  goto opcao7
if %opcao% equ 8  goto opcao8
if %opcao% equ 9  goto opcao9
if %opcao% equ 10 goto opcao10
if %opcao% equ 11 goto opcao11
if %opcao% equ 12 goto opcao12
if %opcao% equ 13 goto opcao13
if %opcao% equ 14 goto opcao14
if %opcao% equ 15 goto opcao15
if %opcao% equ 16 goto opcao16
if %opcao% equ 17 goto opcao17
if %opcao% equ 18 goto opcao18
if %opcao% equ 19 goto opcao19
if %opcao% equ 20 goto opcao20

:opcao1
cls
echo   ===================================
echo   #         Executando CMD          #
echo   ===================================
set /p hostname= Digite o hostname para conexao:
start c:\Pstools\Psexec /accepteula \\%hostname% cmd.exe
cls
goto menu

:opcao2
cls
echo   ===================================
echo   #    Executando PowerShell        #
echo   ===================================
set /p hostname= Digite o hostname para conexao:
start c:\Pstools\Psexec /accepteula \\%hostname% Powershell.exe
cls
goto menu

:opcao3
cls
echo   ===================================
echo   #          Abrindo WIKI           #
echo   ===================================
start chrome.exe http://shpnsv3/sites/wiki
cls
goto menu

:opcao4
cls
echo   ===================================
echo   #   Abrindo Sistema de Chamado    #
echo   ===================================
start chrome.exe http://otrssv1/otrs/index.pl?Action=AgentTicketQueue;QueueID=16;View=;Filter=Unlocked
cls
goto menu

:opcao5
cls
echo   ===================================
echo   # Abrindo Sistema de Chamado NOVO #
echo   ===================================
start chrome.exe http://otrssv1.domhcor.local/otrs/index.pl?Action=AgentTicketPhone
cls
goto menu

:opcao6
cls
echo   ===================================
echo   #  Inventario por Maquina         #
echo   ===================================
Set /p hostname= Digite o hostname para conexao:
start I:\Por_Maquina\%hostname%.txt
cls
goto menu

:opcao7
cls
echo   ===================================
echo   #  Inventario por Login           #
echo   ===================================
Set /p hostname= Digite o hostname para conexao:
start  I:\Por_Usuario\%hostname%.txt
cls
goto menu

:opcao8
cls
echo   ====================================
echo   # Executando Whatsapp Web (chrome) #
echo   ====================================
start chrome.exe https://web.whatsapp.com/
cls
goto menu

:opcao9
cls
echo   ====================================
echo   # Executando PSexec (Remoto)       #
echo   ====================================
set /p hostname= Digite o hostname para conexao:
start c:\Pstools\Psexec /accepteula \\%hostname% cmd.exe
cls
goto menu

:opcao10
cls
echo   ====================================
echo   #  Executando PSinfo (Remoto)      #
echo   ====================================
set /p hostname= Digite o hostname para conexao:
start c:\Pstools\Psinfo /accepteula \\%hostname%
cls
goto menu

:opcao11
cls
echo   ====================================
echo   #  Executando PSshutdown (Remoto)  #
echo   ====================================
set /p hostname= Digite o hostname para conexao:
start c:\Pstools\Psshutdown /accepteula \\%hostname%
cls
goto menu

:opcao12
cls
echo   ====================================
echo   #  Abrindo o KACE (Inventario)     #
echo   ====================================
start chrome.exe http://kacesv1/admin
cls
goto menu

:opcao13
cls
echo   ====================================
echo   #   Reset de Senha do Login (PS)   #
echo   ====================================
\\help27842\prod$\SCRIPTS_V1\Scripts_V4\Reset_Login_AD_v1.exe
cls
goto menu

:opcao14
cls
echo   ===================================
echo   #  Mapeamentos_Impressoras        #
echo   ===================================

Set /p Decisao= %username%, Voce tem o nome do computador inteiro? Sim(1) ou Nao(2): 

if %Decisao% equ 1 goto op1
if %Decisao% equ 2 goto op2

:op1
Set /p consulta= Digite o Computador para consulta:
DIR "I:\Mapeamentos_Impressoras" | FIND /i "%consulta%" 
cls
goto menu

:op2
Set /p Computador= Digite o Computador para consulta:
Set /p hostname= Digite o login para consulta:
explorer.exe I:\Mapeamentos_Impressoras\%Computador%
notepad.exe  I:\Mapeamentos_Impressoras\%Computador%\%username%.txt
cls
goto menu

:opcao15
cls
echo   ===================================
echo   #  Acesso UVNC (Acesso Direto)    #
echo   ===================================
Set /p Computador= Digite o Computador para conexao:
start \\filesv1\UVNC$\vncviewer.exe -dsmplugin SecureVNCPlugin.dsm %hostname%
cls
goto menu

:opcao16
cls
echo   ===================================
echo   #  Copia Favoritos (Google)       #
echo   ===================================
Set /p origem_1=Digite o hostname de origem:
Set /p origem_2=Digite o login de origem:
Set /P destino_1= Digite o hostname de Destino:
Set /p destino_2= Digite o login de Destino:
If Exist  \\%destino_1%\c$\Users\%destino_2%\appdata\local\google\Chrome\"User Data"\default\Bookmarks ren Bookmarks Bookmarks.old  
xcopy /S /Y \\%origem_1%\c$\Users\%origem_2%\appdata\local\google\Chrome\"User Data"\default\Bookmarks \\%destino_1%\c$\Users\%destino_2%\appdata\local\google\Chrome\"User Data"\default 
pause
cls
goto menu

:opcao17
cls
echo   ====================================
echo   #   Remove Computador do AD (PS)   #
echo   ====================================
\\PC\prod$\SCRIPTS_V1\Scripts_V4\Excluir_Computador_AD_v1.exe
cls
goto menu


:opcao18
cls
echo   ===================================
echo   #  Abrindo Configuraçoes de Rede  #
echo   ===================================
start Ncpa.cpl
cls
goto menu 

:opcao19
cls
echo   ====================================
echo   #  Abrindo PST Mapeadas (Explorer) #
echo   ====================================
Set /p user= Digite o Login para consulta:
Set /p hostname= Digite o hostname para consulta:
notepad I:\PST_Mapeados\%date:~3,2%-%date:~6,10%\%user%_%hostname%
cls
goto menu 

:opcao20
cls
echo   ===================================
echo   #    Configurando Etiquetadora    #
echo   ===================================
DIR "C:\Program Files\Zebra Technologies\ZebraDesigner 3\bin.net" | FIND /i "ZebraDesigner.exe"
if %errorlevel%==0 GOTO CP_ATL

msg %username% "ZEBRA Design 3 NÃO INSTALADA, favor instalar"
\\help27842\prod$\SOFTWARES\Zebra_Design_3.exe

:CP_ATL
msg %username% "ZEBRA Design 3 INSTALADA, Atalhos copiados para o Desktop"
rundll32 printui.dll PrintUIEntry /in /n \\help34513\P130_HELP_DESK_3SS
xcopy /S /Y \\help27842\prod$\CONFIG_ETQ\*lnk %userprofile%\Desktop\
cls
goto menu
cls

REM netsh interface set interface “Ethernet 10” admin=disable
