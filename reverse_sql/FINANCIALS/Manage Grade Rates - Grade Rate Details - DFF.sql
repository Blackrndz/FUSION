/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-11-16  $:
 * $HeadURL:  $:
 * $Id: Publish Account Hierarchies - Publish Account Hierarchies.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=800##RES##PER_RATES_DF
-- DFF_ATTRIBUTES=ATTRIBUTE,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT TO_CHAR(gradeRatesE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,legisDataGroupsE0.NAME RES_LEGISLATIVE_DATA_GROUP 
,gradeRatesE0.NAME RES_NAME
,gradeRatesE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,gradeRatesE0.ATTRIBUTE1
,gradeRatesE0.ATTRIBUTE2
,gradeRatesE0.ATTRIBUTE3
,gradeRatesE0.ATTRIBUTE4
,gradeRatesE0.ATTRIBUTE5
,gradeRatesE0.ATTRIBUTE6
,gradeRatesE0.ATTRIBUTE7
,gradeRatesE0.ATTRIBUTE8
,gradeRatesE0.ATTRIBUTE9
,gradeRatesE0.ATTRIBUTE10
,gradeRatesE0.ATTRIBUTE11
,gradeRatesE0.ATTRIBUTE12
,gradeRatesE0.ATTRIBUTE13
,gradeRatesE0.ATTRIBUTE14
,gradeRatesE0.ATTRIBUTE15
,gradeRatesE0.ATTRIBUTE16
,gradeRatesE0.ATTRIBUTE17
,gradeRatesE0.ATTRIBUTE18
,gradeRatesE0.ATTRIBUTE19
,gradeRatesE0.ATTRIBUTE20
,gradeRatesE0.ATTRIBUTE21
,gradeRatesE0.ATTRIBUTE22
,gradeRatesE0.ATTRIBUTE23
,gradeRatesE0.ATTRIBUTE24
,gradeRatesE0.ATTRIBUTE25
,gradeRatesE0.ATTRIBUTE26
,gradeRatesE0.ATTRIBUTE27
,gradeRatesE0.ATTRIBUTE28
,gradeRatesE0.ATTRIBUTE29
,gradeRatesE0.ATTRIBUTE30
,gradeRatesE0.ATTRIBUTE_NUMBER1
,gradeRatesE0.ATTRIBUTE_NUMBER2
,gradeRatesE0.ATTRIBUTE_NUMBER3
,gradeRatesE0.ATTRIBUTE_NUMBER4
,gradeRatesE0.ATTRIBUTE_NUMBER5
,gradeRatesE0.ATTRIBUTE_NUMBER6
,gradeRatesE0.ATTRIBUTE_NUMBER7
,gradeRatesE0.ATTRIBUTE_NUMBER8
,gradeRatesE0.ATTRIBUTE_NUMBER9
,gradeRatesE0.ATTRIBUTE_NUMBER10
,gradeRatesE0.ATTRIBUTE_NUMBER11
,gradeRatesE0.ATTRIBUTE_NUMBER12
,gradeRatesE0.ATTRIBUTE_NUMBER13
,gradeRatesE0.ATTRIBUTE_NUMBER14
,gradeRatesE0.ATTRIBUTE_NUMBER15
,gradeRatesE0.ATTRIBUTE_NUMBER16
,gradeRatesE0.ATTRIBUTE_NUMBER17
,gradeRatesE0.ATTRIBUTE_NUMBER18
,gradeRatesE0.ATTRIBUTE_NUMBER19
,gradeRatesE0.ATTRIBUTE_NUMBER20
,TO_CHAR(gradeRatesE0.ATTRIBUTE_DATE1, 'DD-Mon-YYYY') ATTRIBUTE_DATE1
,TO_CHAR(gradeRatesE0.ATTRIBUTE_DATE2, 'DD-Mon-YYYY') ATTRIBUTE_DATE2
,TO_CHAR(gradeRatesE0.ATTRIBUTE_DATE3, 'DD-Mon-YYYY') ATTRIBUTE_DATE3
,TO_CHAR(gradeRatesE0.ATTRIBUTE_DATE4, 'DD-Mon-YYYY') ATTRIBUTE_DATE4
,TO_CHAR(gradeRatesE0.ATTRIBUTE_DATE5, 'DD-Mon-YYYY') ATTRIBUTE_DATE5
,TO_CHAR(gradeRatesE0.ATTRIBUTE_DATE6, 'DD-Mon-YYYY') ATTRIBUTE_DATE6
,TO_CHAR(gradeRatesE0.ATTRIBUTE_DATE7, 'DD-Mon-YYYY') ATTRIBUTE_DATE7
,TO_CHAR(gradeRatesE0.ATTRIBUTE_DATE8, 'DD-Mon-YYYY') ATTRIBUTE_DATE8
,TO_CHAR(gradeRatesE0.ATTRIBUTE_DATE9, 'DD-Mon-YYYY') ATTRIBUTE_DATE9
,TO_CHAR(gradeRatesE0.ATTRIBUTE_DATE10, 'DD-Mon-YYYY') ATTRIBUTE_DATE10
,TO_CHAR(gradeRatesE0.ATTRIBUTE_DATE11, 'DD-Mon-YYYY') ATTRIBUTE_DATE11
,TO_CHAR(gradeRatesE0.ATTRIBUTE_DATE12, 'DD-Mon-YYYY') ATTRIBUTE_DATE12
,TO_CHAR(gradeRatesE0.ATTRIBUTE_DATE13, 'DD-Mon-YYYY') ATTRIBUTE_DATE13
,TO_CHAR(gradeRatesE0.ATTRIBUTE_DATE14, 'DD-Mon-YYYY') ATTRIBUTE_DATE14
,TO_CHAR(gradeRatesE0.ATTRIBUTE_DATE15, 'DD-Mon-YYYY') ATTRIBUTE_DATE15
,gradeRatesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,gradeRatesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,gradeRatesE0.CREATED_BY RSC_CREATED_BY
,gradeRatesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,legisDataGroupsE0.LEGISLATION_CODE RSC_COUNTRY_ID

FROM PER_RATES_F_VL gradeRatesE0
,(SELECT LEGISLATIVE_DATA_GROUP_ID
    ,NAME
	,LEGISLATION_CODE
    FROM PER_LEGISLATIVE_DATA_GROUPS_VL
    ) legisDataGroupsE0
WHERE gradeRatesE0.RATE_OBJECT_TYPE= 'GRADE'
AND gradeRatesE0.LEGISLATIVE_DATA_GROUP_ID = legisDataGroupsE0.LEGISLATIVE_DATA_GROUP_ID
AND (gradeRatesE0.ATTRIBUTE_CATEGORY IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE1 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE2 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE3 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE4 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE5 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE6 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE7 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE8 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE9 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE10 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE11 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE12 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE13 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE14 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE15 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE16 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE17 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE18 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE19 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE20 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE21 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE22 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE23 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE24 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE25 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE26 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE27 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE28 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE29 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE30 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER1 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER2 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER3 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER4 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER5 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER6 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER7 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER8 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER9 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER10 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER11 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER12 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER13 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER14 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER15 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER16 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER17 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER18 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER19 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_NUMBER20 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_DATE1 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_DATE2 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_DATE3 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_DATE4 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_DATE5 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_DATE6 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_DATE7 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_DATE8 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_DATE9 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_DATE10 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_DATE11 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_DATE12 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_DATE13 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_DATE14 IS NOT NULL OR
	gradeRatesE0.ATTRIBUTE_DATE15 IS NOT NULL)
ORDER BY legisDataGroupsE0.NAME
,gradeRatesE0.NAME
,gradeRatesE0.EFFECTIVE_START_DATE