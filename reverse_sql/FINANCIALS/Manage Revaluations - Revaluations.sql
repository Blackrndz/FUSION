/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Revaluations%20-%20Revaluations.sql $:
 * $Id: Manage Revaluations - Revaluations.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- FIELD_TO_APPLY_FUNCTION=RES_UNREALIZED_GAIN_ACCOUNT/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_UNREALIZED_LOSS_ACCOUNT/GET_CODE_COMBINATION
 
SELECT glrevaluation.NAME RES_NAME
,glrevaluation.DESCRIPTION RES_DESCRIPTION
,(SELECT NAME
	FROM FND_KF_STR_INSTANCES_VL
	WHERE STRUCTURE_INSTANCE_NUMBER = glrevaluation.CHART_OF_ACCOUNTS_ID
	) RES_CHART_OF_ACCOUNTS
,DECODE(FROM_CURRENCY_CODE,NULL,NULL,FROM_CURRENCY_CODE||' - '||
	(SELECT name
	FROM fnd_currencies_vl
	WHERE currency_code != 'STAT'
	AND currency_code = glrevaluation.FROM_CURRENCY_CODE
	AND enabled_flag = 'Y'
	AND TRUNC(NVL(start_date_active,sysdate)) <= TRUNC(sysdate)
	AND TRUNC(NVL(end_date_active,sysdate)) >= TRUNC(sysdate)
	)) RES_CURRENCY
,(SELECT USER_CONVERSION_TYPE
	FROM GL_DAILY_CONVERSION_TYPES
	WHERE CONVERSION_TYPE = glrevaluation.CONVERSION_RATE_TYPE
	) RES_CONVERSION_RATE_TYPE
,glrevaluation.REVALUATION_RATE RES_CONVERSION_RATE
,glrevaluation.DAYS_TO_ROLL_FORWARD RES_DAYS_TO_ROLL_FORWARD
,glrevaluation.UNREALIZED_GAIN_CCID RES_UNREALIZED_GAIN_ACCOUNT
,glrevaluation.UNREALIZED_LOSS_CCID RES_UNREALIZED_LOSS_ACCOUNT
,INCOME_STMT_ACCOUNTS_RULE RES_INCOME_STATEMENT_ACCOUNTS_
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'YES_NO'
	AND lookup_code   = NVL(glrevaluation.AUTOMATIC_POST_FLAG,'N')
	) AS RES_POST_AUTOMATICALLY
,glrevaluation.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,glrevaluation.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,glrevaluation.CREATED_BY RSC_CREATED_BY
,glrevaluation.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,glrevaluation.CHART_OF_ACCOUNTS_ID RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GL_REVALUATIONS glrevaluation
ORDER BY glrevaluation.NAME