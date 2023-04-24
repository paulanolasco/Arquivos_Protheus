#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "FWCOMMAND.CH"

User Function FATFA002()

	Local oBrowse 		:= FWMBrowse():New()
	Local aLegenda		:= {}

	Private aRotina		:= MenuDef()
	Private CCADASTRO	:= "Ativo Fixo - Imobilizado"

	oBrowse:SetAlias('SN1')
	oBrowse:SetDescription('Ativo Fixo - Imobilizado')
	aLegenda := AtfLegenda('SN1')
	For nX := 1 To Len(aLegenda)
		oBrowse:AddLegend( aLegenda[nX,1],aLegenda[nX,2])
	Next
	oBrowse:Activate()

Return()

Static Function MenuDef()

	Local a_Ret := {}

	ADD OPTION a_Ret Title 'Pesquisar'					Action 'PesqBrw'		OPERATION 1 ACCESS 0
	ADD OPTION a_Ret Title 'Visualizar'					Action 'AxVisual'		OPERATION 2 ACCESS 0
	ADD OPTION a_Ret Title 'Est. Fis. Bem'				Action 'U_FATFA001()'	OPERATION 4 ACCESS 0

Return( a_Ret )
