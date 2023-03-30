/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT buE0.BU_NAME RES_BUSINESS_UNIT_NAME
,buE1.BU_NAME RES_RECEIVER_BUSINESS_UNIT
,DECODE(ccRelationshipE0.OVERRIDE_BL_FLAG,'Y','Yes','No') RES_PROCESS_FOR_BORROWED_AND_L
,buInplAllE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,buInplAllE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,buInplAllE0.CREATED_BY RSC_CREATED_BY
,buInplAllE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,buE0.BU_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_BU_IMPL_ALL buInplAllE0
,FUN_ALL_BUSINESS_UNITS_V buE0
,PJC_CC_ORG_RELATIONSHIPS ccRelationshipE0
,FUN_ALL_BUSINESS_UNITS_V buE1
WHERE buInplAllE0.ORG_ID = buE0.BU_ID
AND buInplAllE0.ORG_ID = ccRelationshipE0.PRVDR_BU_ID
AND ccRelationshipE0.RECVR_BU_ID = buE1.BU_ID
ORDER BY buE0.BU_NAME
,buE1.BU_NAME