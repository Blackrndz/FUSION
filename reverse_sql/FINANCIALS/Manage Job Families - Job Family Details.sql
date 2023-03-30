/* ****************************************************************************
 * $Revision: 49069 $:
 * $Author: Pisan.Jariyasettachok $:
 * $Date: 2015-09-01 17:23:38 +0700 (Tue, 01 Sep 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Manage%20Shifts.sql $:
 * $Id: Manage Facility Shifts - Manage Shifts.sql 49069 2015-09-01 10:23:38Z Pisan.Jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 -- RSC_PREREQUISITE_OBJECTS=PER_JOB_FAMILY_F
 
 SELECT TO_CHAR(JobFamilyDEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY')      AS RES_EFFECTIVE_START_DATE,
  JobFamilyTranslationEO.JOB_FAMILY_NAME                             AS RES_NAME,
  JobFamilyDEO.JOB_FAMILY_CODE RES_CODE,
  ActionReasons0.Action_Reason                                       AS RES_ACTION_REASON,
  DECODE(JobFamilyDEO.Active_status, 'A', 'Active', 'I', 'Inactive') AS RES_STATUS
  ,JobFamilyDEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,JobFamilyDEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,JobFamilyDEO.CREATED_BY  RSC_CREATED_BY
  ,JobFamilyDEO.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,JobFamilyDEO.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_JOB_FAMILY_F JobFamilyDEO,
  PER_JOB_FAMILY_F_TL JobFamilyTranslationEO,
  PER_ACTION_OCCURRENCES ActionOccurrences0,
  PER_ACTION_REASONS_VL ActionReasons0
WHERE JobFamilyDEO.JOB_FAMILY_ID        = JobFamilyTranslationEO.JOB_FAMILY_ID
AND JobFamilyTranslationEO.Language     = sys_context('userenv','LANG')
AND JobFamilyDEO.EFFECTIVE_START_DATE   =JobFamilyTranslationEO.EFFECTIVE_START_DATE
AND JobFamilyDEO.EFFECTIVE_END_DATE     =JobFamilyTranslationEO.EFFECTIVE_END_DATE
AND JobFamilyDEO.Action_Occurrence_ID   = ActionOccurrences0.Action_Occurrence_ID
AND ActionOccurrences0.Action_Reason_ID = ActionReasons0.Action_Reason_ID(+)
--AND SYSDATE BETWEEN JobFamilyDEO.EFFECTIVE_START_DATE AND NVL(JobFamilyDEO.EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
ORDER BY JobFamilyTranslationEO.JOB_FAMILY_NAME,JobFamilyDEO.JOB_FAMILY_CODE,JobFamilyDEO.EFFECTIVE_START_DATE