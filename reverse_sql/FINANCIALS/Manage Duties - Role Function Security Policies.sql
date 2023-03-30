 /* ****************************************************************************
 * $Revision: 48884 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2015-08-18 14:24:02 +0700 (Tue, 18 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Types%20-%20Manage%20Transaction%20Types.sql $:
 * $Id: Manage Transaction Types - Manage Transaction Types.sql 48884 2015-08-18 07:24:02Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=ASE_APP_ROLE_VL

SELECT DutyRolesE0.ROLE_NAME RES_ROLE_NAME
,DutyRolesE0.CODE RES_ROLE_CODE
,PrivilegesE0.NAME RES_PRIVILEGE_NAME
,PrivilegesE0.CODE RES_PRIVILEGE_CODE
,'' RES_INHERITED_FROM_ROLE
,PrivilegesE0.DESCRIPTION RES_DESCRIPTION
-- Add decode the Created and Updated users due to this task alway update based on the sync for all record at once
,DECODE(DutyRolesE0.IS_SEEDED,'Y','SEED_DATA_FROM_APPLICATION',DutyPrivilegesE0.LAST_UPDATED_BY)  RSC_LAST_UPDATED_BY
,DutyPrivilegesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
-- Add decode the Created and Updated users due to this task alway update based on the sync for all record at once
,DECODE(DutyRolesE0.IS_SEEDED,'Y','SEED_DATA_FROM_APPLICATION',DutyPrivilegesE0.CREATED_BY)  RSC_CREATED_BY
,DutyPrivilegesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ASE_ROLE_VL DutyRolesE0
,ASE_PRIV_ROLE_MBR DutyPrivilegesE0
,ASE_PRIVILEGE_VL PrivilegesE0
WHERE DutyRolesE0.ROLE_ID = DutyPrivilegesE0.ROLE_ID
AND DutyPrivilegesE0.PRIVILEGE_ID = PrivilegesE0.PRIVILEGE_ID
AND SYSDATE BETWEEN DutyRolesE0.EFFECTIVE_START_DATE AND NVL(DutyRolesE0.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
ORDER BY DutyRolesE0.ROLE_NAME
,PrivilegesE0.NAME