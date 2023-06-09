#include "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北砅rograma  � MATFG001  � Autor � Elis鈔gela Souza   矯riado� Abr/2019   潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪哪幢�
北矰escricao � Gatilho para criacao da sequencia do codigo inteligente de 潮�
北硃roduto     bem do ativo                                               潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砋so       � SIGAATF                                                    潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪俦�
北矨rquivos Relacionados� SN1                                             潮�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
/*/

User Function FATFA003()

_cAlias := Alias()
_cOrd   := IndexOrd()
_nReg   := Recno()
_cIni 	:= GetMv("FS_ATFINII")

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
