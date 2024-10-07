#Script criado pelo analista Felipe Barbosa para facilitar o reset e desbloqueio de contas no AD
#13/10/2020 - Editado por Edson Freitas
#20/10/2020 - Editado por Felipe R. Barbosa - Add comando que remove computador do AD.
#21/10/2020 - Editado por Edson Freitas - Zerar variavel e omitir erros

#Oculta qualquer mensagem de erro
$ErrorActionPreference= 'silentlycontinue'

#Add biblioteca necessaria para exibicao da menssagem e exibe a mesma atraves de um POP-UP de aviso.
Add-Type -AssemblyName PresentationCore,PresentationFramework

#Limpa variaveis

$UnidadeOrganizacional ='Nao encontrado'

#Coleta data
$Date = Get-Date 


[System.Windows.MessageBox]::Show('Atencao! 
A utilizacao desta ferramenta esta sendo monitorada pode impactar diretamente na rotina de trabalho do colaborador. 
Confirme com exatidao os dados do computador que sera excluido do AD, sera necessario adicionar novamnete ao dominio.

Essa acao esta sendo registrada em rede e um e-mail sera enviado reportando aos administradores','Execucao Controlada')

$titulo = 'Exclusao de computador no AD'
$questao = 'Qual ação deseja realizar?'
$choice = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
$choice.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Excluir computador do AD'))
$choice.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Cancelar ação'))
$decisao = $Host.UI.PromptForChoice($titulo, $questao, $choice, 0)

if ($decisao -eq 0) {

    #Set Variavel para coletar o computador que vamos remover do AD.
    $Computeremove = Read-Host -Prompt 'Informe o nome do computador que sera removido do AD'
    $checkname = @(Get-ADComputer -Identity $Computeremove)
    $UnidadeOrganizacional = @(Get-ADComputer -Identity $Computeremove)
    $titulo   = 'Remover computador do AD!'
    $questao = 'Tem certeza que quer remover o computador "'+$Computeremove+'" que esta na Unidade Organizacional '+$checkname+' ?'
    $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Sim, excluir conta do computador'))
    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Nao, manter conta do computador'))
    
        
    #Caso seja escolhida essa opcao o computador sera removido do AD
    $decisao = $Host.UI.PromptForChoice($titulo, $questao, $choice, 0)
    
    if ($decisao -eq 0){
    $checkname = @(Get-ADComputer -Identity $Computeremove)
    
        if($checkname.Count -eq 0) {
        [System.Windows.MessageBox]::Show('O computador "'+$Computeremove+ '" nao existe no AD!')
        exit
        }
    
        if($checkname.Count -eq 1){
    #[System.Windows.MessageBox]::Show('Escolheu excluir computador "'+$Computeremove+ '" que esta na OU ' +$OU+ '') 
    Remove-ADComputer -Identity $Computeremove  -Confirm:$false
    Start-Sleep -s 5
    $checkname = @(Get-ADComputer -Identity $Computeremove)
     
     
         if($checkname.Count -eq 1){
        # Computeremove found
        Write-Host "O computador NAO foi removido do AD favor contatar Gestao de Ambientes."
        #[System.Windows.MessageBox]::Show('valor da variavel checkname '+$checkname+ ' apos if($checkname.Count -eq 1)')
        [System.Windows.MessageBox]::Show('Computador "'+$Computeremove+ '" NAO foi removido do AD, registre chamado com a equipe de Gestao de Ambientes')
        }

        if($checkname.Count -eq 0){
         [System.Windows.MessageBox]::Show('Computador "' +$Computeremove+ '" foi removido do AD.')
        #Email enviado para informar a remocao
        $username = "edcomum@hcor.com.br"
        $password = "1234567890"
        $sstr = ConvertTo-SecureString -string $password -AsPlainText -Force
        $cred = New-Object System.Management.Automation.PSCredential -argumentlist $username, $sstr
        $body = "O Computador $computeremove foi REMOVIDO e estava na OU $UnidadeOrganizacional <br/> Data do desbloqueio: $Date <br/> Usuario reponsavel: $env:UserName <br/> Computador utilizado $env:COMPUTERNAME <br/> $Antes"
        #Send-MailMessage -To "Alertas_AD_ServiceDesk@hcor.com.br" -from "Alertas_AD_ServiceDesk@hcor.com.br" -Subject "Tentantiva de remocao de conta do PC (AD) - Computador $Computeremove" -Body $body -BodyAsHtml -Cc fsbarbosa@hcor.com.br -smtpserver 191.1.1.66 -Credential $cred -Port 25
        }
     }   
}
}
if ($decisao -eq 1) {
        [System.Windows.MessageBox]::Show('O computador '+$Computeremove+ ' nao foi removido, ação cancelada, nenhuma alteracao foi realizada')
        #exit
    }
#exit
