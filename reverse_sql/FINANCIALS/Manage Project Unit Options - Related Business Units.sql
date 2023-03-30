/* ****************************************************************************
 * $Revision: 63805 $:
 * $Author: phermwit.seethong $:
 * $Date: 2017-09-12 15:37:52 +0700 (Tue, 12 Sep 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Revaluations%20-%20Revaluations.sql $:
 * $Id: Manage Revaluations - Revaluations.sql 63805 2017-09-12 08:37:52Z phermwit.seethong $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT (SELECT ORG_INFORMATION1
    FROM HR_ORGANIZATION_INFORMATION_F
    WHERE ORG_INFORMATION_CONTEXT = 'PRJ_PU_ATTRIBUTES'
    AND ORGANIZATION_ID = org.ORGANIZATION_ID) RES_CODE
,org.NAME RES_NAME
,NULL RES_AVAILABLE_BUSINESS_UNITS
,(SELECT BU_NAME 
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = pjfRelationsE0.ORG_ID
	) RES_SELECTED_BUSINESS_UNITS
,pjfRelationsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,pjfRelationsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,pjfRelationsE0.CREATED_BY RSC_CREATED_BY
,pjfRelationsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,org.ORGANIZATION_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HR_ALL_ORGANIZATION_UNITS org
,PJF_PU_IMPL puImpleE0
,PJF_PU_BU_RELATIONSHIP pjfRelationsE0
WHERE org.ORGANIZATION_ID = puImpleE0.PU_ID
AND puImpleE0.PU_ID = pjfRelationsE0.PU_ID
ORDER BY 1