#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "PARMTYPE.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±³Function  ³ATFFltPen ³ Autor ³ Carlos Ryve Gandini   ³ Data ³13/04/18  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Filtra os BENS classificados como PENHORA.                  ³±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Function u_ATFFltPen(nOpc)
Local aArea     := GetArea()
Local cCondicao := ATFFltChec()
Local cFiltro   := "@#"

PARAMTYPE 0 VAR nOpc AS NUMERIC OPTIONAL DEFAULT 0

	CreateParm()
	
	If GetMv("JA_HBATFPE") == "SIM"
		
		If nOpc == 1
		
			dbSelectArea("SN1")
			dbSetOrder(1)
			dbSetFilter({|| &cCondicao}, cCondicao)
			dbGoTop()
		
		Else
		
			Return cFiltro + cCondicao + cFiltro
		
		EndIf
			
	EndIf

RestArea(aArea)

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±³Function  ³ATFFltChec³ Autor ³ Carlos Ryve Gandini   ³ Data ³13/04/18  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Retorna a expressa para filtro dos BENS DE PENHORA.         ³±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ATFFltChec()
Local cFiltro		:= ""

cFiltro := 'N1_FILIAL  = "' + xFilial("SN1") + '" .AND. '
cFiltro += 'N1_XPENHOR <> "S"'

Return cFiltro

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±³Method    ³CreateParm³ Autor ³ Carlos Ryve Gandini   ³ Data ³04/07/16  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Method Responsavel por verificação e criacao do Parametros. ³±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function CreateParm()
local cAlias := "SX6"

	dbSelectArea(cAlias)
	
	If !ExisteSx6("JA_HBATFPE")
		CriarSX6("JA_HBATFPE" , ;
		         "C"          , ;
		         "Filtra os BENS DE PENHORA, na consultra padrao SN1 ?" , ;
		         "S"            ;
		        )
		        
		RecLock(cAlias,.F.)
		(cAlias)->( fieldPut( fieldPos("X6_FIL") , cFilAnt ) )
		msUnlock()
	EndIf 	                                                                                                       
Return nil
