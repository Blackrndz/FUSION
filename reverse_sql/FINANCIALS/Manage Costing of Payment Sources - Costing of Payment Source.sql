/* ****************************************************************************
 * $Revision: 56510 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-07-06 09:21:36 +0700 (Wed, 06 Jul 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Locations%20(United%20States)%20-%20Manage%20Locations.sql $:
 * $Id: Manage Locations (United States) - Manage Locations.sql 56510 2016-07-06 02:21:36Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT pmsE0.BASE_ORG_PAY_METHOD_NAME RES_PAYMENT_SOURCE_NAME
,leGISTATIONE0.NAME RES_LEGISLATIVE_DATA_GROUP
,TO_CHAR(costsE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,(SELECT PAYMENT_TYPE_NAME FROM PAY_PAYMENT_TYPES_VL WHERE BASE_PAYMENT_TYPE_ID = pmsE0.PAYMENT_TYPE_ID 
	AND LEGISLATION_CODE = leGISTATIONE0.LEGISLATION_CODE) RES_PAYMENT_TYPE
,TO_CHAR(costsE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,DECODE(costInfosE0.COSTED_FLAG,'Y','Yes','No') RES_COST_PAYMENTS
,DECODE(costInfosE0.COST_CLEARED_PAYMENT,'Y','Yes','No') RES_COST_CLEARED_PAYMENTS
,DECODE(costInfosE0.COST_MANUAL_PAYMENT,'Y','Yes','No') RES_COST_EXTERNAL_PAYMENTS
,DECODE(costInfosE0.TRANSFER_TO_GL_FLAG,'Y','Yes','No') RES_TRANSFER_TO_GENERAL_LEDGER
,(SELECT FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'PAY'
        ,KEY_FLEX_CODE => (SELECT KEY_FLEXFIELD_CODE FROM FND_KF_STR_INSTANCES_VL WHERE STRUCTURE_INSTANCE_NUMBER= ID_FLEX_NUM)
        ,STRUCTURE_NUMBER => ID_FLEX_NUM
        ,COMBINATION_ID => COST_ALLOCATION_KEYFLEX_ID)
    FROM PAY_COST_ALLOC_ACCOUNTS
    WHERE COST_ALLOCATION_RECORD_ID = costsE0.COST_ALLOCATION_RECORD_ID
    AND SOURCE_SUB_TYPE = 'CASH'
    ) RES_CASH_ACCOUNT_NUMBER
,(SELECT FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'PAY'
        ,KEY_FLEX_CODE => (SELECT KEY_FLEXFIELD_CODE FROM FND_KF_STR_INSTANCES_VL WHERE STRUCTURE_INSTANCE_NUMBER= ID_FLEX_NUM)
        ,STRUCTURE_NUMBER => ID_FLEX_NUM
        ,COMBINATION_ID => COST_ALLOCATION_KEYFLEX_ID)
    FROM PAY_COST_ALLOC_ACCOUNTS
    WHERE COST_ALLOCATION_RECORD_ID = costsE0.COST_ALLOCATION_RECORD_ID
    AND SOURCE_SUB_TYPE = 'CLRNG'
    ) RES_CASH_CLEARING_ACCOUNT_NUMB
,(SELECT FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'PAY'
        ,KEY_FLEX_CODE => (SELECT KEY_FLEXFIELD_CODE FROM FND_KF_STR_INSTANCES_VL WHERE STRUCTURE_INSTANCE_NUMBER= ID_FLEX_NUM)
        ,STRUCTURE_NUMBER => ID_FLEX_NUM
        ,COMBINATION_ID => COST_ALLOCATION_KEYFLEX_ID)
    FROM PAY_COST_ALLOC_ACCOUNTS
    WHERE COST_ALLOCATION_RECORD_ID = costsE0.COST_ALLOCATION_RECORD_ID
    AND SOURCE_SUB_TYPE = 'LBLTY'
    ) RES_LIABILITY_ACCOUNT_NUMBER

,costInfosE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,costInfosE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,costInfosE0.CREATED_BY RSC_CREATED_BY
,costInfosE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID



FROM PAY_ORG_PAY_METHODS_F pmsE0
,(SELECT *
    FROM PAY_COST_ALLOCATIONS_F
    WHERE SOURCE_TYPE = 'PM'
    ) costsE0
,(SELECT *
    FROM PAY_COST_INFO_F
    WHERE SOURCE_TYPE = 'PM'
    ) costInfosE0
,(SELECT NAME,LEGISLATIVE_DATA_GROUP_ID,LEGISLATION_CODE
    FROM PER_LEGISLATIVE_DATA_GROUPS_VL
    ) leGISTATIONE0

WHERE pmsE0.ORG_PAYMENT_METHOD_ID = costsE0.SOURCE_ID
AND costsE0.SOURCE_ID = costInfosE0.SOURCE_ID
AND costsE0.LEGISLATIVE_DATA_GROUP_ID = leGISTATIONE0.LEGISLATIVE_DATA_GROUP_ID
ORDER BY pmsE0.BASE_ORG_PAY_METHOD_NAME,costsE0.EFFECTIVE_START_DATE
