/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Target%20Utilization%20Percentages%20-%20Target%20Utilization%20Percentages.sql $:
* $Id: Manage Target Utilization Percentages - Target Utilization Percentages.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT 	pjrEnterpriseOptionEO.ENTERPRISE_PERCENTAGE		RES_ENTERPRISE_TARGET_UTILIZAT
,pjrJobsEO.NAME											RES_JOB
,pjrUtilizationPerEO.UTILIZATION_PERCENTAGE     		RES_TARGET_UTILIZATION 
,pjrUtilizationPerEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pjrUtilizationPerEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pjrUtilizationPerEO.CREATED_BY  RSC_CREATED_BY
,pjrUtilizationPerEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJR_UTILIZATION_PERCENTAGE pjrUtilizationPerEO
,PER_JOBS_F_VL pjrJobsEO
,PJR_ENTERPRISE_IMPL_OPTION pjrEnterpriseOptionEO
WHERE pjrUtilizationPerEO.JOB_ID = pjrJobsEO.JOB_ID
AND pjrUtilizationPerEO.ENTERPRISE_ID = pjrEnterpriseOptionEO.ENTERPRISE_ID