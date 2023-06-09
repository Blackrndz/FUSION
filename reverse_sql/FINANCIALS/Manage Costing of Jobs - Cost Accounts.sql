/* ****************************************************************************
 * $Revision: 56510 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-07-06 09:21:36 +0700 (Wed, 06 Jul 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Locations%20(United%20States)%20-%20Manage%20Locations.sql $:
 * $Id: Manage Locations (United States) - Manage Locations.sql 56510 2016-07-06 02:21:36Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
-- syntax: APPLICATION_ID##RES##KFF_CODE
-- KFF_LOGIC_TO_APPLY=801##RES##COST
-- KFF_PREFIX_ALIAS=RES_COST_ACCOUNT_
-- KFF_COLUMN_NAME=SEGMENT

-- IMPORTANT: 
-- - the order of segments must start from 1 to ...

select DISTINCT jobsE0.NAME RES_JOB
,jobsE0.JOB_CODE RES_CODE
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = jobsE0.ACTIVE_STATUS 
	AND LOOKUP_TYPE = 'CODE_STATUS' AND SYSDATE BETWEEN START_DATE_ACTIVE AND END_DATE_ACTIVE) RES_STATUS
,(SELECT SET_NAME FROM FND_SETID_SETS_VL WHERE SET_ID = jobsE0.SET_ID) RES_JOB_SET
,(SELECT NAME
    FROM PER_LEGISLATIVE_DATA_GROUPS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND LEGISLATIVE_DATA_GROUP_ID = costsE0.LEGISLATIVE_DATA_GROUP_ID
    ) RES_LEGISLATIVE_DATA_GROUP
,TO_CHAR(costsE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,costAccsE0.PROPORTION*100 RES_PERCENTAGE
,costAccsE0.SEGMENT1 RES_COST_ACCOUNT_1
,costAccsE0.SEGMENT2 RES_COST_ACCOUNT_2
,costAccsE0.SEGMENT3 RES_COST_ACCOUNT_3
,costAccsE0.SEGMENT4 RES_COST_ACCOUNT_4
,costAccsE0.SEGMENT5 RES_COST_ACCOUNT_5
,costAccsE0.SEGMENT6 RES_COST_ACCOUNT_6
,costAccsE0.SEGMENT7 RES_COST_ACCOUNT_7
,costAccsE0.SEGMENT8 RES_COST_ACCOUNT_8
,costAccsE0.SEGMENT9 RES_COST_ACCOUNT_9
,costAccsE0.SEGMENT10 RES_COST_ACCOUNT_10
/*,costAccsE0.SEGMENT11 RES_COST_ACCOUNT_11
,costAccsE0.SEGMENT12 RES_COST_ACCOUNT_12
,costAccsE0.SEGMENT13 RES_COST_ACCOUNT_13
,costAccsE0.SEGMENT14 RES_COST_ACCOUNT_14
,costAccsE0.SEGMENT15 RES_COST_ACCOUNT_15
,costAccsE0.SEGMENT16 RES_COST_ACCOUNT_16
,costAccsE0.SEGMENT17 RES_COST_ACCOUNT_17
,costAccsE0.SEGMENT18 RES_COST_ACCOUNT_18
,costAccsE0.SEGMENT19 RES_COST_ACCOUNT_19
,costAccsE0.SEGMENT20 RES_COST_ACCOUNT_20
,costAccsE0.SEGMENT21 RES_COST_ACCOUNT_21
,costAccsE0.SEGMENT22 RES_COST_ACCOUNT_22
,costAccsE0.SEGMENT23 RES_COST_ACCOUNT_23
,costAccsE0.SEGMENT24 RES_COST_ACCOUNT_24
,costAccsE0.SEGMENT25 RES_COST_ACCOUNT_25
,costAccsE0.SEGMENT26 RES_COST_ACCOUNT_26
,costAccsE0.SEGMENT27 RES_COST_ACCOUNT_27
,costAccsE0.SEGMENT28 RES_COST_ACCOUNT_28
,costAccsE0.SEGMENT29 RES_COST_ACCOUNT_29
,costAccsE0.SEGMENT30 RES_COST_ACCOUNT_30*/
,costAccsE0.ID_FLEX_NUM RSC_EXTRA_COLUMN1
,costAccsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,costAccsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,costAccsE0.CREATED_BY  RSC_CREATED_BY
,costAccsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_JOBS_F_VL jobsE0
,(SELECT *
    FROM PAY_COST_ALLOCATIONS_F
    WHERE SOURCE_TYPE = 'JOB'
    ) costsE0
,PAY_COST_ALLOC_ACCOUNTS costAccsE0
WHERE jobsE0.JOB_ID = costsE0.SOURCE_ID
AND costsE0.COST_ALLOCATION_RECORD_ID = costAccsE0.COST_ALLOCATION_RECORD_ID
ORDER BY jobsE0.NAME
,jobsE0.JOB_CODE

 







