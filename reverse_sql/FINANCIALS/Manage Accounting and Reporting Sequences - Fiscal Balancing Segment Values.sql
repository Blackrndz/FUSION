/* ****************************************************************************
 * $Revision: 80520 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2023-03-22 16:06:27 +0700 (Wed, 22 Mar 2023) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Accounting%20and%20Reporting%20Sequences%20-%20Fiscal%20Balancing%20Segment%20Values.sql $:
 * $Id: Manage Accounting and Reporting Sequences - Fiscal Balancing Segment Values.sql 80520 2023-03-22 09:06:27Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT GlLedgers.name AS RES_LEDGER,
LedgerLePEO.LEGAL_ENTITY_NAME AS RES_LEGAL_ENTITY,
(SELECT DISTINCT GLUP.MEANING
	FROM GL_LOOKUPS GLUP
	WHERE GLUP.LOOKUP_TYPE         = 'FUN_SEQ_JRNL_ENTRY_TYPE'
	AND((FunSeqContexts.TABLE_NAME = 'GL_JE_HEADERS'
	AND GLUP.LOOKUP_CODE           = 'GENERAL_LEDGER')
	OR(FunSeqContexts.TABLE_NAME   = 'XLA_AE_HEADERS'
	AND GLUP.LOOKUP_CODE           = 'SUBLEDGER'))
	) AS RES_JOURNAL_ENTRY_TYPE
,(SELECT DISTINCT GLLookupEO3.MEANING
	FROM FUN_SEQ_RULES FunSeqRules3
	,GL_LOOKUPS GLLookupEO3
	WHERE FunSeqRules3.EVENT_CODE = GLLookupEO3.LOOKUP_CODE
	AND FunSeqRules3.EVENT_CODE   = FunSeqContexts.EVENT_CODE
	AND GLLookupEO3.LOOKUP_TYPE   = 'FUN_SEQ_EVENT'
	) AS RES_SEQUENCING_EVENT
,GlLedgerNormSegVals.SEGMENT_VALUE AS RES_SEGMENT_VALUE
,FndVSValuesVl.DESCRIPTION AS RES_DESCRIPTION
,NVL((select meaning 
	from fnd_lookups 
	where lookup_type = 'YES_NO' 
	and lookup_code = GlLedgerNormSegVals.SLA_SEQUENCING_FLAG)
	,'No') AS RES_FISCAL
,GlLedgerNormSegVals.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,GlLedgerNormSegVals.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,GlLedgerNormSegVals.CREATED_BY  RSC_CREATED_BY
,GlLedgerNormSegVals.CREATION_DATE  RSC_CREATION_DATE
,PGL.PRIMARY_LEDGER_ID RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
FROM GL_LEDGER_NORM_SEG_VALS GlLedgerNormSegVals
,GL_LEDGERS GlLedgers
,FUN_SEQ_CONTEXTS FunSeqContexts
,FND_VS_VALUES_VL FndVSValuesVl
,GL_LEDGER_LE_V LedgerLePEO
,(SELECT DISTINCT RSHIP.TARGET_LEDGER_ID
	,RSHIP.PRIMARY_LEDGER_ID 
	FROM GL_LEDGER_RELATIONSHIPS RSHIP
	WHERE (RSHIP.RELATIONSHIP_TYPE_CODE <> 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'SECONDARY')
	OR (RSHIP.RELATIONSHIP_TYPE_CODE = 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'PRIMARY')
	OR (RSHIP.RELATIONSHIP_TYPE_CODE <> 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'ALC')
	) PGL
WHERE GlLedgerNormSegVals.LEDGER_ID = GlLedgers.LEDGER_ID
AND GlLedgers.BAL_SEG_VALUE_SET_ID = FndVSValuesVl.VALUE_SET_ID
AND GlLedgerNormSegVals.SEGMENT_VALUE = FndVSValuesVl.VALUE
AND FunSeqContexts.CONTEXT_VALUE  = GlLedgers.LEDGER_ID(+)
AND FunSeqContexts.TABLE_NAME       > 'FUN_TRX_BATCHES'
AND FunSeqContexts.CONTEXT_TYPE     > 'INTERCOMPANY_BATCH_SOURCE'
AND FunSeqContexts.EVENT_CODE = 'PERIOD_CLOSE'
AND FunSeqContexts.LEGAL_ENTITY_ID = LedgerLePEO.LEGAL_ENTITY_ID(+)
AND FunSeqContexts.CONTEXT_VALUE    = LedgerLePEO.LEDGER_ID(+)
AND GlLedgers.LEDGER_ID = PGL.TARGET_LEDGER_ID(+)
ORDER BY RES_LEDGER
,RES_JOURNAL_ENTRY_TYPE
,RES_SEGMENT_VALUE