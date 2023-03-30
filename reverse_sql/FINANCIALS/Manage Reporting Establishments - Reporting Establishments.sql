/* ****************************************************************************
 * $Revision: 50797 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-24 16:49:46 +0700 (Tue, 24 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Revenue%20Policies%20-%20Manage%20Revenue%20Policies.sql $:
 * $Id: Manage Revenue Policies - Manage Revenue Policies.sql 50797 2015-11-24 09:49:46Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT rpEstE0.NAME RES_NAME

,rpEstE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,rpEstE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,rpEstE0.CREATED_BY RSC_CREATED_BY
,rpEstE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HR_ORGANIZATION_V rpEstE0
,(SELECT ORGANIZATION_ID
	,ORG_INFORMATION1
	,ORG_INFORMATION2
	FROM HR_ORGANIZATION_INFORMATION_F 
	WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND ORG_INFORMATION_CONTEXT = 'PER_ORG_MANAGER_INFO'
	) InfoEO
WHERE rpEstE0.ORGANIZATION_ID = InfoEO.ORGANIZATION_ID(+)
AND rpEstE0.CLASSIFICATION_CODE = 'HCM_REPORTING_ESTABLISHMENT'
AND rpEstE0.ESTABLISHMENT_ID IS NULL
AND SYSDATE BETWEEN rpEstE0.EFFECTIVE_START_DATE AND rpEstE0.EFFECTIVE_END_DATE
ORDER BY rpEstE0.NAME,rpEstE0.EFFECTIVE_START_DATE