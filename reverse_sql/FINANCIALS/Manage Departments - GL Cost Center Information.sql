/* ****************************************************************************
* $Revision: 78540 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-05-19 18:03:15 +0700 (Thu, 19 May 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Departments%20-%20GL%20Cost%20Center%20Information.sql $:
* $Id: Manage Departments - GL Cost Center Information.sql 78540 2022-05-19 11:03:15Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


select TO_CHAR(ORGANIZATIONUNITDEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') as RES_EFFECTIVE_START_DATE
,OrganizationUnitTranslationD1.NAME                                    AS RES_NAME
,(
	CASE
		WHEN EXISTS
			(SELECT NULL
			FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO2
			WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE != 'DEPARTMENT'
			AND OrganizationUnitDEO.ORGANIZATION_ID              = OrgUnitClassificationDEO2.ORGANIZATION_ID
			AND EXISTS
				(SELECT NULL
				FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO3
				WHERE OrgUnitClassificationDEO3.CLASSIFICATION_CODE = 'DEPARTMENT'
				AND OrgUnitClassificationDEO2.ORGANIZATION_ID       = OrgUnitClassificationDEO3.ORGANIZATION_ID
				AND OrgUnitClassificationDEO3.creation_date         > orgUnitClassificationDEO2.creation_date
				)
			)
		THEN
			(SELECT CLASSIFICATION_NAME
			FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO2
			,HR_ORG_CLASSIFICATIONS_VL OrgClassificationEO2
			WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE != 'DEPARTMENT'
			AND OrgUnitClassificationDEO2.CLASSIFICATION_CODE    = OrgClassificationEO2.CLASSIFICATION_CODE
			AND OrganizationUnitDEO.ORGANIZATION_ID              = OrgUnitClassificationDEO2.ORGANIZATION_ID
			AND rownum                                          <= 1
			)
		else null
	END) AS RES_CLASSIFICATION
,OrgInformationEFFDEO.ORG_INFORMATION7 RES_RECORD_IDENTIFIER
,(SELECT flex_value_set_name
	FROM fnd_flex_value_sets
	WHERE TO_CHAR(flex_value_set_id) =OrgInformationEFFDEO.ORG_INFORMATION2
	and rownum      = 1) as RES_COMPANY_VALUE_SET
,ORGINFORMATIONEFFDEO.ORG_INFORMATION3 as RES_COMPANY
,
	(SELECT vs.flex_value_set_name
	FROM fnd_flex_value_sets vs
	WHERE TO_CHAR(vs.flex_value_set_id) = OrgInformationEFFDEO.ORG_INFORMATION4
	and rownum                          = 1
	) as RES_COST_CENTER_VALUE_SET
,ORGINFORMATIONEFFDEO.ORG_INFORMATION1 as RES_COST_CENTER
,(
	(SELECT ppn.list_name
	FROM per_all_people_f ppf
	,PER_ALL_ASSIGNMENTS_M paa
	,PER_PERSON_NAMES_F ppn
	WHERE (ppf.PERSON_ID = paa.PERSON_ID
	AND(TRUNC(sysdate) BETWEEN ppf.EFFECTIVE_START_DATE AND ppf.EFFECTIVE_END_DATE)
	AND paa.ASSIGNMENT_TYPE IN('E','C')
	AND(TRUNC(sysdate) BETWEEN paa.EFFECTIVE_START_DATE AND paa.EFFECTIVE_END_DATE)
	AND(paa.EFFECTIVE_LATEST_CHANGE = 'Y')
	AND ppn.person_id               = ppf.person_id
	AND ppn.person_id               = paa.person_id
	AND ppn.name_type               = 'GLOBAL'
	AND(TRUNC(sysdate) BETWEEN ppn.EFFECTIVE_START_DATE AND ppn.EFFECTIVE_END_DATE)
	AND(TO_CHAR(ppf.person_id) = OrgInformationEFFDEO.ORG_INFORMATION6
	and rownum                 = 1)
	))) as RES_COST_CENTER_MANAGER
, OrganizationUnitDEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
, OrganizationUnitDEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
, OrganizationUnitDEO.CREATED_BY RSC_CREATED_BY
, OrganizationUnitDEO.CREATION_DATE RSC_CREATION_DATE
, NULL RSC_LEDGER_ID
, NULL RSC_CHART_OF_ACCOUNTS_ID
, NULL RSC_BUSINESS_UNIT_ID
, NULL RSC_LEGAL_ENTITY_ID
, NULL RSC_ORGANIZATION_ID
, ORGANIZATIONUNITDEO.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID
	
/*
,OrgInformationEFFDEO.ORG_INFORMATION_ID
,OrgInformationEFFDEO.EFFECTIVE_START_DATE
,OrgInformationEFFDEO.EFFECTIVE_END_DATE
,OrgInformationEFFDEO.ACTION_OCCURRENCE_ID
,OrgInformationEFFDEO.ORG_INFORMATION_CONTEXT
,OrgInformationEFFDEO.ORGANIZATION_ID
,OrgInformationEFFDEO.LEGISLATION_CODE
,OrgInformationEFFDEO.CREATED_BY
,OrgInformationEFFDEO.CREATION_DATE
,OrgInformationEFFDEO.LAST_UPDATED_BY
,OrgInformationEFFDEO.LAST_UPDATE_DATE
,OrgInformationEFFDEO.LAST_UPDATE_LOGIN
,OrgInformationEFFDEO.OBJECT_VERSION_NUMBER
,OrgInformationEFFDEO.SEQUENCE_NUMBER
,OrgInformationEFFDEO.MODULE_ID
,OrgInformationEFFDEO.BUSINESS_GROUP_ID
,OrgInformationEFFDEO.ORG_INFORMATION2
,(
	(SELECT vs.description
	FROM HR_COMPANY_VS_V vs
	WHERE(TO_CHAR(vs.flex_value_set_id) = OrgInformationEFFDEO.ORG_INFORMATION2
	AND ROWNUM                          = 1)
	))
,OrgInformationEFFDEO.ORG_INFORMATION1
,ORGINFORMATIONEFFDEO.ORG_INFORMATION4
,(
	(SELECT vs.description
	FROM HR_COST_CENTER_VS_V vs
	WHERE(TO_CHAR(vs.flex_value_set_id) = OrgInformationEFFDEO.ORG_INFORMATION4
	AND ROWNUM                          = 1)
	))
,OrgInformationEFFDEO.ORG_INFORMATION6
,(
	(SELECT JobDPEO.NAME
	FROM per_all_people_f ppf
	,PER_ALL_ASSIGNMENTS_M paa
	,PER_PERSON_NAMES_F ppn
	,PER_PERIODS_OF_SERVICE Pos
	,per_email_addresses email
	,PER_JOBS_F_VL JobDPEO
	,PER_DEPARTMENTS Dept
	,hr_locations_all_f_vl loc
	WHERE(ppf.PERSON_ID = paa.PERSON_ID
	AND(TRUNC(sysdate) BETWEEN ppf.EFFECTIVE_START_DATE AND ppf.EFFECTIVE_END_DATE)
	AND paa.ASSIGNMENT_TYPE IN('E','C')
	AND(TRUNC(sysdate) BETWEEN paa.EFFECTIVE_START_DATE AND paa.EFFECTIVE_END_DATE)
	AND(paa.EFFECTIVE_LATEST_CHANGE = 'Y')
	AND ppn.person_id               = ppf.person_id
	AND ppn.person_id               = paa.person_id
	AND ppn.name_type               = 'GLOBAL'
	AND(TRUNC(sysdate) BETWEEN ppn.EFFECTIVE_START_DATE AND ppn.EFFECTIVE_END_DATE)
	AND ppf.person_id                = pos.person_id
	AND paa.PERIOD_OF_SERVICE_ID     = Pos.PERIOD_OF_SERVICE_ID
	AND(Pos.ACTUAL_TERMINATION_DATE IS NULL
	OR Pos.ACTUAL_TERMINATION_DATE   > TRUNC(sysdate))
	AND ppf.person_id                = email.person_id(+)
	AND ppf.primary_email_id         = email.email_address_id(+)
	AND paa.JOB_ID                   = JobDPEO.JOB_ID(+)
	AND(TRUNC(sysdate) BETWEEN JobDPEO.EFFECTIVE_START_DATE(+) AND JobDPEO.EFFECTIVE_END_DATE(+))
	AND paa.ORGANIZATION_ID = Dept.ORGANIZATION_ID(+)
	AND(TRUNC(sysdate) BETWEEN Dept.EFFECTIVE_START_DATE(+) AND Dept.EFFECTIVE_END_DATE(+))
	AND paa.location_id = loc.location_id(+)
	AND(TRUNC(sysdate) BETWEEN loc.EFFECTIVE_START_DATE(+) AND loc.EFFECTIVE_END_DATE(+)))
	AND(TO_CHAR(ppf.person_id) = OrgInformationEFFDEO.ORG_INFORMATION6
	and rownum                 = 1)
	))*/
from HR_ALL_ORGANIZATION_UNITS_F ORGANIZATIONUNITDEO
,HR_ORGANIZATION_UNITS_F_TL ORGANIZATIONUNITTRANSLATIOND1
,HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO
,HR_ORGANIZATION_INFORMATION_F ORGINFORMATIONEFFDEO
where  ORGANIZATIONUNITDEO.ORGANIZATION_ID      = ORGANIZATIONUNITTRANSLATIOND1.ORGANIZATION_ID
and ORGANIZATIONUNITTRANSLATIOND1.LANGUAGE   = SYS_CONTEXT('USERENV','LANG')
and ORGANIZATIONUNITDEO.EFFECTIVE_START_DATE = ORGANIZATIONUNITTRANSLATIOND1.EFFECTIVE_START_DATE
and ORGANIZATIONUNITDEO.EFFECTIVE_END_DATE   = ORGANIZATIONUNITTRANSLATIOND1.EFFECTIVE_END_DATE
and OrganizationUnitDEO.ORGANIZATION_ID    = OrgUnitClassificationDEO.ORGANIZATION_ID
AND(OrganizationUnitDEO.EFFECTIVE_START_DATE BETWEEN OrgUnitClassificationDEO.EFFECTIVE_START_DATE AND
	OrgUnitClassificationDEO.EFFECTIVE_END_DATE)
and ORGUNITCLASSIFICATIONDEO.CLASSIFICATION_CODE = 'DEPARTMENT'
and ORGANIZATIONUNITDEO.ORGANIZATION_ID = ORGINFORMATIONEFFDEO.ORGANIZATION_ID
and(ORGANIZATIONUNITDEO.EFFECTIVE_START_DATE between ORGINFORMATIONEFFDEO.EFFECTIVE_START_DATE and
	ORGINFORMATIONEFFDEO.EFFECTIVE_END_DATE)
AND ORGINFORMATIONEFFDEO.ORG_INFORMATION_CONTEXT = 'PER_GL_COST_CENTER_INFO' 
--AND SYSDATE BETWEEN OrganizationUnitDEO.EFFECTIVE_START_DATE AND OrganizationUnitDEO.EFFECTIVE_END_DATE
order by OrganizationUnitTranslationD1.NAME ,OrganizationUnitDEO.EFFECTIVE_START_DATE