/* ****************************************************************************
 * $Revision: 50797 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-24 16:49:46 +0700 (Tue, 24 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Revenue%20Policies%20-%20Manage%20Revenue%20Policies.sql $:
 * $Id: Manage Revenue Policies - Manage Revenue Policies.sql 50797 2015-11-24 09:49:46Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT (SELECT TERRITORY_SHORT_NAME
	FROM FND_TERRITORIES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND TERRITORY_CODE = workerUnionsE0.LEGISLATION_CODE 
	) RES_COUNTRY
,workerUnionsE0.NAME RES_NAME

,workerUnionsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,workerUnionsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,workerUnionsE0.CREATED_BY RSC_CREATED_BY
,workerUnionsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HR_ORGANIZATION_V workerUnionsE0
,(SELECT ORGANIZATION_ID
	,ORG_INFORMATION1
	,ORG_INFORMATION2
	FROM HR_ORGANIZATION_INFORMATION_F 
	WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND ORG_INFORMATION_CONTEXT = 'ORA_PER_UNION_ADDITIONAL_INFORMATION'
	) InfoEO
WHERE workerUnionsE0.ORGANIZATION_ID = InfoEO.ORGANIZATION_ID(+)
AND workerUnionsE0.CLASSIFICATION_CODE = 'ORA_PER_UNION'
AND SYSDATE BETWEEN workerUnionsE0.EFFECTIVE_START_DATE AND workerUnionsE0.EFFECTIVE_END_DATE
ORDER BY RES_COUNTRY,workerUnionsE0.NAME