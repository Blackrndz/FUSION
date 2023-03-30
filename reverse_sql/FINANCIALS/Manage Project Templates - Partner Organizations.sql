/* ****************************************************************************
* $Revision: 78693 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-06-07 17:22:14 +0700 (Tue, 07 Jun 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Templates%20-%20Partner%20Organizations.sql $:
* $Id: Manage Project Templates - Partner Organizations.sql 78693 2022-06-07 10:22:14Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT projTemplatesE0.NAME RES_TEMPLATE_NAME
,projTemplatesE0.SEGMENT1 RES_TEMPLATE_NUMBER
,(SELECT PARTY_NAME
	FROM HZ_PARTIES
	WHERE PARTY_ID = partnerOrgsE0.RESOURCE_SOURCE_ID) RES_NAME
,partnerOrgsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,partnerOrgsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,partnerOrgsE0.CREATED_BY  RSC_CREATED_BY
,partnerOrgsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,projTemplatesE0.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_PROJECTS_ALL_VL projTemplatesE0
,FUN_ALL_BUSINESS_UNITS_V buE0
,PJF_PROJECT_PARTIES partnerOrgsE0
WHERE projTemplatesE0.TEMPLATE_FLAG = 'Y'
AND projTemplatesE0.ORG_ID = buE0.BU_ID
AND projTemplatesE0.PROJECT_ID = partnerOrgsE0.PROJECT_ID
AND partnerOrgsE0.PROJECT_PARTY_TYPE = 'PO'
ORDER BY projTemplatesE0.NAME,2