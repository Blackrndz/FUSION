/* ****************************************************************************
 * $Revision: 78229 $:
 * $AuthIS NOT NULL or: wuttipong.thongvises $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Resource%20Roles%20-%20Roles%20-%20DFF.sql $:
 * $Id: Manage Resource Roles - Roles - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=10024##RES##JTF_RS_ROLES_B
-- DFF_ATTRIBUTES=ATTRIBUTE,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE

-- IMPIS NOT NULL orTANT:
-- - the alias names fIS NOT NULL or the FIS NOT NULL oreign keys must be the same as in the inventIS NOT NULL ory.
-- - the alias name fIS NOT NULL or context code must be RES_CONTEXT_CODE
-- - NO ALIASES fIS NOT NULL or atributes fields.

 
SELECT RESOURCEROLE.ROLE_NAME RES_ROLE_NAME
,RESOURCEROLE.ROLE_CODE RES_ROLE_CODE
,RESOURCEROLE.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,RESOURCEROLE.ATTRIBUTE1 
,RESOURCEROLE.ATTRIBUTE2
,RESOURCEROLE.ATTRIBUTE3
,RESOURCEROLE.ATTRIBUTE4
,RESOURCEROLE.ATTRIBUTE5
,RESOURCEROLE.ATTRIBUTE6
,RESOURCEROLE.ATTRIBUTE7
,RESOURCEROLE.ATTRIBUTE8
,RESOURCEROLE.ATTRIBUTE9
,RESOURCEROLE.ATTRIBUTE10
,RESOURCEROLE.ATTRIBUTE11
,RESOURCEROLE.ATTRIBUTE12
,RESOURCEROLE.ATTRIBUTE13
,RESOURCEROLE.ATTRIBUTE14
,RESOURCEROLE.ATTRIBUTE15
,RESOURCEROLE.ATTRIBUTE16 
,RESOURCEROLE.ATTRIBUTE17
,RESOURCEROLE.ATTRIBUTE18
,RESOURCEROLE.ATTRIBUTE19
,RESOURCEROLE.ATTRIBUTE20
,RESOURCEROLE.ATTRIBUTE21
,RESOURCEROLE.ATTRIBUTE22
,RESOURCEROLE.ATTRIBUTE23
,RESOURCEROLE.ATTRIBUTE24
,RESOURCEROLE.ATTRIBUTE25
,RESOURCEROLE.ATTRIBUTE26
,RESOURCEROLE.ATTRIBUTE27
,RESOURCEROLE.ATTRIBUTE28
,RESOURCEROLE.ATTRIBUTE29
,RESOURCEROLE.ATTRIBUTE30
,RESOURCEROLE.ATTRIBUTE_NUMBER1 
,RESOURCEROLE.ATTRIBUTE_NUMBER2
,RESOURCEROLE.ATTRIBUTE_NUMBER3
,RESOURCEROLE.ATTRIBUTE_NUMBER4
,RESOURCEROLE.ATTRIBUTE_NUMBER5
,RESOURCEROLE.ATTRIBUTE_NUMBER6
,RESOURCEROLE.ATTRIBUTE_NUMBER7
,RESOURCEROLE.ATTRIBUTE_NUMBER8
,RESOURCEROLE.ATTRIBUTE_NUMBER9
,RESOURCEROLE.ATTRIBUTE_NUMBER10
,RESOURCEROLE.ATTRIBUTE_NUMBER11
,RESOURCEROLE.ATTRIBUTE_NUMBER12
, TO_CHAR(RESOURCEROLE.ATTRIBUTE_DATE1, 'DD-Mon-YYYY') ATTRIBUTE_DATE1
, TO_CHAR(RESOURCEROLE.ATTRIBUTE_DATE2, 'DD-Mon-YYYY') ATTRIBUTE_DATE2
, TO_CHAR(RESOURCEROLE.ATTRIBUTE_DATE3, 'DD-Mon-YYYY') ATTRIBUTE_DATE3
, TO_CHAR(RESOURCEROLE.ATTRIBUTE_DATE4, 'DD-Mon-YYYY') ATTRIBUTE_DATE4
, TO_CHAR(RESOURCEROLE.ATTRIBUTE_DATE5, 'DD-Mon-YYYY') ATTRIBUTE_DATE5
, TO_CHAR(RESOURCEROLE.ATTRIBUTE_DATE6, 'DD-Mon-YYYY') ATTRIBUTE_DATE6
, TO_CHAR(RESOURCEROLE.ATTRIBUTE_DATE7, 'DD-Mon-YYYY') ATTRIBUTE_DATE7
, TO_CHAR(RESOURCEROLE.ATTRIBUTE_DATE8, 'DD-Mon-YYYY') ATTRIBUTE_DATE8
, TO_CHAR(RESOURCEROLE.ATTRIBUTE_DATE9, 'DD-Mon-YYYY') ATTRIBUTE_DATE9
, TO_CHAR(RESOURCEROLE.ATTRIBUTE_DATE10, 'DD-Mon-YYYY') ATTRIBUTE_DATE10
, TO_CHAR(RESOURCEROLE.ATTRIBUTE_DATE11, 'DD-Mon-YYYY') ATTRIBUTE_DATE11
, TO_CHAR(RESOURCEROLE.ATTRIBUTE_DATE12, 'DD-Mon-YYYY') ATTRIBUTE_DATE12
,RESOURCEROLE.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,RESOURCEROLE.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,RESOURCEROLE.CREATED_BY RSC_CREATED_BY
,RESOURCEROLE.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM JTF_RS_ROLES_VL RESOURCEROLE
where (RESOURCEROLE.ATTRIBUTE_CATEGORY   IS NOT NULL or
RESOURCEROLE.ATTRIBUTE1 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE2 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE3 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE4 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE5 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE6 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE7 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE8 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE9 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE10 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE11 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE12 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE13 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE14 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE15 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE16 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE17 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE18 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE19 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE20 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE21 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE22 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE23 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE24 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE25 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE26 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE27 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE28 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE29 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE30 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_NUMBER1 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_NUMBER2 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_NUMBER3 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_NUMBER4 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_NUMBER5 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_NUMBER6 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_NUMBER7 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_NUMBER8 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_NUMBER9 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_NUMBER10 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_NUMBER11 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_NUMBER12 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_DATE1 IS NOT NULL or 
RESOURCEROLE.ATTRIBUTE_DATE2 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_DATE3 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_DATE4 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_DATE5 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_DATE6 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_DATE7 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_DATE8 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_DATE9 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_DATE10 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_DATE11 IS NOT NULL or
RESOURCEROLE.ATTRIBUTE_DATE12 IS NOT NULL)
order by  RESOURCEROLE.ROLE_NAME