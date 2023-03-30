/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/'Manage%20Divisions%20-%20Division%20Description.sql $:
* $Id: Manage Divisions - Division Details.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT (CASE
	WHEN EXISTS
		(SELECT NULL
			FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO2
			WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE = 'ENTERPRISE'
			AND OrganizationUnitDEO.ORGANIZATION_ID              = OrgUnitClassificationDEO2.ORGANIZATION_ID
			AND EXISTS
				(SELECT NULL
				FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO3
				WHERE OrgUnitClassificationDEO3.CLASSIFICATION_CODE = 'HCM_DIVISION'
				AND OrgUnitClassificationDEO2.ORGANIZATION_ID       = OrgUnitClassificationDEO3.ORGANIZATION_ID
				AND OrgUnitClassificationDEO3.creation_date         > orgUnitClassificationDEO2.creation_date
			)		
		)
	THEN 'Select an existing organization to define as a'
	ELSE 'Create new'
	END) AS RES_CREATE_DIVISION
,TO_CHAR(OrganizationUnitDEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') AS RES_EFFECTIVE_START_DATE
,OrganizationUnitTranslationD1.NAME                              AS RES_NAME
,(CASE
	WHEN EXISTS
		(SELECT NULL
			FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO2
			WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE = 'ENTERPRISE'
			AND OrganizationUnitDEO.ORGANIZATION_ID              = OrgUnitClassificationDEO2.ORGANIZATION_ID
			AND EXISTS
				(SELECT NULL
				FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO3
				WHERE OrgUnitClassificationDEO3.CLASSIFICATION_CODE = 'HCM_DIVISION'
				AND OrgUnitClassificationDEO2.ORGANIZATION_ID       = OrgUnitClassificationDEO3.ORGANIZATION_ID
				AND OrgUnitClassificationDEO3.creation_date         > orgUnitClassificationDEO2.creation_date
			)		
		)
	THEN
		(SELECT CLASSIFICATION_NAME
		FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO2
		,HR_ORG_CLASSIFICATIONS_VL OrgClassificationEO2
		WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE = 'ENTERPRISE'
		AND OrgUnitClassificationDEO2.CLASSIFICATION_CODE    = OrgClassificationEO2.CLASSIFICATION_CODE
		AND OrganizationUnitDEO.ORGANIZATION_ID              = OrgUnitClassificationDEO2.ORGANIZATION_ID
		AND rownum                                          <= 1
		)
	ELSE NULL
	END) AS RES_CLASSIFICATION
,OrganizationUnitDEO.INTERNAL_ADDRESS_LINE AS RES_INTERNAL_ADDRESS_LINE
,(SELECT meaning
	FROM hr_lookups
	WHERE lookup_type = 'ACTIVE_INACTIVE'
	AND lookup_code   = OrgUnitClassificationDEO.STATUS
	) AS RES_STATUS
,ActionReasonsPEO.ACTION_REASON AS RES_ACTION_REASON
,(SELECT MEANING
	FROM HCM_Lookups
	WHERE LOOKUP_TYPE = 'INTL_EXTL'
	AND lookup_code   = OrganizationUnitDEO.INTERNAL_EXTERNAL_FLAG
	) AS RES_INTERNAL_OR_EXTERNAL
,LocationDPEO.LOCATION_NAME AS RES_LOCATION_NAME
,LocationDPEO.INTERNAL_LOCATION_CODE AS RES_LOCATION_CODE
,OrgInformationEFFDEO.ORG_INFORMATION1 AS RES_REPORTING_NAME
,(SELECT ppn.list_name
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
	AND(TO_CHAR(ppf.person_id) = OrgInformationEFFDEO.ORG_INFORMATION2
	AND ROWNUM                 = 1)
	) AS RES_MANAGER
,OrganizationUnitDEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,OrganizationUnitDEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,OrganizationUnitDEO.CREATED_BY RSC_CREATED_BY
,OrganizationUnitDEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,OrganizationUnitDEO.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HR_ALL_ORGANIZATION_UNITS_F OrganizationUnitDEO
,HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO
,HR_ORG_CLASSIFICATIONS_VL OrgClassificationEO
,HR_LOCATIONS_ALL_F_VL LocationDPEO
,HR_ORGANIZATION_UNITS_F_TL OrganizationUnitTranslationD1
,PER_ACTION_OCCURRENCES ActionOccurrencesEO
,PER_ACTION_REASONS_VL ActionReasonsPEO
,(SELECT ACTION_OCCURRENCE_ID
	,ORGANIZATION_ID
	,EFFECTIVE_START_DATE
	,EFFECTIVE_END_DATE
	,ORG_INFORMATION1
	,ORG_INFORMATION2
	FROM HR_ORGANIZATION_INFORMATION_F 
	WHERE ORG_INFORMATION_CONTEXT = 'PER_ORG_MANAGER_INFO'
	) OrgInformationEFFDEO
WHERE OrganizationUnitDEO.ORGANIZATION_ID        = OrgUnitClassificationDEO.ORGANIZATION_ID
AND OrgUnitClassificationDEO.CLASSIFICATION_CODE = OrgClassificationEO.CLASSIFICATION_CODE
AND OrganizationUnitDEO.LOCATION_ID              = LocationDPEO.LOCATION_ID(+)
AND OrganizationUnitDEO.ORGANIZATION_ID          = OrganizationUnitTranslationD1.ORGANIZATION_ID
AND(OrganizationUnitDEO.ACTION_OCCURRENCE_ID     = ActionOccurrencesEO.ACTION_OCCURRENCE_ID(+)
AND ActionOccurrencesEO.ACTION_REASON_ID         = ActionReasonsPEO.ACTION_REASON_ID(+))
AND OrganizationUnitTranslationD1.Language       = sys_context('USERENV','LANG')
AND OrganizationUnitDEO.EFFECTIVE_START_DATE     = OrganizationUnitTranslationD1.EFFECTIVE_START_DATE
AND OrganizationUnitDEO.EFFECTIVE_END_DATE       = OrganizationUnitTranslationD1.EFFECTIVE_END_DATE
AND(OrganizationUnitDEO.EFFECTIVE_START_DATE BETWEEN OrgUnitClassificationDEO.EFFECTIVE_START_DATE AND OrgUnitClassificationDEO.EFFECTIVE_END_DATE)
AND(OrganizationUnitDEO.EFFECTIVE_START_DATE BETWEEN LocationDPEO.EFFECTIVE_START_DATE(+) AND LocationDPEO.EFFECTIVE_END_DATE(+))
AND OrgClassificationEO.CLASSIFICATION_CODE      = 'HCM_DIVISION'
AND (OrganizationUnitDEO.ACTION_OCCURRENCE_ID     = OrgInformationEFFDEO.ACTION_OCCURRENCE_ID(+)
AND (OrganizationUnitDEO.EFFECTIVE_START_DATE BETWEEN OrgInformationEFFDEO.EFFECTIVE_START_DATE(+) AND OrgInformationEFFDEO.EFFECTIVE_END_DATE(+)))
ORDER BY RES_NAME  
,OrganizationUnitDEO.EFFECTIVE_START_DATE