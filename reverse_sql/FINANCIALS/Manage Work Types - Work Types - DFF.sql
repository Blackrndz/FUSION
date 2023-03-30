/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Work%20Types%20-%20Work%20Types%20-%20DFF.sql $:
* $Id: Manage Work Types - Work Types - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=10037##RES##PJF_WORK_TYPES_DESC_FLEX
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for attributes fields.

SELECT pjfWorkTypeEO.NAME								RES_WORK_TYPE
,pjfWorkTypeEO.ATTRIBUTE_CATEGORY 						RES_CONTEXT_CODE
,pjfWorkTypeEO.ATTRIBUTE1
,pjfWorkTypeEO.ATTRIBUTE2
,pjfWorkTypeEO.ATTRIBUTE3
,pjfWorkTypeEO.ATTRIBUTE4
,pjfWorkTypeEO.ATTRIBUTE5
,pjfWorkTypeEO.ATTRIBUTE6
,pjfWorkTypeEO.ATTRIBUTE7
,pjfWorkTypeEO.ATTRIBUTE8
,pjfWorkTypeEO.ATTRIBUTE9
,pjfWorkTypeEO.ATTRIBUTE10
,pjfWorkTypeEO.ATTRIBUTE11
,pjfWorkTypeEO.ATTRIBUTE12
,pjfWorkTypeEO.ATTRIBUTE13
,pjfWorkTypeEO.ATTRIBUTE14
,pjfWorkTypeEO.ATTRIBUTE15
,pjfWorkTypeEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pjfWorkTypeEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pjfWorkTypeEO.CREATED_BY  RSC_CREATED_BY
,pjfWorkTypeEO.CREATION_DATE  RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSCT_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM PJF_WORK_TYPES_VL pjfWorkTypeEO
WHERE (pjfWorkTypeEO.ATTRIBUTE_CATEGORY IS NOT NULL
OR pjfWorkTypeEO.ATTRIBUTE1    IS NOT NULL
OR pjfWorkTypeEO.ATTRIBUTE2    IS NOT NULL
OR pjfWorkTypeEO.ATTRIBUTE3    IS NOT NULL
OR pjfWorkTypeEO.ATTRIBUTE4    IS NOT NULL
OR pjfWorkTypeEO.ATTRIBUTE5    IS NOT NULL
OR pjfWorkTypeEO.ATTRIBUTE6    IS NOT NULL
OR pjfWorkTypeEO.ATTRIBUTE7    IS NOT NULL
OR pjfWorkTypeEO.ATTRIBUTE8    IS NOT NULL
OR pjfWorkTypeEO.ATTRIBUTE9    IS NOT NULL
OR pjfWorkTypeEO.ATTRIBUTE10   IS NOT NULL
OR pjfWorkTypeEO.ATTRIBUTE11   IS NOT NULL
OR pjfWorkTypeEO.ATTRIBUTE12   IS NOT NULL
OR pjfWorkTypeEO.ATTRIBUTE13   IS NOT NULL
OR pjfWorkTypeEO.ATTRIBUTE14   IS NOT NULL
OR pjfWorkTypeEO.ATTRIBUTE15   IS NOT NULL
)
ORDER BY pjfWorkTypeEO.NAME

