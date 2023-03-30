/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Enterprise%20HCM%20Information%20-%20Enterprise%20Details%20-%20DFF.sql $:
 * $Id: Manage Enterprise HCM Information - Enterprise Details - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=800##RES##PER_ORGANIZATION_UNIT_DFF
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select TO_CHAR (OrganizationUnitDEO.EFFECTIVE_START_DATE, 'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,OrganizationUnitTranslationD1.NAME RES_NAME
,OrganizationUnitDEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,OrganizationUnitDEO.ATTRIBUTE1
,OrganizationUnitDEO.ATTRIBUTE2
,OrganizationUnitDEO.ATTRIBUTE3
,OrganizationUnitDEO.ATTRIBUTE4
,OrganizationUnitDEO.ATTRIBUTE5
,OrganizationUnitDEO.ATTRIBUTE6
,OrganizationUnitDEO.ATTRIBUTE7
,OrganizationUnitDEO.ATTRIBUTE8
,OrganizationUnitDEO.ATTRIBUTE9
,OrganizationUnitDEO.ATTRIBUTE10
,OrganizationUnitDEO.ATTRIBUTE11
,OrganizationUnitDEO.ATTRIBUTE12
,OrganizationUnitDEO.ATTRIBUTE13
,OrganizationUnitDEO.ATTRIBUTE14
,OrganizationUnitDEO.ATTRIBUTE15
,OrganizationUnitDEO.LAST_UPDATED_BY  as RSC_LAST_UPDATED_BY
,OrganizationUnitDEO.LAST_UPDATE_DATE  AS RSC_LAST_UPDATE_DATE
,OrganizationUnitDEO.CREATED_BY  RSC_CREATED_BY
,OrganizationUnitDEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,OrganizationUnitTranslationD1.ORGANIZATION_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM HR_ALL_ORGANIZATION_UNITS_F ORGANIZATIONUNITDEO ,		
HR_ORGANIZATION_UNITS_F_TL OrganizationUnitTranslationD1,		
HR_ORG_UNIT_CLASSIFICATIONS_F ORGUNITCLASSIFICATIONDEO ,
PER_ACTION_OCCURRENCES ACTIONOCCURRENCESEO 
where (OrganizationUnitDEO.ATTRIBUTE_CATEGORY IS NOT NULL OR
OrganizationUnitDEO.ATTRIBUTE1 IS NOT NULL OR 
OrganizationUnitDEO.ATTRIBUTE2 IS NOT NULL OR 
OrganizationUnitDEO.ATTRIBUTE3 IS NOT NULL OR 
OrganizationUnitDEO.ATTRIBUTE4 IS NOT NULL OR 
OrganizationUnitDEO.ATTRIBUTE5 IS NOT NULL OR 
OrganizationUnitDEO.ATTRIBUTE6 IS NOT NULL OR 
OrganizationUnitDEO.ATTRIBUTE7 IS NOT NULL OR 
OrganizationUnitDEO.ATTRIBUTE8 IS NOT NULL OR 
OrganizationUnitDEO.ATTRIBUTE9 IS NOT NULL OR 
OrganizationUnitDEO.ATTRIBUTE10 IS NOT NULL OR 
OrganizationUnitDEO.ATTRIBUTE11 IS NOT NULL OR 
OrganizationUnitDEO.ATTRIBUTE12 IS NOT NULL OR 
OrganizationUnitDEO.ATTRIBUTE13 IS NOT NULL OR 
OrganizationUnitDEO.ATTRIBUTE14 IS NOT NULL OR 
OrganizationUnitDEO.ATTRIBUTE15 IS NOT NULL
)
 AND ORGUNITCLASSIFICATIONDEO.CLASSIFICATION_CODE = 'ENTERPRISE'
	AND ( ( (OrganizationUnitDEO.ORGANIZATION_ID           = OrganizationUnitTranslationD1.ORGANIZATION_ID)
	AND (OrganizationUnitDEO.EFFECTIVE_START_DATE      = OrganizationUnitTranslationD1.EFFECTIVE_START_DATE)
	AND (OrganizationUnitDEO.EFFECTIVE_END_DATE        = OrganizationUnitTranslationD1.EFFECTIVE_END_DATE))
	AND OrganizationUnitTranslationD1.Language         = sys_context ('USERENV', 'LANG'))	
	AND ORGANIZATIONUNITDEO.ORGANIZATION_ID            = OrgUnitClassificationDEO.ORGANIZATION_ID
	/*AND (sysdate BETWEEN OrganizationUnitDEO.EFFECTIVE_START_DATE AND OrganizationUnitDEO.EFFECTIVE_END_DATE)	
	AND (sysdate BETWEEN OrganizationUnitTranslationD1.EFFECTIVE_START_DATE AND
		ORGANIZATIONUNITTRANSLATIOND1.EFFECTIVE_END_DATE)*/
	--AND (SYSDATE BETWEEN OrganizationUnitDEO.EFFECTIVE_START_DATE AND OrganizationUnitDEO.EFFECTIVE_END_DATE)
	AND (ORGANIZATIONUNITDEO.EFFECTIVE_START_DATE BETWEEN ORGUNITCLASSIFICATIONDEO.EFFECTIVE_START_DATE AND
		OrgUnitClassificationDEO.EFFECTIVE_END_DATE)	
	AND (ORGANIZATIONUNITDEO.ACTION_OCCURRENCE_ID = ACTIONOCCURRENCESEO.ACTION_OCCURRENCE_ID(+))
ORDER BY OrganizationUnitTranslationD1.name,OrganizationUnitDEO.EFFECTIVE_START_DATE