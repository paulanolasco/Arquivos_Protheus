#include "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
�����������������������������������������������������������������������������
���Programa  � MATFG001  � Autor � Elis�ngela Souza   �Criado� Abr/2019   ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Gatilho para criacao da sequencia do codigo inteligente de ���
���produto     bem do ativo                                               ���
�������������������������������������������������������������������������Ĵ��
���Uso       � SIGAATF                                                    ���
��������������������������������������������������������������������������ٱ�
���Arquivos Relacionados� SN1                                             ���
�����������������������������������������������������������������������������
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