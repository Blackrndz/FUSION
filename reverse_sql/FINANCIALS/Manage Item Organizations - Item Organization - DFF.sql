/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-05-04 $:
 * $HeadURL:  $:
 * $Id: Manage Item Organizations - Item Organization - DFF.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=401##RES##INV_ORG_PARAMETERS
-- DFF_ATTRIBUTES=ATTRIBUTE,GLOBAL_ATTRIBUTE,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE,ATTRIBUTE_TIMESTAMP
-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.

SELECT OrganizationParameterEO.ORGANIZATION_CODE AS RES_NAME
,OrgClassificationPEO.CLASSIFICATION_NAME AS RES_CLASSIFICATION
,OrganizationParameterEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,OrganizationParameterEO.ATTRIBUTE1 
,OrganizationParameterEO.ATTRIBUTE2
,OrganizationParameterEO.ATTRIBUTE3
,OrganizationParameterEO.ATTRIBUTE4
,OrganizationParameterEO.ATTRIBUTE5
,OrganizationParameterEO.ATTRIBUTE6
,OrganizationParameterEO.ATTRIBUTE7
,OrganizationParameterEO.ATTRIBUTE8
,OrganizationParameterEO.ATTRIBUTE9
,OrganizationParameterEO.ATTRIBUTE10
,OrganizationParameterEO.ATTRIBUTE11
,OrganizationParameterEO.ATTRIBUTE12
,OrganizationParameterEO.ATTRIBUTE13
,OrganizationParameterEO.ATTRIBUTE14
,OrganizationParameterEO.ATTRIBUTE15
,OrganizationParameterEO.GLOBAL_ATTRIBUTE1 
,OrganizationParameterEO.GLOBAL_ATTRIBUTE2
,OrganizationParameterEO.GLOBAL_ATTRIBUTE3
,OrganizationParameterEO.GLOBAL_ATTRIBUTE4
,OrganizationParameterEO.GLOBAL_ATTRIBUTE5
,OrganizationParameterEO.GLOBAL_ATTRIBUTE6
,OrganizationParameterEO.GLOBAL_ATTRIBUTE7
,OrganizationParameterEO.GLOBAL_ATTRIBUTE8
,OrganizationParameterEO.GLOBAL_ATTRIBUTE9
,OrganizationParameterEO.GLOBAL_ATTRIBUTE10
,OrganizationParameterEO.GLOBAL_ATTRIBUTE11
,OrganizationParameterEO.GLOBAL_ATTRIBUTE12
,OrganizationParameterEO.GLOBAL_ATTRIBUTE13
,OrganizationParameterEO.GLOBAL_ATTRIBUTE14
,OrganizationParameterEO.GLOBAL_ATTRIBUTE15
,OrganizationParameterEO.GLOBAL_ATTRIBUTE16
,OrganizationParameterEO.GLOBAL_ATTRIBUTE17
,OrganizationParameterEO.GLOBAL_ATTRIBUTE18
,OrganizationParameterEO.GLOBAL_ATTRIBUTE19
,OrganizationParameterEO.GLOBAL_ATTRIBUTE20
,OrganizationParameterEO.ATTRIBUTE_NUMBER1 
,OrganizationParameterEO.ATTRIBUTE_NUMBER2
,OrganizationParameterEO.ATTRIBUTE_NUMBER3
,OrganizationParameterEO.ATTRIBUTE_NUMBER4
,OrganizationParameterEO.ATTRIBUTE_NUMBER5
,OrganizationParameterEO.ATTRIBUTE_NUMBER6
,OrganizationParameterEO.ATTRIBUTE_NUMBER7
,OrganizationParameterEO.ATTRIBUTE_NUMBER8
,OrganizationParameterEO.ATTRIBUTE_NUMBER9
,OrganizationParameterEO.ATTRIBUTE_NUMBER10
, TO_CHAR(OrganizationParameterEO.ATTRIBUTE_DATE1, 'DD-Mon-YYYY') ATTRIBUTE_DATE1
, TO_CHAR(OrganizationParameterEO.ATTRIBUTE_DATE2, 'DD-Mon-YYYY') ATTRIBUTE_DATE2
, TO_CHAR(OrganizationParameterEO.ATTRIBUTE_DATE3, 'DD-Mon-YYYY') ATTRIBUTE_DATE3
, TO_CHAR(OrganizationParameterEO.ATTRIBUTE_DATE4, 'DD-Mon-YYYY') ATTRIBUTE_DATE4
, TO_CHAR(OrganizationParameterEO.ATTRIBUTE_DATE5, 'DD-Mon-YYYY') ATTRIBUTE_DATE5
,OrganizationParameterEO.ATTRIBUTE_TIMESTAMP1 
,OrganizationParameterEO.ATTRIBUTE_TIMESTAMP2
,OrganizationParameterEO.ATTRIBUTE_TIMESTAMP3
,OrganizationParameterEO.ATTRIBUTE_TIMESTAMP4
,OrganizationParameterEO.ATTRIBUTE_TIMESTAMP5
,OrganizationParameterEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,OrganizationParameterEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,OrganizationParameterEO.CREATED_BY  RSC_CREATED_BY
,OrganizationParameterEO.CREATION_DATE  RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,OrganizationParameterEO.BUSINESS_UNIT_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,(CASE
	WHEN EXISTS
		(SELECT DISTINCT MASTER_ORGANIZATION_ID
			FROM INV_ORG_PARAMETERS
			WHERE MASTER_ORGANIZATION_ID = OrganizationParameterEO.ORGANIZATION_ID)
	THEN NULL
	ELSE OrganizationParameterEO.ORGANIZATION_ID
	END) RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM INV_ORG_PARAMETERS OrganizationParameterEO  
,HR_ORGANIZATION_V InventoryOrganizationEO
,HR_ORG_CLASSIFICATIONS_VL OrgClassificationPEO
WHERE (OrganizationParameterEO.ATTRIBUTE_CATEGORY IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE1 IS NOT NULL OR 
OrganizationParameterEO.ATTRIBUTE2 IS NOT NULL OR 
OrganizationParameterEO.ATTRIBUTE3 IS NOT NULL OR 
OrganizationParameterEO.ATTRIBUTE4 IS NOT NULL OR 
OrganizationParameterEO.ATTRIBUTE5 IS NOT NULL OR 
OrganizationParameterEO.ATTRIBUTE6 IS NOT NULL OR 
OrganizationParameterEO.ATTRIBUTE7 IS NOT NULL OR 
OrganizationParameterEO.ATTRIBUTE8 IS NOT NULL OR 
OrganizationParameterEO.ATTRIBUTE9 IS NOT NULL OR 
OrganizationParameterEO.ATTRIBUTE10 IS NOT NULL OR 
OrganizationParameterEO.ATTRIBUTE11 IS NOT NULL OR 
OrganizationParameterEO.ATTRIBUTE12 IS NOT NULL OR 
OrganizationParameterEO.ATTRIBUTE13 IS NOT NULL OR 
OrganizationParameterEO.ATTRIBUTE14 IS NOT NULL OR 
OrganizationParameterEO.ATTRIBUTE15 IS NOT NULL OR
OrganizationParameterEO.GLOBAL_ATTRIBUTE1 IS NOT NULL OR
OrganizationParameterEO.GLOBAL_ATTRIBUTE2 IS NOT NULL OR
OrganizationParameterEO.GLOBAL_ATTRIBUTE3 IS NOT NULL OR
OrganizationParameterEO.GLOBAL_ATTRIBUTE4 IS NOT NULL OR
OrganizationParameterEO.GLOBAL_ATTRIBUTE5 IS NOT NULL OR
OrganizationParameterEO.GLOBAL_ATTRIBUTE6 IS NOT NULL OR
OrganizationParameterEO.GLOBAL_ATTRIBUTE7 IS NOT NULL OR
OrganizationParameterEO.GLOBAL_ATTRIBUTE8 IS NOT NULL OR
OrganizationParameterEO.GLOBAL_ATTRIBUTE9 IS NOT NULL OR
OrganizationParameterEO.GLOBAL_ATTRIBUTE10 IS NOT NULL OR
OrganizationParameterEO.GLOBAL_ATTRIBUTE11 IS NOT NULL OR
OrganizationParameterEO.GLOBAL_ATTRIBUTE12 IS NOT NULL OR
OrganizationParameterEO.GLOBAL_ATTRIBUTE13 IS NOT NULL OR
OrganizationParameterEO.GLOBAL_ATTRIBUTE14 IS NOT NULL OR 
OrganizationParameterEO.GLOBAL_ATTRIBUTE15 IS NOT NULL OR
OrganizationParameterEO.GLOBAL_ATTRIBUTE16 IS NOT NULL OR
OrganizationParameterEO.GLOBAL_ATTRIBUTE17 IS NOT NULL OR 
OrganizationParameterEO.GLOBAL_ATTRIBUTE18 IS NOT NULL OR
OrganizationParameterEO.GLOBAL_ATTRIBUTE19 IS NOT NULL OR
OrganizationParameterEO.GLOBAL_ATTRIBUTE20 IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE_NUMBER1 IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE_NUMBER2 IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE_NUMBER3 IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE_NUMBER4 IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE_NUMBER5 IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE_NUMBER6 IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE_NUMBER7 IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE_NUMBER8 IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE_NUMBER9 IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE_NUMBER10 IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE_DATE1 IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE_DATE2 IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE_DATE3 IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE_DATE4 IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE_DATE5 IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE_TIMESTAMP1 IS NOT NULL OR 
OrganizationParameterEO.ATTRIBUTE_TIMESTAMP2 IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE_TIMESTAMP3 IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE_TIMESTAMP4 IS NOT NULL OR
OrganizationParameterEO.ATTRIBUTE_TIMESTAMP5 IS NOT NULL)
AND InventoryOrganizationEO.CLASSIFICATION_CODE  = OrgClassificationPEO.CLASSIFICATION_CODE
AND InventoryOrganizationEO.ORGANIZATION_ID   = OrganizationParameterEO.ORGANIZATION_ID
AND InventoryOrganizationEO.CLASSIFICATION_CODE = 'INV'
AND OrganizationParameterEO.INVENTORY_FLAG      = 'N'
AND SYSDATE BETWEEN InventoryOrganizationEO.EFFECTIVE_START_DATE AND InventoryOrganizationEO.EFFECTIVE_END_DATE
ORDER BY OrganizationParameterEO.ORGANIZATION_CODE