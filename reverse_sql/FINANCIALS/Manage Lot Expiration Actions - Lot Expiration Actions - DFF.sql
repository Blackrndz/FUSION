 /* ****************************************************************************
 * $Revision: 48884 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2015-08-18 14:24:02 +0700 (Tue, 18 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Types%20-%20Manage%20Transaction%20Types.sql $:
 * $Id: Manage Transaction Types - Manage Transaction Types.sql 48884 2015-08-18 07:24:02Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=401##RES##INV_ACTIONS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT LotExpirationActionEO.ACTION_CODE RES_NAME
,LotExpirationActionEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,LotExpirationActionEO.ATTRIBUTE1
,LotExpirationActionEO.ATTRIBUTE2
,LotExpirationActionEO.ATTRIBUTE3
,LotExpirationActionEO.ATTRIBUTE4
,LotExpirationActionEO.ATTRIBUTE5
,LotExpirationActionEO.ATTRIBUTE6
,LotExpirationActionEO.ATTRIBUTE7
,LotExpirationActionEO.ATTRIBUTE8
,LotExpirationActionEO.ATTRIBUTE9
,LotExpirationActionEO.ATTRIBUTE10
,LotExpirationActionEO.ATTRIBUTE11
,LotExpirationActionEO.ATTRIBUTE12
,LotExpirationActionEO.ATTRIBUTE13
,LotExpirationActionEO.ATTRIBUTE14
,LotExpirationActionEO.ATTRIBUTE15
,LotExpirationActionEO.ATTRIBUTE16
,LotExpirationActionEO.ATTRIBUTE17
,LotExpirationActionEO.ATTRIBUTE18
,LotExpirationActionEO.ATTRIBUTE19
,LotExpirationActionEO.ATTRIBUTE20
,LotExpirationActionEO.ATTRIBUTE21
,LotExpirationActionEO.ATTRIBUTE22
,LotExpirationActionEO.ATTRIBUTE23
,LotExpirationActionEO.ATTRIBUTE24
,LotExpirationActionEO.ATTRIBUTE25
,LotExpirationActionEO.ATTRIBUTE26
,LotExpirationActionEO.ATTRIBUTE27
,LotExpirationActionEO.ATTRIBUTE28
,LotExpirationActionEO.ATTRIBUTE29
,LotExpirationActionEO.ATTRIBUTE30
,LotExpirationActionEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,LotExpirationActionEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,LotExpirationActionEO.CREATED_BY  RSC_CREATED_BY
,LotExpirationActionEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_ACTIONS_VL LotExpirationActionEO
WHERE (LotExpirationActionEO.ATTRIBUTE_CATEGORY IS NOT NULL OR
LotExpirationActionEO.ATTRIBUTE1 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE2 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE3 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE4 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE5 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE6 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE7 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE8 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE9 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE10 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE11 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE12 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE13 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE14 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE15 IS NOT NULL OR
LotExpirationActionEO.ATTRIBUTE16 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE17 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE18 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE19 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE20 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE21 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE22 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE23 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE24 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE25 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE26 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE27 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE28 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE29 IS NOT NULL OR 
LotExpirationActionEO.ATTRIBUTE30 IS NOT NULL
)
ORDER BY LotExpirationActionEO.ACTION_CODE