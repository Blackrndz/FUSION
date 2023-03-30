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
,NULL RES_AVAILABLE_PROJECT_UNITS
,(SELECT NAME 
	FROM HR_ALL_ORGANIZATION_UNITS
	WHERE ORGANIZATION_ID = puBuRelatedE0.PU_ID
	) RES_SELECTED_PROJECT_UNITS
,puBuRelatedE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,puBuRelatedE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,puBuRelatedE0.CREATED_BY RSC_CREATED_BY
,puBuRelatedE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,buInplAllE0.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_BU_IMPL_ALL buInplAllE0
,FUN_ALL_BUSINESS_UNITS_V buE0
,PJF_PU_BU_RELATIONSHIP puBuRelatedE0
WHERE buInplAllE0.ORG_ID = buE0.BU_ID
AND buInplAllE0.ORG_ID = puBuRelatedE0.ORG_ID
ORDER BY buE0.BU_NAME