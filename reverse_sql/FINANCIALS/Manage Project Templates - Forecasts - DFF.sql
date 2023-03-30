/* ****************************************************************************
 * $Revision: 78693 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-06-07 17:22:14 +0700 (Tue, 07 Jun 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Templates%20-%20Forecasts%20-%20DFF.sql $:
 * $Id: Manage Project Templates - Forecasts - DFF.sql 78693 2022-06-07 10:22:14Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=10039##RES##PJO_PLANNING_OPTIONS_DFF
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT projTemplatesE0.NAME RES_TEMPLATE_NAME
,projTemplatesE0.SEGMENT1 RES_TEMPLATE_NUMBER
,budgetsE0.VERSION_NAME RES_NAME
,planningOptionsE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE

,planningOptionsE0.ATTRIBUTE1 
,planningOptionsE0.ATTRIBUTE2
,planningOptionsE0.ATTRIBUTE3
,planningOptionsE0.ATTRIBUTE4
,planningOptionsE0.ATTRIBUTE5
,planningOptionsE0.ATTRIBUTE6
,planningOptionsE0.ATTRIBUTE7
,planningOptionsE0.ATTRIBUTE8
,planningOptionsE0.ATTRIBUTE9
,planningOptionsE0.ATTRIBUTE10
,planningOptionsE0.ATTRIBUTE11
,planningOptionsE0.ATTRIBUTE12
,planningOptionsE0.ATTRIBUTE13
,planningOptionsE0.ATTRIBUTE14
,planningOptionsE0.ATTRIBUTE15
,planningOptionsE0.ATTRIBUTE16
,planningOptionsE0.ATTRIBUTE17
,planningOptionsE0.ATTRIBUTE18
,planningOptionsE0.ATTRIBUTE19 
,planningOptionsE0.ATTRIBUTE20 
,planningOptionsE0.ATTRIBUTE21 
,planningOptionsE0.ATTRIBUTE22 
,planningOptionsE0.ATTRIBUTE23 
,planningOptionsE0.ATTRIBUTE24 
,planningOptionsE0.ATTRIBUTE25 
,planningOptionsE0.ATTRIBUTE26 
,planningOptionsE0.ATTRIBUTE27 
,planningOptionsE0.ATTRIBUTE28 
,planningOptionsE0.ATTRIBUTE29 
,planningOptionsE0.ATTRIBUTE30

,budgetsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,budgetsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,budgetsE0.CREATED_BY  RSC_CREATED_BY
,budgetsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,projTemplatesE0.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_PROJECTS_ALL_VL projTemplatesE0
,FUN_ALL_BUSINESS_UNITS_V buE0
,PJO_PLAN_VERSIONS_VL budgetsE0
,PJO_PLANNING_OPTIONS planningOptionsE0
WHERE projTemplatesE0.TEMPLATE_FLAG = 'Y'
AND projTemplatesE0.ORG_ID = buE0.BU_ID
AND projTemplatesE0.PROJECT_ID = budgetsE0.PROJECT_ID
AND budgetsE0.PLAN_CLASS_CODE = 'FORECAST'
AND budgetsE0.STRUCTURE_VERSION_ID IS NULL
AND budgetsE0.PLAN_VERSION_ID = planningOptionsE0.PLAN_VERSION_ID
AND planningOptionsE0.PLAN_TYPE_CODE = 'FINANCIAL_PLAN'

AND (planningOptionsE0.ATTRIBUTE_CATEGORY IS NOT NULL OR
planningOptionsE0.ATTRIBUTE1 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE2 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE3 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE4 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE5 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE6 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE7 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE8 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE9 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE10 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE11 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE12 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE13 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE14 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE15 IS NOT NULL OR
planningOptionsE0.ATTRIBUTE16 IS NOT NULL OR
planningOptionsE0.ATTRIBUTE17 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE18 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE19 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE20 IS NOT NULL OR
planningOptionsE0.ATTRIBUTE21 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE22 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE23 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE24 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE25 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE26 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE27 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE28 IS NOT NULL OR 
planningOptionsE0.ATTRIBUTE29 IS NOT NULL OR
planningOptionsE0.ATTRIBUTE30 IS NOT NULL)

ORDER BY projTemplatesE0.NAME
,budgetsE0.VERSION_NAME