/* ****************************************************************************
 * $Revision: 53756 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-22 15:41:28 +0700 (Tue, 22 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 53756 2016-03-22 08:41:28Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=435##RES##FUN_INTERCO_ORGANIZATIONS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.

SELECT IntercompanyOrgE0.INTERCO_ORG_NAME RES_ORGANIZATION_NAME
,IntercompanyOrgE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,IntercompanyOrgE0.ATTRIBUTE1
,IntercompanyOrgE0.ATTRIBUTE2
,IntercompanyOrgE0.ATTRIBUTE3
,IntercompanyOrgE0.ATTRIBUTE4
,IntercompanyOrgE0.ATTRIBUTE5
,IntercompanyOrgE0.ATTRIBUTE6
,IntercompanyOrgE0.ATTRIBUTE7
,IntercompanyOrgE0.ATTRIBUTE8
,IntercompanyOrgE0.ATTRIBUTE9
,IntercompanyOrgE0.ATTRIBUTE10
,IntercompanyOrgE0.ATTRIBUTE11
,IntercompanyOrgE0.ATTRIBUTE12
,IntercompanyOrgE0.ATTRIBUTE13
,IntercompanyOrgE0.ATTRIBUTE14
,IntercompanyOrgE0.ATTRIBUTE15
,IntercompanyOrgE0.ATTRIBUTE16
,IntercompanyOrgE0.ATTRIBUTE17
,IntercompanyOrgE0.ATTRIBUTE18
,IntercompanyOrgE0.ATTRIBUTE19
,IntercompanyOrgE0.ATTRIBUTE20
,IntercompanyOrgE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,IntercompanyOrgE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,IntercompanyOrgE0.CREATED_BY  RSC_CREATED_BY
,IntercompanyOrgE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,(CASE
	WHEN IntercompanyOrgE0.PAY_BU_ID IS NOT NULL OR IntercompanyOrgE0.REC_BU_ID IS NOT NULL THEN
		NVL(IntercompanyOrgE0.PAY_BU_ID,IntercompanyOrgE0.REC_BU_ID)
	END) RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,(CASE
	WHEN IntercompanyOrgE0.PAY_BU_ID IS NULL AND IntercompanyOrgE0.REC_BU_ID IS NULL THEN
		IntercompanyOrgE0.INTERCO_ORG_ID
	END) RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
  
FROM FUN_INTERCO_ORGANIZATIONS IntercompanyOrgE0
WHERE (IntercompanyOrgE0.ATTRIBUTE_CATEGORY IS NOT NULL OR
IntercompanyOrgE0.ATTRIBUTE1 IS NOT NULL OR 
IntercompanyOrgE0.ATTRIBUTE2 IS NOT NULL OR 
IntercompanyOrgE0.ATTRIBUTE3 IS NOT NULL OR 
IntercompanyOrgE0.ATTRIBUTE4 IS NOT NULL OR 
IntercompanyOrgE0.ATTRIBUTE5 IS NOT NULL OR 
IntercompanyOrgE0.ATTRIBUTE6 IS NOT NULL OR 
IntercompanyOrgE0.ATTRIBUTE7 IS NOT NULL OR 
IntercompanyOrgE0.ATTRIBUTE8 IS NOT NULL OR 
IntercompanyOrgE0.ATTRIBUTE9 IS NOT NULL OR 
IntercompanyOrgE0.ATTRIBUTE10 IS NOT NULL OR 
IntercompanyOrgE0.ATTRIBUTE11 IS NOT NULL OR 
IntercompanyOrgE0.ATTRIBUTE12 IS NOT NULL OR 
IntercompanyOrgE0.ATTRIBUTE13 IS NOT NULL OR 
IntercompanyOrgE0.ATTRIBUTE14 IS NOT NULL OR 
IntercompanyOrgE0.ATTRIBUTE15 IS NOT NULL OR
IntercompanyOrgE0.ATTRIBUTE16 IS NOT NULL OR 
IntercompanyOrgE0.ATTRIBUTE17 IS NOT NULL OR 
IntercompanyOrgE0.ATTRIBUTE18 IS NOT NULL OR 
IntercompanyOrgE0.ATTRIBUTE19 IS NOT NULL OR 
IntercompanyOrgE0.ATTRIBUTE20 IS NOT NULL)
ORDER BY IntercompanyOrgE0.INTERCO_ORG_NAME