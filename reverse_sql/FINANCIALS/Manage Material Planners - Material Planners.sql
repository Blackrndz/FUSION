/* ****************************************************************************
 * $Revision: 54470 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2016-04-19 10:52:05 +0700 (Tue, 19 Apr 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Contact%20Point%20Lookups%20-%20Lookup%20Codes.sql $:
 * $Id: Manage Contact Point Lookups - Lookup Codes.sql 54470 2016-04-19 03:52:05Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=MSC_PLANNERS
 
SELECT (SELECT INSTANCE_CODE
	FROM MSC_APPS_INSTANCES
	WHERE INSTANCE_ID = MaterialPlannersE0.SR_INSTANCE_ID
	) RES_SOURCE_SYSTEM
,MaterialPlannersE0.PLANNER_CODE RES_NAME
,MaterialPlannersE0.DESCRIPTION RES_MATERIAL_PLANNER_DESCRIPTI
,PersonsE0.FULL_NAME RES_EMPLOYEE_NAME
,PersonsE0.DEPT_NAME RES_EMPLOYEE_DEPARTMENT
,PersonsE0.JOB_NAME RES_EMPLOYEE_JOB
,PersonsE0.EMAIL_ADDRESS RES_EMPLOYEE_E_MAIL
,MaterialPlannersE0.ELECTRONIC_MAIL_ADDRESS RES_E_MAIL
,TO_CHAR(MaterialPlannersE0.DISABLE_DATE,'DD-Mon-YYYY') RES_DISABLED_DATE
,MaterialPlannersE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,MaterialPlannersE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,MaterialPlannersE0.CREATED_BY RSC_CREATED_BY
,MaterialPlannersE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_PLANNERS MaterialPlannersE0
,(SELECT PersonsE0.PERSON_ID
	,PersonsE0.FULL_NAME 
	,DepartmentDPEO.NAME DEPT_NAME
	,JobDPEO.NAME JOB_NAME
	,Email.EMAIL_ADDRESS
	FROM PER_PERSON_NAMES_F PersonsE0
	,PER_ALL_ASSIGNMENTS_M PerAssignE0
	,(SELECT NAME
		,ORGANIZATION_ID
		FROM PER_DEPARTMENTS
		WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
		) DepartmentDPEO
	,(SELECT NAME
		,JOB_ID
		FROM PER_JOBS_F_VL 
		WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
		) JobDPEO
	,PER_EMAIL_ADDRESSES Email
	WHERE PersonsE0.NAME_TYPE = 'GLOBAL'
	AND PersonsE0.PERSON_ID = PerAssignE0.PERSON_ID
	AND PerAssignE0.ORGANIZATION_ID = DepartmentDPEO.ORGANIZATION_ID(+)
	AND PerAssignE0.JOB_ID = JobDPEO.JOB_ID(+)
	AND PersonsE0.PERSON_ID = Email.PERSON_ID(+)
	AND PerAssignE0.PRIMARY_FLAG = 'Y'
	) PersonsE0
WHERE MaterialPlannersE0.EMPLOYEE_ID = PersonsE0.PERSON_ID(+)
ORDER BY 1,2