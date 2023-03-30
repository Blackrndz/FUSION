/* ****************************************************************************
 * $Revision: 49069 $:
 * $Author: Pisan.Jariyasettachok $:
 * $Date: 2015-09-01 17:23:38 +0700 (Tue, 01 Sep 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Manage%20Shifts.sql $:
 * $Id: Manage Facility Shifts - Manage Shifts.sql 49069 2015-09-01 10:23:38Z Pisan.Jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT XleProfiles.Name AS RES_LEGAL_ENTITY
,XleProfiles.LEGAL_ENTITY_IDENTIFIER AS RES_LEGAL_ENTITY_IDENTIFIER
,TO_CHAR(XleProfiles.EFFECTIVE_START_DATE,'DD-Mon-YYYY') AS RES_EFFECTIVE_START_DATE
,WorkDetail.ActionReason AS RES_ACTION_REASON
,WorkDetail.ORG_INFORMATION1 AS RES_WORK_START_TIME
,WorkDetail.ORG_INFORMATION2 AS RES_WORK_END_TIME
,WorkDetail.worktime_number1 AS RES_STANDARD_WORKING_HOURS
,(SELECT meaning
	FROM fnd_lookup_values_vl
	WHERE (lookup_type='FREQUENCY')
	AND (lookup_code  =WorkDetail.org_information4
	AND ROWNUM        =1 )
	) AS RES_STANDARD_WORKING_HOURS_FRE
,WorkDetail.PER_SAL_LEVEL               AS RES_SALARY_LEVEL
,WorkDetail.PER_LEMP_WORKER_NUM         AS RES_WORKER_NUMBER_GENERATION
,WorkDetail.PER_EMP_TERMS_OVERRIDE      AS RES_ALLOW_EMPLOYMENT_TERMS_OVE
,WorkDetail.PPG                         AS RES_PEOPLE_GROUP_FLEXFIELD_STR
,WorkDetail.ORG_INFORMATION_NUMBER3     AS RES_MINIMUM_WORKING_AGE
,WorkDetail.ORG_INFORMATION_NUMBER1     AS RES_MINIMUM_RETIREMENT_AGE
,WorkDetail.ORG_INFORMATION_NUMBER4     AS RES_MAXIMUM_RETIREMENT_AGE
,WorkDetail.ORG_INFORMATION_NUMBER2     AS RES_MAXIMUM_AGE_OF_A_MINOR
,WorkDetail.PER_EMP_MODEL               AS RES_EMPLOYMENT_MODEL
,WorkDetail.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,WorkDetail.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,WorkDetail.CREATED_BY  RSC_CREATED_BY
,WorkDetail.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,XleProfiles.LEGAL_ENTITY_ID RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (SELECT OrganizationUnit.ORGANIZATION_ID,
	OrganizationUnit.EFFECTIVE_START_DATE,
	OrganizationUnit.BUSINESS_GROUP_ID,
	OrganizationUnit.LEGAL_ENTITY_ID,
	OrganizationInfo.ActionReason,
	OrganizationInfo.PER_SAL_LEVEL,
	OrganizationInfo.PER_LEMP_WORKER_NUM,
	OrganizationInfo.PER_EMP_TERMS_OVERRIDE,
	OrganizationInfo.PPG,
	OrganizationInfo.ORG_INFORMATION_NUMBER3,
	OrganizationInfo.ORG_INFORMATION_NUMBER1,
	OrganizationInfo.ORG_INFORMATION_NUMBER4,
	OrganizationInfo.ORG_INFORMATION_NUMBER2,
	OrganizationInfo.PER_EMP_MODEL,
	OrganizationUnit.LAST_UPDATED_BY,
	OrganizationUnit.LAST_UPDATE_DATE,
	OrganizationUnit.CREATED_BY ,
	OrganizationUnit.CREATION_DATE,
	OrganizationWorktime.ORG_INFORMATION1,
	OrganizationWorktime.ORG_INFORMATION4,
	OrganizationWorktime.Org_information_number1 as worktime_number1,
    OrganizationWorktime.ORG_INFORMATION2
	FROM (SELECT OrgInformationEFFDEO.ORG_INFORMATION_ID
		,OrgInformationEFFDEO.ORGANIZATION_ID
		,OrgInformationEFFDEO.EFFECTIVE_START_DATE
		,OrgInformationEFFDEO.EFFECTIVE_END_DATE
		,(SELECT ActionsPEO.ACTION_NAME
			FROM PER_ACTIONS_VL ActionsPEO
			WHERE ActionsPEO.ACTION_ID = OrgInformationEFFDEO.ACTION_OCCURRENCE_ID
			) AS ActionReason
		,((SELECT meaning
			FROM fnd_lookup_values_vl
			WHERE (lookup_type='PER_SAL_LEVEL')
			AND (lookup_code  =OrgInformationEFFDEO.ORG_INFORMATION6
			AND ROWNUM        =1 )) 
			) AS PER_SAL_LEVEL
		,((SELECT meaning
			FROM fnd_lookup_values_vl
			WHERE (lookup_type='PER_LEMP_WORKER_NUM')
			AND (lookup_code  =OrgInformationEFFDEO.ORG_INFORMATION2
			AND ROWNUM        =1 )) 
			) AS PER_LEMP_WORKER_NUM
		,((SELECT meaning
			FROM fnd_lookup_values_vl
			WHERE (lookup_type='PER_EMP_TERMS_OVERRIDE')
			AND (lookup_code  =OrgInformationEFFDEO.ORG_INFORMATION5
			AND ROWNUM        =1 )) 
			) AS PER_EMP_TERMS_OVERRIDE
		,((SELECT ID_FLEX_STRUCTURE_NAME
			FROM FND_ID_FLEX_STRUCTURES_VL
			WHERE (id_flex_code      = 'PPG')
			AND (TO_CHAR(ID_FLEX_NUM)=OrgInformationEFFDEO.ORG_INFORMATION8
			AND ROWNUM               =1 )) 
			) AS PPG
		,OrgInformationEFFDEO.ORG_INFORMATION_NUMBER3
		,OrgInformationEFFDEO.ORG_INFORMATION_NUMBER1
		,OrgInformationEFFDEO.ORG_INFORMATION_NUMBER4
		,OrgInformationEFFDEO.ORG_INFORMATION_NUMBER2
		,((SELECT meaning
			FROM fnd_lookup_values_vl
			WHERE (lookup_type='PER_EMP_MODEL')
			AND (lookup_code  =OrgInformationEFFDEO.ORG_INFORMATION4
			AND ROWNUM        =1 )) 
			) AS PER_EMP_MODEL
		FROM HR_ORGANIZATION_INFORMATION_F OrgInformationEFFDEO
		WHERE OrgInformationEFFDEO.ORG_INFORMATION_CONTEXT = 'PER_LEMP_EMPLOYMENT_INFO'
		) OrganizationInfo
	,(SELECT OrgInformationEFFDEO.ORGANIZATION_ID
        ,OrgInformationEFFDEO.ORG_INFORMATION1
        ,OrgInformationEFFDEO.ORG_INFORMATION4
        ,OrgInformationEFFDEO.Org_information_number1
        ,OrgInformationEFFDEO.ORG_INFORMATION2
        ,OrgInformationEFFDEO.EFFECTIVE_START_DATE 
		,OrgInformationEFFDEO.EFFECTIVE_END_DATE
		FROM HR_ORGANIZATION_INFORMATION_F OrgInformationEFFDEO
		WHERE OrgInformationEFFDEO.ORG_INFORMATION_CONTEXT = 'PER_WORK_DAY_INFO'
		) OrganizationWorktime
	,HR_ALL_ORGANIZATION_UNITS_F OrganizationUnit
	WHERE OrganizationUnit.ORGANIZATION_ID = OrganizationInfo.ORGANIZATION_ID(+)
	AND OrganizationUnit.EFFECTIVE_END_DATE BETWEEN OrganizationInfo.EFFECTIVE_START_DATE AND OrganizationInfo.EFFECTIVE_END_DATE
	AND OrganizationUnit.ORGANIZATION_ID = OrganizationWorktime.ORGANIZATION_ID(+)
	AND OrganizationUnit.EFFECTIVE_END_DATE BETWEEN OrganizationWorktime.EFFECTIVE_START_DATE AND OrganizationWorktime.EFFECTIVE_END_DATE
	) WorkDetail
,(SELECT XleProfiles.NAME
    ,XleProfiles.LEGAL_ENTITY_IDENTIFIER
    ,XleProfiles.LEGAL_ENTITY_ID
    ,OrganizationUnit.effective_start_date
    ,OrganizationUnit.organization_id
	FROM (SELECT XleEntityProfiles.NAME
		,XleEntityProfiles.LEGAL_ENTITY_IDENTIFIER
		,XleEntityProfiles.LEGAL_ENTITY_ID
		,XleEntityProfiles.EFFECTIVE_FROM
		FROM HZ_GEOGRAPHIES GeographyPEO,
		XLE_ENTITY_PROFILES XleEntityProfiles,
		XLE_ENTITY_PROFILES XleEntityProfiles1
		WHERE ((GeographyPEO.GEOGRAPHY_ID          = XleEntityProfiles.GEOGRAPHY_ID)
		AND(GeographyPEO.GEOGRAPHY_TYPE            = 'COUNTRY')
		AND ((XleEntityProfiles.LEGAL_EMPLOYER_FLAG='Y')
		OR (XleEntityProfiles.PSU_FLAG             ='Y'))
		AND (XleEntityProfiles.PARENT_PSU_ID       = XleEntityProfiles1.LEGAL_ENTITY_ID(+)))
		) XleProfiles
    ,HR_ALL_ORGANIZATION_UNITS_F OrganizationUnit
	WHERE XleProfiles.LEGAL_ENTITY_ID = OrganizationUnit.LEGAL_ENTITY_ID(+)
	) XleProfiles
WHERE XleProfiles.LEGAL_ENTITY_ID = WorkDetail.LEGAL_ENTITY_ID
AND XleProfiles.EFFECTIVE_START_DATE = WorkDetail.EFFECTIVE_START_DATE
AND (EXISTS (SELECT 1 FROM HR_ORGANIZATION_INFORMATION_F WHERE ORG_INFORMATION_CONTEXT = 'PER_LEMP_EMPLOYMENT_INFO' AND ORGANIZATION_ID = WorkDetail.organization_id AND EFFECTIVE_START_DATE = WorkDetail.EFFECTIVE_START_DATE)
        OR EXISTS (SELECT 1 FROM HR_ORGANIZATION_INFORMATION_F WHERE ORG_INFORMATION_CONTEXT = 'PER_WORK_DAY_INFO' AND ORGANIZATION_ID = WorkDetail.organization_id AND EFFECTIVE_START_DATE = WorkDetail.EFFECTIVE_START_DATE) )

order by XleProfiles.Name
,XleProfiles.EFFECTIVE_START_DATE