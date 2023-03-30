/* ****************************************************************************
 * $Revision:  $:
 * $Author:  $:
 * $Date:  $:
 * $HeadURL:  $:
 * $Id:  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 SELECT 
 	(SELECT NAME
	FROM GL_LEDGERS
	WHERE LEDGER_ID = GlLedgerRelationships.PRIMARY_LEDGER_ID
	) AS RES_PRIMARY_LEDGER
 ,GlLedgerRelationships.TARGET_LEDGER_NAME AS RES_NAME
 ,(SELECT meaning
	FROM GL_LOOKUPS
	WHERE LOOKUP_TYPE = 'GL_ASF_ALC_RELATIONSHIP_LEVEL'
	AND LOOKUP_CODE   = GlLedgerRelationships.RELATIONSHIP_TYPE_CODE
	) AS RES_CURRENCY_CONVERSION_LEVEL
 ,(GlLedgerRelationships.TARGET_CURRENCY_CODE || ' - ' || (select NAME from fnd_currencies_vl where CURRENCY_CODE = GlLedgerRelationships.TARGET_CURRENCY_CODE)) AS RES_CURRENCY
 ,DECODE(GlLedgerRelationships.RELATIONSHIP_TYPE_CODE,'BALANCE',(SELECT USER_CONVERSION_TYPE
	FROM GL_DAILY_CONVERSION_TYPES
	WHERE CONVERSION_TYPE = GlLedgerRelationships.ALC_PERIOD_AVERAGE_RATE_TYPE
	),null) AS RES_PERIOD_AVERAGE_RATE_TYPE
,DECODE(GlLedgerRelationships.RELATIONSHIP_TYPE_CODE,'BALANCE',(SELECT USER_CONVERSION_TYPE
	FROM GL_DAILY_CONVERSION_TYPES
	WHERE CONVERSION_TYPE = GlLedgerRelationships.ALC_PERIOD_END_RATE_TYPE
	),null) AS RES_PERIOD_END_RATE_TYPE 
,DECODE(GlLedgerRelationships.RELATIONSHIP_TYPE_CODE,'BALANCE',(SELECT MEANING
	FROM gl_lookups
	WHERE LOOKUP_TYPE = 'GL_ASF_OWN_EQ_XLAT_RULE'
	AND lookup_code   = GlLedgerRelationships.REV_EXP_XLATION_RULE_CODE
	),null) AS RES_REVENUE_AND_EXPENSE_TRANSL 
,DECODE(GlLedgerRelationships.RELATIONSHIP_TYPE_CODE,'BALANCE',(SELECT MEANING
	FROM gl_lookups
	WHERE LOOKUP_TYPE = 'GL_ASF_OWN_EQ_XLAT_RULE'
	AND lookup_code   = GlLedgerRelationships.OE_XLATION_RULE_CODE
	),null) AS RES_OWNERS_EQUITY_TRANSLATION_
,GlLedgerRelationships.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,GlLedgerRelationships.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,GlLedgerRelationships.CREATED_BY  RSC_CREATED_BY
,GlLedgerRelationships.CREATION_DATE  RSC_CREATION_DATE
,GlLedgerRelationships.PRIMARY_LEDGER_ID RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GL_LEDGER_RELATIONSHIPS GlLedgerRelationships
,GL_LEDGERS GlLedgers
WHERE GlLedgers.LEDGER_ID                             = GlLedgerRelationships.TARGET_LEDGER_ID
AND GlLedgerRelationships.APPLICATION_ID              = 101
AND GlLedgerRelationships.RELATIONSHIP_TYPE_CODE     != 'NONE'
AND GlLedgerRelationships.TARGET_LEDGER_CATEGORY_CODE = 'ALC'
AND GlLedgerRelationships.RELATIONSHIP_TYPE_CODE = 'BALANCE'
AND GlLedgerRelationships.SLA_LEDGER_ID not in (select LEDGER_ID from GL_LEDGERS where LEDGER_CATEGORY_CODE = 'SECONDARY')
ORDER BY RES_PRIMARY_LEDGER