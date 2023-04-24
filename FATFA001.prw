#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

User Function FATFA001()

	Local c_Combo	:= ""
	Local c_EstFis	:= IIF( SN1->N1_XESTFIS == "1", "1 - Bom", IIF( SN1->N1_XESTFIS == "2", "2 - Inservivel", "3 - Disponivel" ) )
	Local n_Opca	:= 0

	SetPrvt("oFont1","oDlg1","oSay1","oSay2","oCBox1","oSBtn1","oSBtn2","oGet1")

	oFont1     := TFont():New( "Consolas",0,-13,,.F.,0,,400,.F.,.F.,,,,,, )

	oDlg1      := MSDialog():New( 100,304,211,625,"Estado Físico do Bem",,,.F.,,,,,,.T.,,oFont1,.T. )

	oSay1      := TSay():New( 008,004,{||"Estado Físico Atual:"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,072,008)
	oGet1      := TGet():New( 007,080,{|u| If(PCount() > 0,c_EstFis:= u,c_EstFis)},oDlg1,060,008,'',,CLR_BLACK,CLR_WHITE,oFont1,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","")
	oGet1:Disable()

	oSay2      := TSay():New( 024,004,{||"Estado Físico Novo:"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,072,008)
	oCBox1     := TComboBox():New( 023,080,{|u| if( Pcount( )>0,c_Combo:= u,c_Combo)},{"1 - Bom","2 - Inservivel","3 - Disponivel"},072,011,oDlg1,,,,CLR_BLACK,CLR_WHITE,.T.,oFont1,"",,,,,,, )

	oSBtn1     := SButton():New( 035,105,1,{|| n_Opca:=1, oDlg1:End() },oDlg1,,"", )
	oSBtn2     := SButton():New( 035,078,2,{|| n_Opca:=2, oDlg1:End() },oDlg1,,"", )

	oDlg1:Activate(,,,.T.)

	If n_Opca == 1

		If Aviso(SM0->M0_NOMECOM,"Confirma a alteração do Estado Físico do Bem?",{"Sim","Não"},2,"Atencao") == 1
			dbSelectArea("SN1")
			RecLock( "SN1", .F. )
			SN1->N1_XESTFIS	:= Substr( c_Combo, 1, 1 )
			MsUnLock()
		EndIf
	EndIf

Return()