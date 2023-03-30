/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Costing%20of%20Departments%20-%20Costing%20of%20Departments.sql $:
 * $Id: Manage Costing of Departments - Costing of Departments.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT orgsE0.NAME RES_DEPARTMENT
,orgsE0.SET_NAME RES_DEPARTMENT_SET
,orgsE0.LOCATION_NAME RES_LOCATION
,(SELECT NAME
    FROM PER_LEGISLATIVE_DATA_GROUPS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND LEGISLATIVE_DATA_GROUP_ID = costAllocationsE0.LEGISLATIVE_DATA_GROUP_ID
    ) RES_LEGISLATIVE_DATA_GROUP
,TO_CHAR(costAllocationsE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(costAllocationsE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE

,costAllocationsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,costAllocationsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,costAllocationsE0.CREATED_BY RSC_CREATED_BY
,costAllocationsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM PAY_COST_ALLOCATIONS_F costAllocationsE0
,(SELECT DISTINCT deptsE0.NAME
    ,deptsE0.ORGANIZATION_ID
	,perLOCE0.LOCATION_NAME 
	,SetIdSetPEO.SET_NAME     
	FROM HR_ALL_ORGANIZATION_UNITS_VL deptsE0 
    ,HR_ORG_UNIT_CLASSIFICATIONS_F classesE0
	,FND_SETID_SETS_VL SetIdSetPEO
	,PER_LOCATION_DETAILS_F_VL perLOCE0
    WHERE deptsE0.ORGANIZATION_ID = classesE0.ORGANIZATION_ID
    AND classesE0.CLASSIFICATION_CODE = 'DEPARTMENT'
	AND classesE0.SET_ID = SetIdSetPEO.SET_ID(+)
	AND deptsE0.LOCATION_ID = perLOCE0.LOCATION_ID(+)
    AND SYSDATE BETWEEN deptsE0.EFFECTIVE_START_DATE AND deptsE0.EFFECTIVE_END_DATE
    AND SYSDATE BETWEEN classesE0.EFFECTIVE_START_DATE AND classesE0.EFFECTIVE_END_DATE
    ) orgsE0
WHERE costAllocationsE0.SOURCE_TYPE = 'ORG'
AND costAllocationsE0.SOURCE_ID = orgsE0.ORGANIZATION_ID
ORDER BY orgsE0.NAME

