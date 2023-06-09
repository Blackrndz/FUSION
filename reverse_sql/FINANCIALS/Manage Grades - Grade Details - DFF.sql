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
-- DFF_LOGIC_TO_APPLY=800##RES##PER_GRADES_DF
-- DFF_ATTRIBUTES=ATTRIBUTE,ATTRIBUTE_DATE,ATTRIBUTE_NUMBER

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.

SELECT TO_CHAR(gradesE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,gradesE0.NAME RES_NAME
,gradesE0.GRADE_CODE RES_CODE
,gradesE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,gradesE0.ATTRIBUTE1,gradesE0.ATTRIBUTE2,gradesE0.ATTRIBUTE3,gradesE0.ATTRIBUTE4,gradesE0.ATTRIBUTE5
,gradesE0.ATTRIBUTE6,gradesE0.ATTRIBUTE7,gradesE0.ATTRIBUTE8,gradesE0.ATTRIBUTE9,gradesE0.ATTRIBUTE10
,gradesE0.ATTRIBUTE11,gradesE0.ATTRIBUTE12,gradesE0.ATTRIBUTE13,gradesE0.ATTRIBUTE14,gradesE0.ATTRIBUTE15
,gradesE0.ATTRIBUTE16,gradesE0.ATTRIBUTE17,gradesE0.ATTRIBUTE18,gradesE0.ATTRIBUTE19,gradesE0.ATTRIBUTE20
,gradesE0.ATTRIBUTE21,gradesE0.ATTRIBUTE22,gradesE0.ATTRIBUTE23,gradesE0.ATTRIBUTE24,gradesE0.ATTRIBUTE25
,gradesE0.ATTRIBUTE26,gradesE0.ATTRIBUTE27,gradesE0.ATTRIBUTE28,gradesE0.ATTRIBUTE29,gradesE0.ATTRIBUTE30
,gradesE0.ATTRIBUTE_NUMBER1,gradesE0.ATTRIBUTE_NUMBER2,gradesE0.ATTRIBUTE_NUMBER3,gradesE0.ATTRIBUTE_NUMBER4,gradesE0.ATTRIBUTE_NUMBER5
,gradesE0.ATTRIBUTE_NUMBER6,gradesE0.ATTRIBUTE_NUMBER7,gradesE0.ATTRIBUTE_NUMBER8,gradesE0.ATTRIBUTE_NUMBER9,gradesE0.ATTRIBUTE_NUMBER10
,gradesE0.ATTRIBUTE_NUMBER11,gradesE0.ATTRIBUTE_NUMBER12,gradesE0.ATTRIBUTE_NUMBER13,gradesE0.ATTRIBUTE_NUMBER14,gradesE0.ATTRIBUTE_NUMBER15
,gradesE0.ATTRIBUTE_NUMBER16,gradesE0.ATTRIBUTE_NUMBER17,gradesE0.ATTRIBUTE_NUMBER18,gradesE0.ATTRIBUTE_NUMBER19,gradesE0.ATTRIBUTE_NUMBER20
,gradesE0.ATTRIBUTE_DATE1,gradesE0.ATTRIBUTE_DATE2,gradesE0.ATTRIBUTE_DATE3,gradesE0.ATTRIBUTE_DATE4,gradesE0.ATTRIBUTE_DATE5
,gradesE0.ATTRIBUTE_DATE6,gradesE0.ATTRIBUTE_DATE7,gradesE0.ATTRIBUTE_DATE8,gradesE0.ATTRIBUTE_DATE9,gradesE0.ATTRIBUTE_DATE10
,gradesE0.ATTRIBUTE_DATE11,gradesE0.ATTRIBUTE_DATE12,gradesE0.ATTRIBUTE_DATE13,gradesE0.ATTRIBUTE_DATE14,gradesE0.ATTRIBUTE_DATE15
,gradesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,gradesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,gradesE0.CREATED_BY RSC_CREATED_BY
,gradesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,gradesE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM PER_GRADES_F_VL gradesE0
WHERE (gradesE0.ATTRIBUTE_CATEGORY IS NOT NULL OR
gradesE0.ATTRIBUTE1 IS NOT NULL OR 
gradesE0.ATTRIBUTE2 IS NOT NULL OR 
gradesE0.ATTRIBUTE3 IS NOT NULL OR 
gradesE0.ATTRIBUTE4 IS NOT NULL OR 
gradesE0.ATTRIBUTE5 IS NOT NULL OR 
gradesE0.ATTRIBUTE6 IS NOT NULL OR 
gradesE0.ATTRIBUTE7 IS NOT NULL OR 
gradesE0.ATTRIBUTE8 IS NOT NULL OR 
gradesE0.ATTRIBUTE9 IS NOT NULL OR 
gradesE0.ATTRIBUTE10 IS NOT NULL OR 
gradesE0.ATTRIBUTE11 IS NOT NULL OR 
gradesE0.ATTRIBUTE12 IS NOT NULL OR 
gradesE0.ATTRIBUTE13 IS NOT NULL OR 
gradesE0.ATTRIBUTE14 IS NOT NULL OR 
gradesE0.ATTRIBUTE15 IS NOT NULL OR
gradesE0.ATTRIBUTE16 IS NOT NULL OR 
gradesE0.ATTRIBUTE17 IS NOT NULL OR 
gradesE0.ATTRIBUTE18 IS NOT NULL OR 
gradesE0.ATTRIBUTE19 IS NOT NULL OR 
gradesE0.ATTRIBUTE20 IS NOT NULL OR
gradesE0.ATTRIBUTE21 IS NOT NULL OR 
gradesE0.ATTRIBUTE22 IS NOT NULL OR 
gradesE0.ATTRIBUTE23 IS NOT NULL OR 
gradesE0.ATTRIBUTE24 IS NOT NULL OR 
gradesE0.ATTRIBUTE25 IS NOT NULL OR 
gradesE0.ATTRIBUTE26 IS NOT NULL OR 
gradesE0.ATTRIBUTE27 IS NOT NULL OR 
gradesE0.ATTRIBUTE28 IS NOT NULL OR 
gradesE0.ATTRIBUTE29 IS NOT NULL OR 
gradesE0.ATTRIBUTE30 IS NOT NULL OR 
gradesE0.ATTRIBUTE_DATE1 IS NOT NULL OR 
gradesE0.ATTRIBUTE_DATE2 IS NOT NULL OR 
gradesE0.ATTRIBUTE_DATE3 IS NOT NULL OR 
gradesE0.ATTRIBUTE_DATE4 IS NOT NULL OR 
gradesE0.ATTRIBUTE_DATE5 IS NOT NULL OR 
gradesE0.ATTRIBUTE_DATE6 IS NOT NULL OR 
gradesE0.ATTRIBUTE_DATE7 IS NOT NULL OR 
gradesE0.ATTRIBUTE_DATE8 IS NOT NULL OR 
gradesE0.ATTRIBUTE_DATE9 IS NOT NULL OR 
gradesE0.ATTRIBUTE_DATE10 IS NOT NULL OR 
gradesE0.ATTRIBUTE_DATE11 IS NOT NULL OR 
gradesE0.ATTRIBUTE_DATE12 IS NOT NULL OR 
gradesE0.ATTRIBUTE_DATE13 IS NOT NULL OR 
gradesE0.ATTRIBUTE_DATE14 IS NOT NULL OR 
gradesE0.ATTRIBUTE_DATE15 IS NOT NULL OR 
gradesE0.ATTRIBUTE_NUMBER1 IS NOT NULL OR 
gradesE0.ATTRIBUTE_NUMBER2 IS NOT NULL OR 
gradesE0.ATTRIBUTE_NUMBER3 IS NOT NULL OR 
gradesE0.ATTRIBUTE_NUMBER4 IS NOT NULL OR 
gradesE0.ATTRIBUTE_NUMBER5 IS NOT NULL OR 
gradesE0.ATTRIBUTE_NUMBER6 IS NOT NULL OR 
gradesE0.ATTRIBUTE_NUMBER7 IS NOT NULL OR 
gradesE0.ATTRIBUTE_NUMBER8 IS NOT NULL OR 
gradesE0.ATTRIBUTE_NUMBER9 IS NOT NULL OR 
gradesE0.ATTRIBUTE_NUMBER10 IS NOT NULL OR
gradesE0.ATTRIBUTE_NUMBER11 IS NOT NULL OR 
gradesE0.ATTRIBUTE_NUMBER12 IS NOT NULL OR 
gradesE0.ATTRIBUTE_NUMBER13 IS NOT NULL OR 
gradesE0.ATTRIBUTE_NUMBER14 IS NOT NULL OR 
gradesE0.ATTRIBUTE_NUMBER15 IS NOT NULL OR 
gradesE0.ATTRIBUTE_NUMBER16 IS NOT NULL OR 
gradesE0.ATTRIBUTE_NUMBER17 IS NOT NULL OR 
gradesE0.ATTRIBUTE_NUMBER18 IS NOT NULL OR 
gradesE0.ATTRIBUTE_NUMBER19 IS NOT NULL OR 
gradesE0.ATTRIBUTE_NUMBER20 IS NOT NULL )
ORDER BY gradesE0.NAME
,gradesE0.GRADE_CODE
,gradesE0.EFFECTIVE_START_DATE