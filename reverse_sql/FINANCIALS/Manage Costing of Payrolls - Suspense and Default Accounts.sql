/* ****************************************************************************
 * $Revision: 56510 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-07-06 09:21:36 +0700 (Wed, 06 Jul 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Locations%20(United%20States)%20-%20Manage%20Locations.sql $:
 * $Id: Manage Locations (United States) - Manage Locations.sql 56510 2016-07-06 02:21:36Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT prsE0.PAYROLL_NAME RES_PAYROLL
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = prsE0.PERIOD_TYPE 
	AND LOOKUP_TYPE = 'PAY_PROC_PERIOD_TYPE' AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_PERIOD_TYPE
,(SELECT FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'PAY'
        ,KEY_FLEX_CODE => (SELECT KEY_FLEXFIELD_CODE FROM FND_KF_STR_INSTANCES_VL WHERE STRUCTURE_INSTANCE_NUMBER= ID_FLEX_NUM)
        ,STRUCTURE_NUMBER => ID_FLEX_NUM
        ,COMBINATION_ID => COST_ALLOCATION_KEYFLEX_ID)
    FROM PAY_COST_ALLOC_ACCOUNTS
    WHERE COST_ALLOCATION_RECORD_ID = costsE0.COST_ALLOCATION_RECORD_ID
    AND SOURCE_SUB_TYPE = 'SUSP'
    ) RES_SUSPENSE_ACCOUNT
,(SELECT FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'PAY'
        ,KEY_FLEX_CODE => (SELECT KEY_FLEXFIELD_CODE FROM FND_KF_STR_INSTANCES_VL WHERE STRUCTURE_INSTANCE_NUMBER= ID_FLEX_NUM)
        ,STRUCTURE_NUMBER => ID_FLEX_NUM
        ,COMBINATION_ID => COST_ALLOCATION_KEYFLEX_ID)
    FROM PAY_COST_ALLOC_ACCOUNTS
    WHERE COST_ALLOCATION_RECORD_ID = costsE0.COST_ALLOCATION_RECORD_ID
    AND SOURCE_SUB_TYPE = 'DFLT'
    ) RES_DEFAULT_ACCOUNT
,costsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,costsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,costsE0.CREATED_BY  RSC_CREATED_BY
,costsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM PAY_ALL_PAYROLLS_F prsE0
,(SELECT *
    FROM PAY_COST_ALLOCATIONS_F
    WHERE SOURCE_TYPE = 'PAY'
    ) costsE0

WHERE prsE0.PAYROLL_ID = costsE0.SOURCE_ID
ORDER BY prsE0.PAYROLL_NAME

