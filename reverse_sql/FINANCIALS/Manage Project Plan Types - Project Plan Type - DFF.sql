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
-- DFF_LOGIC_TO_APPLY=10039##RES##PJO_PLANNING_OPTIONS_DFF
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.

SELECT planTypesE0.NAME RES_NAME
,planOptionsE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,planOptionsE0.ATTRIBUTE1
,planOptionsE0.ATTRIBUTE2
,planOptionsE0.ATTRIBUTE3
,planOptionsE0.ATTRIBUTE4
,planOptionsE0.ATTRIBUTE5
,planOptionsE0.ATTRIBUTE6
,planOptionsE0.ATTRIBUTE7
,planOptionsE0.ATTRIBUTE8
,planOptionsE0.ATTRIBUTE9
,planOptionsE0.ATTRIBUTE10
,planOptionsE0.ATTRIBUTE11
,planOptionsE0.ATTRIBUTE12
,planOptionsE0.ATTRIBUTE13
,planOptionsE0.ATTRIBUTE14
,planOptionsE0.ATTRIBUTE15
,planOptionsE0.ATTRIBUTE16
,planOptionsE0.ATTRIBUTE17
,planOptionsE0.ATTRIBUTE18
,planOptionsE0.ATTRIBUTE19
,planOptionsE0.ATTRIBUTE20
,planOptionsE0.ATTRIBUTE21
,planOptionsE0.ATTRIBUTE22
,planOptionsE0.ATTRIBUTE23
,planOptionsE0.ATTRIBUTE24
,planOptionsE0.ATTRIBUTE25
,planOptionsE0.ATTRIBUTE26
,planOptionsE0.ATTRIBUTE27
,planOptionsE0.ATTRIBUTE28
,planOptionsE0.ATTRIBUTE29
,planOptionsE0.ATTRIBUTE30
,planOptionsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,planOptionsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,planOptionsE0.CREATED_BY  RSC_CREATED_BY
,planOptionsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJO_PLAN_TYPES_VL planTypesE0
,PJO_PLANNING_OPTIONS planOptionsE0
WHERE planTypesE0.PLAN_TYPE_CODE = 'PROJECT_PLAN'
AND planTypesE0.PLAN_TYPE_ID = planOptionsE0.PLAN_TYPE_ID
AND planOptionsE0.PROJECT_ID = 0
AND(planOptionsE0.ATTRIBUTE_CATEGORY IS NOT NULL
OR planOptionsE0.ATTRIBUTE1 IS NOT NULL
OR planOptionsE0.ATTRIBUTE2 IS NOT NULL
OR planOptionsE0.ATTRIBUTE3 IS NOT NULL
OR planOptionsE0.ATTRIBUTE4 IS NOT NULL
OR planOptionsE0.ATTRIBUTE5 IS NOT NULL
OR planOptionsE0.ATTRIBUTE6 IS NOT NULL
OR planOptionsE0.ATTRIBUTE7 IS NOT NULL
OR planOptionsE0.ATTRIBUTE8 IS NOT NULL
OR planOptionsE0.ATTRIBUTE9 IS NOT NULL
OR planOptionsE0.ATTRIBUTE10 IS NOT NULL
OR planOptionsE0.ATTRIBUTE11 IS NOT NULL
OR planOptionsE0.ATTRIBUTE12 IS NOT NULL
OR planOptionsE0.ATTRIBUTE13 IS NOT NULL
OR planOptionsE0.ATTRIBUTE14 IS NOT NULL
OR planOptionsE0.ATTRIBUTE15 IS NOT NULL
OR planOptionsE0.ATTRIBUTE16 IS NOT NULL
OR planOptionsE0.ATTRIBUTE17 IS NOT NULL
OR planOptionsE0.ATTRIBUTE18 IS NOT NULL
OR planOptionsE0.ATTRIBUTE19 IS NOT NULL
OR planOptionsE0.ATTRIBUTE20 IS NOT NULL
OR planOptionsE0.ATTRIBUTE21 IS NOT NULL
OR planOptionsE0.ATTRIBUTE22 IS NOT NULL
OR planOptionsE0.ATTRIBUTE23 IS NOT NULL
OR planOptionsE0.ATTRIBUTE24 IS NOT NULL
OR planOptionsE0.ATTRIBUTE25 IS NOT NULL
OR planOptionsE0.ATTRIBUTE26 IS NOT NULL
OR planOptionsE0.ATTRIBUTE27 IS NOT NULL
OR planOptionsE0.ATTRIBUTE28 IS NOT NULL
OR planOptionsE0.ATTRIBUTE29 IS NOT NULL
OR planOptionsE0.ATTRIBUTE30 IS NOT NULL)
ORDER BY planTypesE0.NAME