/* ****************************************************************************
 * $Revision: 61016 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2017-02-10 11:47:39 +0700 (Fri, 10 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Sources%20-%20Manage%20Transaction%20Sources.sql $:
 * $Id: Manage Transaction Sources - Manage Transaction Sources.sql 61016 2017-02-10 04:47:39Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 -- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=10037##RES##PJF_EXP_TYP_CLASS_LNKG_DESC_FLEX
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT expTypesE0.EXPENDITURE_TYPE_NAME RES_EXPENDITURE_TYPE
,(SELECT MEANING
	FROM PJF_SYSTEM_LINKAGES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND FUNCTION = SYSTEM_LINKAGE_FUNCTION
	) RES_NAME
,expTpyeClassesE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,expTpyeClassesE0.ATTRIBUTE1
,expTpyeClassesE0.ATTRIBUTE2
,expTpyeClassesE0.ATTRIBUTE3
,expTpyeClassesE0.ATTRIBUTE4
,expTpyeClassesE0.ATTRIBUTE5
,expTpyeClassesE0.ATTRIBUTE6
,expTpyeClassesE0.ATTRIBUTE7
,expTpyeClassesE0.ATTRIBUTE8
,expTpyeClassesE0.ATTRIBUTE9
,expTpyeClassesE0.ATTRIBUTE10
,expTpyeClassesE0.ATTRIBUTE11
,expTpyeClassesE0.ATTRIBUTE12
,expTpyeClassesE0.ATTRIBUTE13
,expTpyeClassesE0.ATTRIBUTE14
,expTpyeClassesE0.ATTRIBUTE15
,expTpyeClassesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,expTpyeClassesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,expTpyeClassesE0.CREATED_BY RSC_CREATED_BY
,expTpyeClassesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_EXP_TYPES_VL expTypesE0
,PJF_EXPEND_TYP_SYS_LINKS expTpyeClassesE0
WHERE expTypesE0.EXPENDITURE_TYPE_ID = expTpyeClassesE0.EXPENDITURE_TYPE_ID
AND (expTpyeClassesE0.ATTRIBUTE_CATEGORY IS NOT NULL OR
expTpyeClassesE0.ATTRIBUTE1 IS NOT NULL OR 
expTpyeClassesE0.ATTRIBUTE2 IS NOT NULL OR 
expTpyeClassesE0.ATTRIBUTE3 IS NOT NULL OR 
expTpyeClassesE0.ATTRIBUTE4 IS NOT NULL OR 
expTpyeClassesE0.ATTRIBUTE5 IS NOT NULL OR 
expTpyeClassesE0.ATTRIBUTE6 IS NOT NULL OR 
expTpyeClassesE0.ATTRIBUTE7 IS NOT NULL OR 
expTpyeClassesE0.ATTRIBUTE8 IS NOT NULL OR 
expTpyeClassesE0.ATTRIBUTE9 IS NOT NULL OR 
expTpyeClassesE0.ATTRIBUTE10 IS NOT NULL OR 
expTpyeClassesE0.ATTRIBUTE11 IS NOT NULL OR 
expTpyeClassesE0.ATTRIBUTE12 IS NOT NULL OR 
expTpyeClassesE0.ATTRIBUTE13 IS NOT NULL OR 
expTpyeClassesE0.ATTRIBUTE14 IS NOT NULL OR 
expTpyeClassesE0.ATTRIBUTE15 IS NOT NULL)
ORDER BY expTypesE0.EXPENDITURE_TYPE_NAME
,2