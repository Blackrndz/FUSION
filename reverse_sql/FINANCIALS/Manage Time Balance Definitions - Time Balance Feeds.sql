/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT timeBalDefsE0.BALANCE_NAME RES_NAME
,timeCatsE0.TCAT_NAME RES_TIME_CATEGORY_NAME
,timeCatsE0.DESCRIPTION RES_DESCRIPTION
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'PAY_ADD_SUBTRACT'
	AND LOOKUP_CODE = feedsE0.SCALE 
	) RES_ADD_OR_SUBTRACT
,TO_CHAR(feedsE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,DECODE(TO_CHAR(feedsE0.EFFECTIVE_END_DATE,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(feedsE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_EFFECTIVE_END_DATE
,feedsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,feedsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,feedsE0.CREATED_BY RSC_CREATED_BY
,feedsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,timeBalDefsE0.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PAY_BALANCE_TYPES_VL timeBalDefsE0
,PAY_BALANCE_FEEDS_F feedsE0
,HWM_TCATS_VL timeCatsE0
WHERE timeBalDefsE0.APPLICATION_ID = 10446
AND timeBalDefsE0.BALANCE_TYPE_ID = feedsE0.BALANCE_TYPE_ID
AND feedsE0.SOURCE_ID = timeCatsE0.TCAT_ID 
ORDER BY timeBalDefsE0.BALANCE_NAME
,timeCatsE0.TCAT_NAME