/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Time%20Definitions%20-%20Usages.sql $:
 * $Id: Manage Time Definitions - Usages.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT payTIMEEO.DEFINITION_NAME RES_NAME
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = payTIMEUSAGEO.USAGE_TYPE 
			AND LOOKUP_TYPE = 'PAY_TIME_SPAN_USAGES' AND LANGUAGE = USERENV('LANG')
			AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE ,TO_DATE('31-12-4712','DD-MM-YYYY'))) RES_SELECTED


,payTIMEUSAGEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,payTIMEUSAGEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,payTIMEUSAGEO.CREATED_BY RSC_CREATED_BY
,payTIMEUSAGEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PAY_TIME_DEFINITIONS payTIMEEO
,PAY_TIME_DEF_USAGES payTIMEUSAGEO
WHERE payTIMEEO.TIME_DEFINITION_ID = payTIMEUSAGEO.TIME_DEFINITION_ID
ORDER BY RES_NAME,RES_SELECTED