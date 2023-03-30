/* ****************************************************************************
* $Revision: 59053 $:
* $Author: nasrullah.dusenmahamad $:
* $Date: 2016-10-20 13:59:22 +0700 (Wed, 19 Oct 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Time%20Shift.sql $:
* $Id: Manage Buyer Assignment Rule Sets Lookup - Lookup Codes.sql 59053 2016-10-19 06:59:22Z nasrullah.dusenmahamad $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=0##RES##FND_LOOKUP_VALUES_B
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT LookupValueE0.LOOKUP_TYPE RES_LOOKUP_TYPE
,LookupValueE0.LOOKUP_CODE RES_LOOKUP_CODE
,LookupValueE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,LookupValueE0.ATTRIBUTE1
,LookupValueE0.ATTRIBUTE2
,LookupValueE0.ATTRIBUTE3
,LookupValueE0.ATTRIBUTE4
,LookupValueE0.ATTRIBUTE5
,LookupValueE0.ATTRIBUTE6
,LookupValueE0.ATTRIBUTE7
,LookupValueE0.ATTRIBUTE8
,LookupValueE0.ATTRIBUTE9
,LookupValueE0.ATTRIBUTE10
,LookupValueE0.ATTRIBUTE11
,LookupValueE0.ATTRIBUTE12
,LookupValueE0.ATTRIBUTE13
,LookupValueE0.ATTRIBUTE14
,LookupValueE0.ATTRIBUTE15
,LookupValueE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LookupValueE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,LookupValueE0.CREATED_BY RSC_CREATED_BY
,LookupValueE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_LOOKUP_TYPES_VL LookupTypeEO
,FND_APPL_TAXONOMY_VL ApplTaxonomyPEO
,FND_LOOKUP_VALUES_VL LookupValueE0
WHERE LookupTypeEO.MODULE_ID         = ApplTaxonomyPEO.MODULE_ID
AND LookupTypeEO.VIEW_APPLICATION_ID = 0
AND LookupTypeEO.VIEW_APPLICATION_ID = LookupValueE0.VIEW_APPLICATION_ID
AND LookupTypeEO.LOOKUP_TYPE         = LookupValueE0.LOOKUP_TYPE
AND(LookupTypeEO.MODULE_ID          IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	WHERE at.module_type = 'APPLICATION'
	AND at.module_key    = 'QP'
	AND at.module_id     = rf.ancestor_module_id
	))
AND(LookupValueE0.ATTRIBUTE_CATEGORY IS NOT NULL
OR LookupValueE0.ATTRIBUTE1          IS NOT NULL
OR LookupValueE0.ATTRIBUTE2          IS NOT NULL
OR LookupValueE0.ATTRIBUTE3          IS NOT NULL
OR LookupValueE0.ATTRIBUTE4          IS NOT NULL
OR LookupValueE0.ATTRIBUTE5          IS NOT NULL
OR LookupValueE0.ATTRIBUTE6          IS NOT NULL
OR LookupValueE0.ATTRIBUTE7          IS NOT NULL
OR LookupValueE0.ATTRIBUTE8          IS NOT NULL
OR LookupValueE0.ATTRIBUTE9          IS NOT NULL
OR LookupValueE0.ATTRIBUTE10         IS NOT NULL
OR LookupValueE0.ATTRIBUTE11         IS NOT NULL
OR LookupValueE0.ATTRIBUTE12         IS NOT NULL
OR LookupValueE0.ATTRIBUTE13         IS NOT NULL
OR LookupValueE0.ATTRIBUTE14         IS NOT NULL
OR LookupValueE0.ATTRIBUTE15         IS NOT NULL)
ORDER BY LookupValueE0.LOOKUP_TYPE
,LookupValueE0.DISPLAY_SEQUENCE
,LookupValueE0.LOOKUP_CODE