/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=10024##RES##HZ_ORGANIZATION_PROFILES
-- DFF_ATTRIBUTES=ATTRIBUTE,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.

SELECT HzPartiesE0.PARTY_NUMBER RES_REGISTRY_ID
,HzPartiesE0.PARTY_NAME RES_NAME
,HzOrganizationProfileE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,HzOrganizationProfileE0.ATTRIBUTE1
,HzOrganizationProfileE0.ATTRIBUTE2
,HzOrganizationProfileE0.ATTRIBUTE3
,HzOrganizationProfileE0.ATTRIBUTE4
,HzOrganizationProfileE0.ATTRIBUTE5
,HzOrganizationProfileE0.ATTRIBUTE6
,HzOrganizationProfileE0.ATTRIBUTE7
,HzOrganizationProfileE0.ATTRIBUTE8
,HzOrganizationProfileE0.ATTRIBUTE9
,HzOrganizationProfileE0.ATTRIBUTE10
,HzOrganizationProfileE0.ATTRIBUTE11
,HzOrganizationProfileE0.ATTRIBUTE12
,HzOrganizationProfileE0.ATTRIBUTE13
,HzOrganizationProfileE0.ATTRIBUTE14
,HzOrganizationProfileE0.ATTRIBUTE15
,HzOrganizationProfileE0.ATTRIBUTE16
,HzOrganizationProfileE0.ATTRIBUTE17
,HzOrganizationProfileE0.ATTRIBUTE18
,HzOrganizationProfileE0.ATTRIBUTE19
,HzOrganizationProfileE0.ATTRIBUTE20
,HzOrganizationProfileE0.ATTRIBUTE21
,HzOrganizationProfileE0.ATTRIBUTE22
,HzOrganizationProfileE0.ATTRIBUTE23
,HzOrganizationProfileE0.ATTRIBUTE24
,HzOrganizationProfileE0.ATTRIBUTE25
,HzOrganizationProfileE0.ATTRIBUTE26
,HzOrganizationProfileE0.ATTRIBUTE27
,HzOrganizationProfileE0.ATTRIBUTE28
,HzOrganizationProfileE0.ATTRIBUTE29
,HzOrganizationProfileE0.ATTRIBUTE30
,HzOrganizationProfileE0.ATTRIBUTE_NUMBER1
,HzOrganizationProfileE0.ATTRIBUTE_NUMBER2
,HzOrganizationProfileE0.ATTRIBUTE_NUMBER3
,HzOrganizationProfileE0.ATTRIBUTE_NUMBER4
,HzOrganizationProfileE0.ATTRIBUTE_NUMBER5
,HzOrganizationProfileE0.ATTRIBUTE_NUMBER6
,HzOrganizationProfileE0.ATTRIBUTE_NUMBER7
,HzOrganizationProfileE0.ATTRIBUTE_NUMBER8
,HzOrganizationProfileE0.ATTRIBUTE_NUMBER9
,HzOrganizationProfileE0.ATTRIBUTE_NUMBER10
,HzOrganizationProfileE0.ATTRIBUTE_NUMBER11
,HzOrganizationProfileE0.ATTRIBUTE_NUMBER12
,HzOrganizationProfileE0.ATTRIBUTE_DATE1
,HzOrganizationProfileE0.ATTRIBUTE_DATE2
,HzOrganizationProfileE0.ATTRIBUTE_DATE3
,HzOrganizationProfileE0.ATTRIBUTE_DATE4
,HzOrganizationProfileE0.ATTRIBUTE_DATE5
,HzOrganizationProfileE0.ATTRIBUTE_DATE6
,HzOrganizationProfileE0.ATTRIBUTE_DATE7
,HzOrganizationProfileE0.ATTRIBUTE_DATE8
,HzOrganizationProfileE0.ATTRIBUTE_DATE9
,HzOrganizationProfileE0.ATTRIBUTE_DATE10
,HzOrganizationProfileE0.ATTRIBUTE_DATE11
,HzOrganizationProfileE0.ATTRIBUTE_DATE12
,HzOrganizationProfileE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,HzOrganizationProfileE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,HzOrganizationProfileE0.CREATED_BY  RSC_CREATED_BY
,HzOrganizationProfileE0.CREATION_DATE  RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_PARTIES HzPartiesE0
,HZ_PARTY_USG_ASSIGNMENTS HzPartyUsgAssignmentsE0
,HZ_ORGANIZATION_PROFILES HzOrganizationProfileE0
WHERE HzPartiesE0.PARTY_ID = HzPartyUsgAssignmentsE0.PARTY_ID
AND HzPartiesE0.PARTY_ID = HzOrganizationProfileE0.PARTY_ID
AND HzPartyUsgAssignmentsE0.PARTY_USAGE_CODE = 'CREDIT_CARD_PROVIDER'
AND (HzOrganizationProfileE0.ATTRIBUTE_CATEGORY IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE1 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE2 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE3 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE4 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE5 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE6 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE7 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE8 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE9 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE10 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE11 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE12 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE13 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE14 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE15 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE16 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE17 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE18 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE19 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE20 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE21 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE22 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE23 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE24 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE25 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE26 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE27 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE28 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE29 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE30 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_NUMBER1 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_NUMBER2 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_NUMBER3 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_NUMBER4 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_NUMBER5 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_NUMBER6 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_NUMBER7 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_NUMBER8 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_NUMBER9 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_NUMBER10 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_NUMBER11 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_NUMBER12 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_DATE1 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_DATE2 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_DATE3 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_DATE4 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_DATE5 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_DATE6 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_DATE7 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_DATE8 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_DATE9 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_DATE10 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_DATE11 IS NOT NULL
OR HzOrganizationProfileE0.ATTRIBUTE_DATE12 IS NOT NULL)
ORDER BY HzPartiesE0.PARTY_NUMBER