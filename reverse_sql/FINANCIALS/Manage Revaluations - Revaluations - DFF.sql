/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $glrevaluationURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Revaluations%20-%20Revaluations.sql $:
 * $Id: Manage Revaluations - Revaluations - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 -- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=101##RES##GL_REVALUATIONS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.
 
SELECT glrevaluation.NAME AS RES_NAME
,glrevaluation.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,glrevaluation.ATTRIBUTE1
,glrevaluation.ATTRIBUTE2
,glrevaluation.ATTRIBUTE3
,glrevaluation.ATTRIBUTE4
,glrevaluation.ATTRIBUTE5
,glrevaluation.ATTRIBUTE6
,glrevaluation.ATTRIBUTE7
,glrevaluation.ATTRIBUTE8
,glrevaluation.ATTRIBUTE9
,glrevaluation.ATTRIBUTE10
,glrevaluation.ATTRIBUTE11
,glrevaluation.ATTRIBUTE12
,glrevaluation.ATTRIBUTE13
,glrevaluation.ATTRIBUTE14
,glrevaluation.ATTRIBUTE15
,glrevaluation.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,glrevaluation.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,glrevaluation.CREATED_BY RSC_CREATED_BY
,glrevaluation.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,glrevaluation.CHART_OF_ACCOUNTS_ID RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GL_REVALUATIONS glrevaluation
WHERE (glrevaluation.ATTRIBUTE_CATEGORY IS NOT NULL
OR glrevaluation.ATTRIBUTE1            IS NOT NULL
OR glrevaluation.ATTRIBUTE2            IS NOT NULL
OR glrevaluation.ATTRIBUTE3            IS NOT NULL
OR glrevaluation.ATTRIBUTE4            IS NOT NULL
OR glrevaluation.ATTRIBUTE5            IS NOT NULL
OR glrevaluation.ATTRIBUTE6            IS NOT NULL
OR glrevaluation.ATTRIBUTE7            IS NOT NULL
OR glrevaluation.ATTRIBUTE8            IS NOT NULL
OR glrevaluation.ATTRIBUTE9            IS NOT NULL
OR glrevaluation.ATTRIBUTE10           IS NOT NULL
OR glrevaluation.ATTRIBUTE11           IS NOT NULL
OR glrevaluation.ATTRIBUTE12           IS NOT NULL
OR glrevaluation.ATTRIBUTE13           IS NOT NULL
OR glrevaluation.ATTRIBUTE14           IS NOT NULL
OR glrevaluation.ATTRIBUTE15           IS NOT NULL)
ORDER BY RES_NAME