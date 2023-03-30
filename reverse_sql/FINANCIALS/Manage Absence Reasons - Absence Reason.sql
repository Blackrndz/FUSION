/* ****************************************************************************
 * $Revision: 78239 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 22:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Absence%20Reasons%20-%20Absence%20Reason.sql $:
 * $Id: Manage Absence Reasons - Absence Reason.sql 78239 2022-04-07 15:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT DISTINCT aARTLEO.NAME RES_NAME
,aAREO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,aAREO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,aAREO.CREATED_BY RSC_CREATED_BY
,aAREO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,aAREO.LEGISLATION_CODE RSC_COUNTRY_ID

FROM ANC_ABSENCE_REASONS_F  aAREO
,ANC_ABSENCE_REASONS_VL aARTLEO
WHERE aAREO.ABSENCE_REASON_ID = aARTLEO.ABSENCE_REASON_ID
AND aARTLEO.LANGUAGE = USERENV('LANG')
AND aAREO.EFFECTIVE_START_DATE = aARTLEO.EFFECTIVE_START_DATE
AND SYSDATE BETWEEN aARTLEO.EFFECTIVE_START_DATE AND aARTLEO.EFFECTIVE_END_DATE
ORDER BY aARTLEO.NAME