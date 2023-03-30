/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Specify%20Cash%20Positioning%20and%20Forecasting%20Options%20-%20Specify%20Cash%20Positioning%20and%20Forecasting%20Options.sql $:
 * $Id: Specify Cash Positioning and Forecasting Options - Specify Cash Positioning and Forecasting Options.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=CE_CP_OPTIONS

SELECT DECODE(OptionE0.EXTRACTION_DURATION,'ORA_LAST_3_MONTH','Last 3 months','ORA_LAST_6_MONTH','Last 6 months',
	'ORA_LAST_1_YEAR','Last 1 years','ORA_LAST_2_YEAR','Last 2 years','ORA_LAST_3_YEAR','Last 3 years')
	RES_EXTRACTION_DURATION
,OptionE0.REPORTING_CURRENCY||' - '||
	(SELECT NAME
	FROM FND_CURRENCIES_VL
	WHERE CURRENCY_CODE = OptionE0.REPORTING_CURRENCY
	) RES_REPORTING_CURRENCY
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'CE_INTERNAL_BALANCE_CODES'
	AND LOOKUP_CODE   = BALANCE_CODE
	) RES_BALANCE_CODE
,OptionE0.BALANCE_DATE_THRESHOLD RES_BALANCE_DATE_THRESHOLD_DAY
,(SELECT NAME FROM GL_TRANSACTION_CALENDAR WHERE TRANSACTION_CALENDAR_ID  = OptionE0.DEFAULT_TRANSACTION_CALENDAR) RES_DEFAULT_TRANSACTION_CALEND
,OptionE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,OptionE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,OptionE0.CREATED_BY RSC_CREATED_BY
,OptionE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CE_CP_OPTIONS OptionE0