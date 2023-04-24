#include "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±³Programa  ³ MATFG001  ³ Autor ³ Elisângela Souza   ³Criado³ Abr/2019   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Gatilho para criacao da sequencia do codigo inteligente de ³±±
±±³produto     bem do ativo                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAATF                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³Arquivos Relacionados³ SN1                                             ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

User Function FATFA003()

_cAlias := Alias()
_cOrd   := IndexOrd()
_nReg   := Recno()
_cIni 	:= GetMv("FS_ATFINI")

cQry := " SELECT TOP 1 N1_CBASE AS CODIGO "
cQry += " FROM " + RetSqlName("SN1")
cQry += " WHERE SUBSTRING(N1_FILIAL,1,4) = '" + SubStr(xFilial("SN1"),1,4) + "'"
cQry += " AND   SUBSTRING(N1_CBASE,1,4)  = '" + _cIni + "'"
cQry += " AND D_E_L_E_T_ <> '*' "
cQry += " ORDER BY CODIGO DESC "

TcQuery cQry New Alias "QRY"

// Se for final de arquivo
DbSelectArea("QRY")
If QRY->( Eof() )
	_xCod := _cIni + "000001"
Else
	_xCod := StrZero((Val(QRY->CODIGO)+1),10)
Endif

QRY->( DbCloseArea() )

Dbselectarea(_cAlias)
Dbsetorder(_cOrd)
Dbgoto(_nReg)

Return _xCod