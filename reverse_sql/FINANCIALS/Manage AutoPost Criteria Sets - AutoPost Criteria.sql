/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoPost%20Criteria%20Sets%20-%20AutoPost%20Criteria.sql $:
 * $Id: Manage AutoPost Criteria Sets - AutoPost Criteria.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


select QRSLT.AUTOPOST_SET_NAME  RES_NAME
,QRSLT.POSTING_PRIORITY RES_PRIORITY
,QRSLT.LEDGER_NAME RES_LEDGER_OR_LEDGER_SET
,QRSLT.USER_JE_SOURCE_NAME RES_SOURCE
,QRSLT.TRANSCATEGORYNAME RES_CATEGORY
,QRSLT.DisplayPeriodName RES_ACCOUNTING_PERIOD
,QRSLT.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY  RSC_CREATED_BY
,QRSLT.CREATION_DATE  RSC_CREATION_DATE
,PGL.PRIMARY_LEDGER_ID RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from 
(select GLAUTOMATICPOSTINGSETS.AUTOPOST_SET_NAME
,GlAutomaticPostingOptions.POSTING_PRIORITY
,SourceAutoPostAllEO.USER_JE_SOURCE_NAME
,GlAutomaticPostingOptions.LAST_UPDATE_DATE
,GlAutomaticPostingOptions.LAST_UPDATED_BY
,GlAutomaticPostingOptions.CREATED_BY
,GlAutomaticPostingOptions.CREATION_DATE
,GlAutomaticPostingOptions.LEDGER_ID
,LedgerAllEO.LEDGER_NAME
,(CategoryAutoPostAllEO.USER_JE_CATEGORY_NAME) AS TransCategoryName
,(PeriodAllEO.PERIOD_NAME_DISPLAY) AS DisplayPeriodName
from GL_AUTOMATIC_POSTING_SETS GLAUTOMATICPOSTINGSETS
,GL_AUTOMATIC_POSTING_OPTIONS GlAutomaticPostingOptions
,GL_LEDGERS_ALL_V LedgerAllEO
,GL_JE_CATEGORIES_AUTOPOST_V CategoryAutoPostAllEO
,GL_JE_SOURCES_AUTOPOST_V SourceAutoPostAllEO
,GL_PERIODS_AUTOPOST_V PeriodAllEO
WHERE((GlAutomaticPostingOptions.LEDGER_ID     = LedgerAllEO.LEDGER_ID)
AND(GlAutomaticPostingOptions.JE_CATEGORY_NAME = CategoryAutoPostAllEO.JE_CATEGORY_NAME)
AND(GlAutomaticPostingOptions.JE_SOURCE_NAME   = SourceAutoPostAllEO.JE_SOURCE_NAME)
AND(GlAutomaticPostingOptions.PERIOD_NAME      = PeriodAllEO.PERIOD_NAME)
AND((LedgerAllEO.PERIOD_SET_NAME               = PeriodAllEO.PERIOD_SET_NAME
AND LedgerAllEO.ACCOUNTED_PERIOD_TYPE          = PeriodAllEO.PERIOD_TYPE)
or(PERIODALLEO.PERIOD_NAME                     = 'ALL')))
and GLAUTOMATICPOSTINGSETS.AUTOPOST_SET_ID	  = GLAUTOMATICPOSTINGOPTIONS.AUTOPOST_SET_ID
) QRSLT
,(select RSHIP.TARGET_LEDGER_ID, RSHIP.PRIMARY_LEDGER_ID from GL_LEDGER_RELATIONSHIPS RSHIP
	WHERE (RSHIP.RELATIONSHIP_TYPE_CODE <> 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'SECONDARY')
	OR (RSHIP.RELATIONSHIP_TYPE_CODE = 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'PRIMARY')) PGL
WHERE QRSLT.LEDGER_ID = PGL.TARGET_LEDGER_ID(+)
order by QRSLT.AUTOPOST_SET_NAME