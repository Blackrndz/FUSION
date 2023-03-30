/* ****************************************************************************
 * $Revision: 71719 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2019-03-28 16:15:43 +0700 (Thu, 28 Mar 2019) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Define%20Budget%20Scenarios%20-%20Values.sql $:
 * $Id: Define Budget Scenarios - Values.sql 71719 2019-03-28 09:15:43Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT eleClassesE0.CLASSIFICATION_NAME RES_PRIMARY_CLASSIFICATION
,legislativeGroupsE0.NAME RES_LEGISLATIVE_DATA_GROUP
,eleClassDetailsE0.CLASSIFICATION_NAME RES_NAME
,eleClassDetailsE0.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(eleClassDetailsE0.DATE_FROM,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(eleClassDetailsE0.DATE_TO,'DD-Mon-YYYY') RES_END_DATE
,eleClassesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,eleClassesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,eleClassesE0.CREATED_BY RSC_CREATED_BY
,eleClassesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PAY_ELE_CLASSIFICATIONS_VL eleClassesE0
,(SELECT *
    FROM PAY_ELE_CLASSIFICATIONS_VL
    WHERE PARENT_CLASSIFICATION_ID IS NOT NULL
    AND SECONDARY_CLASSIFICATION_FLAG = 'Y'
    ) eleClassDetailsE0
,PER_LEGISLATIVE_DATA_GROUPS_VL legislativeGroupsE0
WHERE eleClassesE0.PARENT_CLASSIFICATION_ID IS NULL
AND eleClassesE0.LEGISLATION_CODE IS NULL
AND eleClassesE0.LEGISLATIVE_DATA_GROUP_ID IS NULL
AND SYSDATE BETWEEN eleClassesE0.DATE_FROM AND eleClassesE0.DATE_TO
AND eleClassesE0.CLASSIFICATION_ID = eleClassDetailsE0.PARENT_CLASSIFICATION_ID
AND eleClassDetailsE0.LEGISLATIVE_DATA_GROUP_ID = legislativeGroupsE0.LEGISLATIVE_DATA_GROUP_ID
ORDER BY legislativeGroupsE0.NAME
,eleClassesE0.CLASSIFICATION_NAME
,eleClassDetailsE0.CLASSIFICATION_NAME