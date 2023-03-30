/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Resource%20Roles%20-%20Job%20Mapping.sql $:
 * $Id: Manage Resource Roles - Job Mapping.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT RESOURCEROLE.ROLE_NAME RES_ROLE_NAME
,RESOURCEROLE.ROLE_CODE RES_ROLE_CODE
,SetIdSetPEO.SET_NAME RES_SET
,JobDPEO.JOB_CODE RES_CODE
,JobDPEO.NAME RES_JOB
,ResourceJobRole.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ResourceJobRole.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ResourceJobRole.CREATED_BY RSC_CREATED_BY
,ResourceJobRole.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM JTF_RS_ROLES_VL RESOURCEROLE
,JTF_RS_JOB_ROLES ResourceJobRole
,PER_JOBS_F_VL JobDPEO
,FND_SETID_SETS_VL SETIDSETPEO
WHERE  RESOURCEROLE.ROLE_ID =  ResourceJobRole.ROLE_ID 
and (ResourceJobRole.JOB_ID = JobDPEO.JOB_ID)
AND(JobDPEO.SET_ID           = SetIdSetPEO.SET_ID)
AND(SYSDATE BETWEEN JOBDPEO.EFFECTIVE_START_DATE AND JOBDPEO.EFFECTIVE_END_DATE)
order by RESOURCEROLE.ROLE_NAME,RESOURCEROLE.ROLE_CODE