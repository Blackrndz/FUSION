/* ****************************************************************************
 * $Revision: 62668 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-06-19 18:28:29 +0700 (Mon, 19 Jun 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.12/branches/core/v2.2.0.0/reverse_sql/FINANCIALS/Assign%20Legal%20Entities%20-%20Assign%20Legal%20Entities.sql $:
 * $Id: Assign Legal Entities - Assign Legal Entities.sql 62668 2017-06-19 11:28:29Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=INSTANCE_CODE

SELECT 'OPS' RES_CODE
,SourceSystemsE0.INSTANCE_CODE RES_SOURCE_SYSTEMS_CODE
,SourceSystemsOrgListE0.SR_ORGANIZATION_CODE RES_ORGANIZATION
,OrgE0.NAME RES_NAME
,OrgE0.CLASSIFICATION_NAME RES_ORGANIZATION_TYPE
,DECODE(SourceSystemsOrgListE0.ENABLED_FLAG,1,'Yes','No') RES_ENABLE_FOR_COLLECTIONS
,SourceSystemsOrgListE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,SourceSystemsOrgListE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,SourceSystemsOrgListE0.CREATED_BY  RSC_CREATED_BY
,SourceSystemsOrgListE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,SourceSystemsOrgListE0.SR_ORGANIZATION_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_APPS_INSTANCES SourceSystemsE0
,MSC_INSTANCE_ORGS SourceSystemsOrgListE0
, (SELECT ORG.NAME
	,ORG.ORGANIZATION_ID
	,DECODE(INV_ORG.INVENTORY_FLAG,'Y','Inventory organization','N','Item organization') CLASSIFICATION_NAME
	FROM HR_ALL_ORGANIZATION_UNITS_F_VL ORG
	,INV_ORG_PARAMETERS INV_ORG
	/*,HR_ORG_UNIT_CLASSIFICATIONS_X CLS
	,HR_ORG_CLASSIFICATIONS_VL OrgClassificationPEO
	WHERE CLS.ORGANIZATION_ID = ORG.ORGANIZATION_ID
	AND CLS.CLASSIFICATION_CODE = OrgClassificationPEO.CLASSIFICATION_CODE
	AND CLS.CLASSIFICATION_CODE = 'INV'*/
	WHERE ORG.ORGANIZATION_ID = INV_ORG.ORGANIZATION_ID
	AND SYSDATE BETWEEN ORG.EFFECTIVE_START_DATE AND ORG.EFFECTIVE_END_DATE
	) OrgE0
WHERE SourceSystemsE0.INSTANCE_ID = SourceSystemsOrgListE0.SR_INSTANCE_ID
AND SourceSystemsOrgListE0.SR_ORGANIZATION_ID = OrgE0.ORGANIZATION_ID
ORDER BY SourceSystemsE0.INSTANCE_CODE
,SourceSystemsOrgListE0.SR_ORGANIZATION_CODE
,OrgE0.NAME