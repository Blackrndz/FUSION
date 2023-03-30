/* ****************************************************************************
* $Revision: 78693 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-06-07 17:22:14 +0700 (Tue, 07 Jun 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Templates%20-%20Supplier%20Organization%20Members.sql $:
* $Id: Manage Project Templates - Supplier Organization Members.sql 78693 2022-06-07 10:22:14Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT projTemplatesE0.NAME RES_TEMPLATE_NAME
,projTemplatesE0.SEGMENT1 RES_TEMPLATE_NUMBER
,(SELECT PARTY_NAME
	FROM HZ_PARTIES
	WHERE PARTY_ID = partnerOrgsE0.RESOURCE_SOURCE_ID
	) RES_NAME
,(SELECT PARTY_NAME
	FROM HZ_PARTIES
	WHERE PARTY_ID = partnerOrgPersonsE0.RESOURCE_SOURCE_ID
	) RES_PERSON
,(SELECT PROJECT_ROLE_NAME
	FROM PJF_PROJ_ROLE_TYPES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND PROJECT_ROLE_ID = partnerOrgPersonsE0.PROJECT_ROLE_ID
	) RES_PROJECT_ROLE
,TO_CHAR(partnerOrgPersonsE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(partnerOrgPersonsE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE
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
,HZ_RELATIONSHIPS RelationshipsE0
,PJF_PROJECT_PARTIES partnerOrgPersonsE0
WHERE projTemplatesE0.TEMPLATE_FLAG = 'Y'
AND projTemplatesE0.ORG_ID = buE0.BU_ID
AND projTemplatesE0.PROJECT_ID = partnerOrgsE0.PROJECT_ID
AND partnerOrgsE0.PROJECT_PARTY_TYPE = 'SO'
AND partnerOrgsE0.RESOURCE_SOURCE_ID = RelationshipsE0.SUBJECT_ID
AND RelationshipsE0.SUBJECT_TYPE = 'ORGANIZATION'
AND RelationshipsE0.RELATIONSHIP_ID = partnerOrgPersonsE0.RELATIONSHIP_ID
AND partnerOrgsE0.PROJECT_ID = partnerOrgPersonsE0.PROJECT_ID
ORDER BY projTemplatesE0.NAME,2,3