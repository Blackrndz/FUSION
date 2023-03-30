/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2018-04-19 $:
* $HeadURL: 
* $Id: Manage Demand Planners - Demand Planners.sql 
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=MSC_PLANNERS


select (SELECT INSTANCE_CODE
	FROM MSC_APPS_INSTANCES
	WHERE INSTANCE_ID = PLANNER.SR_INSTANCE_ID
	) RES_SOURCE_SYSTEM
,PLANNER_CODE                                                                   RES_NAME
,DESCRIPTION                                                                    RES_MATERIAL_PLANNER_DESCRIPTI
,PersonsE0.FULL_NAME                                                                    RES_EMPLOYEE_NAME
,PersonsE0.DEPT_NAME                                                            RES_EMPLOYEE_DEPARTMENT
,PersonsE0.JOB_NAME                                                             RES_EMPLOYEE_JOB
,PersonsE0.EMAIL_ADDRESS                                                        RES_EMPLOYEE_E_MAIL
,ELECTRONIC_MAIL_ADDRESS                                                        RES_E_MAIL
,TO_CHAR(DISABLE_DATE ,'DD-Mon-YYYY')                                           RES_DISABLED_DATE
,PLANNER.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,PLANNER.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,PLANNER.CREATED_BY RSC_CREATED_BY
,PLANNER.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


from MSC_PLANNERS  PLANNER

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

WHERE PLANNER.EMPLOYEE_ID = PersonsE0.PERSON_ID(+)