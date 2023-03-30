/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20Journal%20Reversal%20Criteria%20Sets%20-%20Journal%20Reversal%20Criteria.sql $:
* $Id: Manage Journal Reversal Criteria Sets - Journal Reversal Criteria.sql 53543 2016-03-15 08:46:40Z
pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

select AUTOREVCRITERIASETEO.CRITERIA_SET_NAME as RES_NAME
,(SELECT USER_JE_CATEGORY_NAME
	FROM GL_JE_CATEGORIES
	WHERE JE_CATEGORY_NAME = glautoreverseop.JE_CATEGORY_NAME
	) as RES_CATEGORY
,(SELECT MEANING
	FROM GL_LOOKUPS
	WHERE LOOKUP_TYPE = 'AUTOREVERSE_REVERSAL_PERIOD'
	AND lookup_code   = glautoreverseop.REVERSAL_PERIOD_CODE
	) as RES_REVERSAL_PERIOD
,(SELECT MEANING
	FROM GL_LOOKUPS
	WHERE LOOKUP_TYPE = 'AUTOREVERSE_DATE_RULE'
	AND lookup_code   = glautoreverseop.REVERSAL_DATE_CODE
	)                                                                              as RES_REVERSAL_DATE
,DECODE(glautoreverseop.METHOD_CODE,'C','Change sign','Switch Debit or Credit') AS RES_REVERSAL_METHOD
,DECODE(glautoreverseop.AUTOREVERSE_FLAG,'Y',DECODE(glautoreverseop.AUTOPOST_REVERSAL_FLAG,'N','Reverse Automatically',
	'Reverse and Post Automatically'),'None') AS RES_AUTOMATIC_REVERSAL_OPTION
,glautoreverseop.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,glautoreverseop.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,glautoreverseop.CREATED_BY RSC_CREATED_BY
,glautoreverseop.CREATION_DATE RSC_CREATION_DATE
,LedgersE0.LEDGER_ID RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GL_AUTOREVERSE_OPTIONS glautoreverseop
,GL_AUTOREV_CRITERIA_SETS AutorevCriteriaSetEO
,GL_LEDGERS LedgersE0
WHERE AutorevCriteriaSetEO.CRITERIA_SET_ID = LedgersE0.CRITERIA_SET_ID(+)
AND GLAUTOREVERSEOP.CRITERIA_SET_ID = AUTOREVCRITERIASETEO.CRITERIA_SET_ID
and glautoreverseop.JE_CATEGORY_NAME not in 
(SELECT GLAUTOREVERSEOP2.JE_CATEGORY_NAME
	FROM GL_AUTOREVERSE_OPTIONS GLAUTOREVERSEOP2
	WHERE glautoreverseop2.CRITERIA_SET_ID     = glautoreverseop.CRITERIA_SET_ID
	AND((GLAUTOREVERSEOP2.REVERSAL_PERIOD_CODE = 'NO_DEFAULT'
	AND GLAUTOREVERSEOP2.REVERSAL_DATE_CODE   IS NULL
	AND GLAUTOREVERSEOP2.METHOD_CODE           = 'S')
	OR(GLAUTOREVERSEOP2.JE_CATEGORY_NAME       = 'Balance Sheet Close'
	AND GLAUTOREVERSEOP2.REVERSAL_PERIOD_CODE  = 'NEXT_PERIOD'
	AND GLAUTOREVERSEOP2.REVERSAL_DATE_CODE    = 'FIRST_DAY'
	AND GLAUTOREVERSEOP2.METHOD_CODE           = 'S')
	OR(GLAUTOREVERSEOP2.JE_CATEGORY_NAME       = 'Income Statement Close'
	AND GLAUTOREVERSEOP2.REVERSAL_PERIOD_CODE  = 'SAME_PERIOD'
	AND GLAUTOREVERSEOP2.REVERSAL_DATE_CODE    = 'LAST_DAY'
	AND GLAUTOREVERSEOP2.METHOD_CODE           = 'C')
	OR(GLAUTOREVERSEOP2.JE_CATEGORY_NAME       = 'MRC Open Balances'
	AND GLAUTOREVERSEOP2.REVERSAL_PERIOD_CODE  = 'NO_DEFAULT'
	AND GLAUTOREVERSEOP2.REVERSAL_DATE_CODE   IS NULL
	AND GLAUTOREVERSEOP2.METHOD_CODE           = 'C')
	OR(GLAUTOREVERSEOP2.JE_CATEGORY_NAME       = 'Revalue Profit/Loss'
	AND GLAUTOREVERSEOP2.REVERSAL_PERIOD_CODE  = 'NO_DEFAULT'
	AND GLAUTOREVERSEOP2.REVERSAL_DATE_CODE   IS NULL
	and GLAUTOREVERSEOP2.METHOD_CODE           = 'C'))
)
ORDER BY RES_NAME

/*Add GL_LEDGERS table to the query due to consultant need to change this query to Ledger level for filter.
Please note that this condition might cause duplication data when extract it with out Bu filter.*/