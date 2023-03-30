/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Reporting%20Currencies%20(Primary%20Ledger)%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Manage Reporting Currencies (Primary Ledger) - Journal Conversion Rules.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT
(SELECT NAME
	FROM GL_LEDGERS
	WHERE LEDGER_ID = GlLedgerRelationships.PRIMARY_LEDGER_ID
	) AS RES_PRIMARY_LEDGER
,GlLedgerRelationships.TARGET_LEDGER_NAME AS RES_NAME
,(SELECT JournalSourceEO.USER_JE_SOURCE_NAME
	FROM GL_JE_SOURCES_VL JournalSourceEO
	WHERE JournalSourceEO.JE_SOURCE_NAME = GlJeInclusionRules.JE_SOURCE_NAME
	) AS RES_JOURNAL_SOURCE
,(SELECT JournalCategoryPEO.USER_JE_CATEGORY_NAME
	FROM GL_JE_CATEGORIES_VL JournalCategoryPEO
	WHERE JournalCategoryPEO.JE_CATEGORY_NAME = GlJeInclusionRules.JE_CATEGORY_NAME
	) AS RES_JOURNAL_CATEGORY
,(SELECT MEANING
	FROM gl_lookups
	WHERE LOOKUP_TYPE = 'YES/NO'
	AND lookup_code   = GlJeInclusionRules.INCLUDE_FLAG
	) AS RES_CONVERT_JOURNALS_TO_THIS_R
,GlJeInclusionRules.LAST_UPDATED_BY AS RSC_LAST_UPDATED_BY
,GlJeInclusionRules.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
,GlJeInclusionRules.CREATED_BY  RSC_CREATED_BY
,GlJeInclusionRules.CREATION_DATE  RSC_CREATION_DATE
,GlLedgerRelationships.PRIMARY_LEDGER_ID RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GL_JE_INCLUSION_RULES GlJeInclusionRules
,GL_LEDGER_RELATIONSHIPS GlLedgerRelationships
WHERE GlJeInclusionRules.JE_RULE_SET_ID = GlLedgerRelationships.GL_JE_CONVERSION_SET_ID
AND GlLedgerRelationships.RELATIONSHIP_TYPE_CODE <> 'BALANCE'
AND GlLedgerRelationships.APPLICATION_ID              = 101
AND GlLedgerRelationships.RELATIONSHIP_TYPE_CODE     != 'NONE'
AND GlLedgerRelationships.TARGET_LEDGER_CATEGORY_CODE = 'ALC'
AND GlLedgerRelationships.SLA_LEDGER_ID not in (select LEDGER_ID from GL_LEDGERS where LEDGER_CATEGORY_CODE = 'SECONDARY')
ORDER BY RES_PRIMARY_LEDGER, RES_NAME, RES_JOURNAL_SOURCE
