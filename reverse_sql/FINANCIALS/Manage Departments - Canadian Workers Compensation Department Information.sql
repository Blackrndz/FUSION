/* ****************************************************************************
 * $Revision: 65491 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-12-07 17:55:01 +0700 (Thu, 07 Dec 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Manage%20Job%20-%20Canadian%20Workers%20Compensation.sql $:
 * $Id: Manage Job - Canadian Workers Compensation.sql 65491 2017-12-07 10:55:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT TO_CHAR(OrganizationUnitDEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') AS RES_EFFECTIVE_START_DATE
, OrganizationUnitTranslationD1.NAME                                AS RES_NAME
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
		ELSE NULL
	END) AS RES_CLASSIFICATION
,(SELECT ppsu.name
    FROM xle_entity_profiles xep
    ,hz_geographies hzg
    ,per_payroll_statutory_units ppsu
    WHERE xep.geography_id = hzg.geography_id
    and hzg.country_code='CA'
    and hzg.geography_type='COUNTRY'
    and hzg.geography_use='MASTER_REF'
    and xep.le_information_context = 'CA'
    and nvl(xep.parent_psu_id,xep.legal_entity_id) = ppsu.legal_entity_id
    and sysdate between ppsu.effective_start_date and ppsu.effective_end_date
    AND ppsu.organization_id = JOBLEGISLATIVEDEO.INFORMATION_NUMBER1 
	) RES_WORKERS_COMPENSATION_PAYRO
,(
	(SELECT GeographyIdentifierPEO1.IDENTIFIER_VALUE
	FROM HZ_GEOGRAPHIES GeographyPEO
	,HZ_GEOGRAPHY_IDENTIFIERS GeographyIdentifierPEO
	,HZ_GEOGRAPHY_IDENTIFIERS GeographyIdentifierPEO1
	WHERE(GeographyPEO.GEOGRAPHY_ID                      = GeographyIdentifierPEO.GEOGRAPHY_ID
	AND GeographyPEO.COUNTRY_CODE                        = 'CA'
	AND GeographyPEO.GEOGRAPHY_TYPE                      = 'PROVINCE'
	AND GeographyPEO.GEOGRAPHY_USE                       = 'MASTER_REF'
	AND GeographyIdentifierPEO.IDENTIFIER_TYPE           = 'CODE'
	AND GeographyIdentifierPEO.GEOGRAPHY_USE             = 'MASTER_REF'
	AND GeographyIdentifierPEO.GEO_DATA_PROVIDER         = 'VERTEX'
	AND GeographyIdentifierPEO.IDENTIFIER_SUBTYPE        = 'GEO_CODE'
	AND GeographyPEO.GEOGRAPHY_ID                        = GeographyIdentifierPEO1.GEOGRAPHY_ID
	AND GeographyIdentifierPEO1.GEOGRAPHY_USE            = 'MASTER_REF'
	AND GeographyIdentifierPEO1.IDENTIFIER_TYPE          = 'NAME'
	AND GeographyIdentifierPEO1.LANGUAGE_CODE            = USERENV('LANG')
	AND LENGTH(GeographyIdentifierPEO1.IDENTIFIER_VALUE) > 2)
	AND(SUBSTR(SUBSTR(GeographyIdentifierPEO.IDENTIFIER_VALUE,instr(GeographyIdentifierPEO.IDENTIFIER_VALUE,'-',1) + 1,(
		instr(GeographyIdentifierPEO.IDENTIFIER_VALUE,'-',                                                            - 1) -(
		instr(GeographyIdentifierPEO.IDENTIFIER_VALUE,'-',1)))                                                        - 1),0,
		150)      = JOBLEGISLATIVEDEO.INFORMATION1
	and rownum = 1) 
	)) RES_WORKERS_COMPENSATION_PROVI
,JOBLEGISLATIVEDEO.INFORMATION2 RES_WORKERS_COMPENSATION_CLASS
,JOBLEGISLATIVEDEO.LAST_UPDATED_BY as RSC_LAST_UPDATED_BY
,JOBLEGISLATIVEDEO.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
,JOBLEGISLATIVEDEO.CREATED_BY  RSC_CREATED_BY
,JOBLEGISLATIVEDEO.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, OrganizationUnitDEO.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID
    
FROM HR_ALL_ORGANIZATION_UNITS_F OrganizationUnitDEO
, HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO
, HR_ORG_CLASSIFICATIONS_VL OrgClassificationEO
, HR_ORGANIZATION_UNITS_F_TL OrganizationUnitTranslationD1
,HR_ALL_POSITIONS_F hrALLPOREO
,PER_JOB_LEG_F JOBLEGISLATIVEDEO
WHERE OrganizationUnitDEO.ORGANIZATION_ID = hrALLPOREO.ORGANIZATION_ID
AND OrgUnitClassificationDEO.CLASSIFICATION_CODE = OrgClassificationEO.CLASSIFICATION_CODE
AND OrganizationUnitDEO.ORGANIZATION_ID          = OrganizationUnitTranslationD1.ORGANIZATION_ID
AND OrganizationUnitTranslationD1.Language       = sys_context('USERENV','LANG')
AND OrganizationUnitDEO.EFFECTIVE_START_DATE     = OrganizationUnitTranslationD1.EFFECTIVE_START_DATE
AND OrganizationUnitDEO.EFFECTIVE_END_DATE       = OrganizationUnitTranslationD1.EFFECTIVE_END_DATE
AND(OrganizationUnitDEO.EFFECTIVE_START_DATE BETWEEN OrgUnitClassificationDEO.EFFECTIVE_START_DATE AND
	OrgUnitClassificationDEO.EFFECTIVE_END_DATE)
and ORGCLASSIFICATIONEO.CLASSIFICATION_CODE = 'DEPARTMENT'
AND hrALLPOREO.JOB_ID = JOBLEGISLATIVEDEO.JOB_ID
AND JOBLEGISLATIVEDEO.INFORMATION_CATEGORY = 'ORA_HRX_CA_WC_JOBS'
ORDER BY OrganizationUnitTranslationD1.NAME
,OrganizationUnitDEO.EFFECTIVE_START_DATE