/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Job%20-%20Evaluation%20Criteria.sql $:
 * $Id: Manage Job - Evaluation Criteria.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

select JOBDEO.name RES_NAME
,JOBDEO.JOB_CODE RES_CODE
,TO_CHAR(JOBDEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY')  RES_EFFECTIVE_START_DATE
,TO_CHAR(JOBDEO.EFFECTIVE_END_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,(select HcmLookupPEO.MEANING from HCM_LOOKUPS HCMLOOKUPPEO where  HCMLOOKUPPEO.LOOKUP_TYPE    = 'EVAL_SYSTEM' and HcmLookupPEO.LOOKUP_CODE = EVALUATIONEO.EVALUATION_SYSTEM) RES_EVALUATION_SYSTEM
,TO_CHAR(EVALUATIONEO.DATE_EVALUATED,'DD-Mon-YYYY')  RES_EVALUATION_DATE
,(select HcmLookupPEO.MEANING from HCM_LOOKUPS HCMLOOKUPPEO where  HCMLOOKUPPEO.LOOKUP_TYPE    = 'EVAL_SYSTEM_MEAS' and HcmLookupPEO.LOOKUP_CODE = EVALUATIONEO.MEASURED_IN) RES_MEASUREMENT_UNIT
,EVALUATIONEO.KNOWHOW RES_KNOW_HOW
,EVALUATIONEO.ACCOUNTABILITY RES_ACCOUNTABILITY
,EvaluationEO.PROBLEM_SOLVING RES_PROBLEM_SOLVING
,EvaluationEO.OVERALL_SCORE RES_OVERALL_SCORE

,EVALUATIONEO.LAST_UPDATED_BY as RSC_LAST_UPDATED_BY
,EVALUATIONEO.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
,EVALUATIONEO.CREATED_BY  RSC_CREATED_BY
,EVALUATIONEO.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID
    
from PER_JOBS_F_VL JOBDEO
,PER_JOB_EVALUATIONS EVALUATIONEO
where JOBDEO.JOB_ID  		= EVALUATIONEO.JOB_ID
order by JOBDEO.name,JOBDEO.JOB_CODE,JOBDEO.EFFECTIVE_START_DATE