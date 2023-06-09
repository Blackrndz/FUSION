
/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-01-10  $:
 * $HeadURL: $:
 * $Id: $: Journals Import (Summary)
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- STRICTLY_BATCH_SEQ = RES_PERIOD_NAME,RES_ATTRIBUTE20_VALUE_FOR_JOUR

select distinct 'NEW' RES_STATUS_CODE
,BA.LEDGER_ID RES_LEDGER_ID
,TO_CHAR(DT.END_DATE,'YYYY/MM/DD') RES_EFFECTIVE_DATE_OF_TRANSACT
,NULL RES_JOURNAL_SOURCE
,NULL RES_JOURNAL_CATEGORY
,BA.CURRENCY_CODE RES_CURRENCY_CODE
,TO_CHAR(DT.END_DATE,'YYYY/MM/DD') RES_JOURNAL_ENTRY_CREATION_DAT
,BA.ACTUAL_FLAG RES_ACTUAL_FLAG
,GCC.SEGMENT1 RES_SEGMENT1
,GCC.SEGMENT2 RES_SEGMENT2
,GCC.SEGMENT3 RES_SEGMENT3
,GCC.SEGMENT4 RES_SEGMENT4
,GCC.SEGMENT5 RES_SEGMENT5
,GCC.SEGMENT6 RES_SEGMENT6
,GCC.SEGMENT7 RES_SEGMENT7
,GCC.SEGMENT8 RES_SEGMENT8
,GCC.SEGMENT9 RES_SEGMENT9
,GCC.SEGMENT10 RES_SEGMENT10
,GCC.SEGMENT11 RES_SEGMENT11
,GCC.SEGMENT12 RES_SEGMENT12
,GCC.SEGMENT13 RES_SEGMENT13
,GCC.SEGMENT14 RES_SEGMENT14
,GCC.SEGMENT15 RES_SEGMENT15
,GCC.SEGMENT16 RES_SEGMENT16
,GCC.SEGMENT17 RES_SEGMENT17
,GCC.SEGMENT18 RES_SEGMENT18
,GCC.SEGMENT19 RES_SEGMENT19
,GCC.SEGMENT20 RES_SEGMENT20
,GCC.SEGMENT21 RES_SEGMENT21
,GCC.SEGMENT22 RES_SEGMENT22
,GCC.SEGMENT23 RES_SEGMENT23
,GCC.SEGMENT24 RES_SEGMENT24
,GCC.SEGMENT25 RES_SEGMENT25
,GCC.SEGMENT26 RES_SEGMENT26
,GCC.SEGMENT27 RES_SEGMENT27
,GCC.SEGMENT28 RES_SEGMENT28
,GCC.SEGMENT29 RES_SEGMENT29
,GCC.SEGMENT30 RES_SEGMENT30
,(Case 
	when (BA.PERIOD_NET_DR >= BA.PERIOD_NET_CR) then
		/*(CASE
			WHEN INSTR(TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2)),'.',1,1) = 0 THEN 
				TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2))||'.00'
			WHEN LENGTH(SUBSTR(TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2))	,INSTR(TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2)),'.',1,1)+1	,LENGTH(TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2) ) ) ) ) = 2 THEN
				TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2))
			WHEN LENGTH(SUBSTR(TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2)),INSTR(TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2)),'.',1,1)+1,LENGTH(TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2))))) = 1 THEN
				(CASE
					WHEN ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2) = 0 THEN '0.00'
					ELSE TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2))||'0'
				END)
			WHEN TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2)) IS NULL THEN
				NULL
			ELSE
				TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2))||'.00'
			END)*/
		TO_CHAR(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR)
	else
		'0.00'
	end) RES_ENTERED_DEBIT_AMOUNT
,(Case 
	when (BA.PERIOD_NET_CR >= BA.PERIOD_NET_DR ) then
		/*(CASE
			WHEN INSTR(TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2)),'.',1,1) = 0 THEN 
				TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2))||'.00'
			WHEN LENGTH(SUBSTR(TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2))	,INSTR(TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2)),'.',1,1)+1	,LENGTH(TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2) ) ) ) ) = 2 THEN
				TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2))
			WHEN LENGTH(SUBSTR(TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2)),INSTR(TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2)),'.',1,1)+1,LENGTH(TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2))))) = 1 THEN
				(CASE
					WHEN ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2) = 0 THEN '0.00'
					ELSE TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2))||'0'
				END)
			WHEN TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2)) IS NULL THEN
				NULL
			ELSE
				TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2))||'.00'
			END)*/
		TO_CHAR(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR)
	else
		'0.00'
	end) RES_ENTERED_CREDIT_AMOUNT
,(Case 
	when (BA.PERIOD_NET_DR >= BA.PERIOD_NET_CR) then
		/*(CASE
			WHEN INSTR(TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2)),'.',1,1) = 0 THEN 
				TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2))||'.00'
			WHEN LENGTH(SUBSTR(TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2))	,INSTR(TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2)),'.',1,1)+1	,LENGTH(TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2) ) ) ) ) = 2 THEN
				TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2))
			WHEN LENGTH(SUBSTR(TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2)),INSTR(TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2)),'.',1,1)+1,LENGTH(TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2))))) = 1 THEN
				(CASE
					WHEN ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2) = 0 THEN '0.00'
					ELSE TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2))||'0'
				END)
			WHEN TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2)) IS NULL THEN
				NULL
			ELSE
				TO_CHAR(ROUND(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR,2))||'.00'
			END)*/
		TO_CHAR(BA.PERIOD_NET_DR - BA.PERIOD_NET_CR)
	else
		'0.00'
	end) RES_CONVERTED_DEBIT_AMOUNT
,(Case 
	when (BA.PERIOD_NET_CR >= BA.PERIOD_NET_DR ) then
		/*(CASE
			WHEN INSTR(TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2)),'.',1,1) = 0 THEN 
				TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2))||'.00'
			WHEN LENGTH(SUBSTR(TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2))	,INSTR(TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2)),'.',1,1)+1	,LENGTH(TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2) ) ) ) ) = 2 THEN
				TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2))
			WHEN LENGTH(SUBSTR(TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2)),INSTR(TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2)),'.',1,1)+1,LENGTH(TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2))))) = 1 THEN
				(CASE
					WHEN ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2) = 0 THEN '0.00'
					ELSE TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2))||'0'
				END)
			WHEN TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2)) IS NULL THEN
				NULL
			ELSE
				TO_CHAR(ROUND(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR,2))||'.00'
			END)*/
		TO_CHAR(BA.PERIOD_NET_CR - BA.PERIOD_NET_DR)
	else
		'0.00'
	end) RES_CONVERTED_CREDIT_AMOUNT
,NULL RES_REFERENCE1_BATCH_NAME
,NULL RES_REFERENCE2_BATCH_DESCRIPTI
,NULL RES_REFERENCE3
,NULL RES_REFERENCE4_JOURNAL_ENTRY_N
,NULL RES_REFERENCE5_JOURNAL_ENTRY_D
,NULL RES_REFERENCE6_JOURNAL_ENTRY_R
,NULL RES_REFERENCE7_JOURNAL_ENTRY_R
,NULL RES_REFERENCE8_JOURNAL_ENTRY_R
,NULL RES_REFERENCE9_JOURNAL_REVERSA
,NULL RES_REFERENCE10_JOURNAL_ENTRY_
,NULL RES_REFERENCE_COLUMN_1
,NULL RES_REFERENCE_COLUMN_2
,NULL RES_REFERENCE_COLUMN_3
,NULL RES_REFERENCE_COLUMN_4
,NULL RES_REFERENCE_COLUMN_5
,NULL RES_REFERENCE_COLUMN_6
,NULL RES_REFERENCE_COLUMN_7
,NULL RES_REFERENCE_COLUMN_8
,NULL RES_REFERENCE_COLUMN_9
,NULL RES_REFERENCE_COLUMN_10
,NULL RES_STATISTICAL_AMOUNT
,NULL RES_CURRENCY_CONVERSION_TYPE
,NULL RES_CURRENCY_CONVERSION_DATE
,NULL RES_CURRENCY_CONVERSION_RATE
,'999' RES_INTERFACE_GROUP_IDENTIFIER
,NULL RES_CONTEXT_FIELD_FOR_JOURNAL_
,NULL RES_ATTRIBUTE1_VALUE_FOR_JOURN
,NULL RES_ATTRIBUTE2_VALUE_FOR_JOURN
,NULL RES_ATTRIBUTE3_VALUE_FOR_JOURN
,NULL RES_ATTRIBUTE4_VALUE_FOR_JOURN
,NULL RES_ATTRIBUTE5_VALUE_FOR_JOURN
,NULL RES_ATTRIBUTE6_VALUE_FOR_JOURN
,NULL RES_ATTRIBUTE7_VALUE_FOR_JOURN
,NULL RES_ATTRIBUTE8_VALUE_FOR_JOURN
,NULL RES_ATTRIBUTE9_VALUE_FOR_JOURN
,NULL RES_ATTRIBUTE10_VALUE_FOR_JOUR
,NULL RES_ATTRIBUTE11_VALUE_FOR_JOUR
,NULL RES_ATTRIBUTE12_VALUE_FOR_JOUR
,NULL RES_ATTRIBUTE13_VALUE_FOR_JOUR
,NULL RES_ATTRIBUTE14_VALUE_FOR_JOUR
,NULL RES_ATTRIBUTE15_VALUE_FOR_JOUR
,NULL RES_ATTRIBUTE16_VALUE_FOR_JOUR
,NULL RES_ATTRIBUTE17_VALUE_FOR_JOUR
,NULL RES_ATTRIBUTE18_VALUE_FOR_JOUR
,NULL RES_ATTRIBUTE19_VALUE_FOR_JOUR
,BA.CODE_COMBINATION_ID RES_ATTRIBUTE20_VALUE_FOR_JOUR
,NULL RES_CONTEXT_FIELD_FOR_CAPTURED
,NULL RES_AVERAGE_JOURNAL_FLAG
,NULL RES_CLEARING_COMPANY
,(SELECT NAME 
	FROM GL_LEDGERS 
	WHERE LEDGER_ID = BA.LEDGER_ID 
	) RES_LEDGER_NAME
,BA.ENCUMBRANCE_TYPE_ID RES_ENCUMBRANCE_TYPE_ID
,NULL RES_RECONCILIATION_REFERENCE
,DT.PERIOD_NAME RES_PERIOD_NAME
,NULL RES_ADDITIONAL_INFORMATION
,BA.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,BA.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,'R4C'  RSC_CREATED_BY
,DT.START_DATE  RSC_CREATION_DATE
,PGL.PRIMARY_LEDGER_ID RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from GL_BALANCES BA
,gl_code_combinations  GCC
,(select Distinct LEDGER_ID
	,GL.PERIOD_SET_NAME
	,GL.START_DATE 
	,GL.END_DATE
	,GL.PERIOD_NAME
	,GL.ADJUSTMENT_PERIOD_FLAG
	FROM GL_LEDGERS SS
	,GL_PERIODS GL
	where SS.PERIOD_SET_NAME = GL.PERIOD_SET_NAME
    ) DT
,GL_LEDGERS SE
,(select RSHIP.TARGET_LEDGER_ID, RSHIP.PRIMARY_LEDGER_ID from GL_LEDGER_RELATIONSHIPS RSHIP
	WHERE (RSHIP.RELATIONSHIP_TYPE_CODE <> 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'SECONDARY')
	OR (RSHIP.RELATIONSHIP_TYPE_CODE = 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'PRIMARY')) PGL
where  BA.LEDGER_ID  = DT.LEDGER_ID
and BA.PERIOD_NAME   = DT.PERIOD_NAME
and BA.ACTUAL_FLAG = 'A'
and GCC.DETAIL_POSTING_ALLOWED_FLAG = 'Y'
and SE.LEDGER_ID =  BA.LEDGER_ID 
and SE.CURRENCY_CODE   = BA.CURRENCY_CODE
and BA.CODE_COMBINATION_ID = GCC.CODE_COMBINATION_ID
and (BA.PERIOD_NET_DR <> BA.PERIOD_NET_CR)
AND BA.LEDGER_ID = PGL.TARGET_LEDGER_ID(+)