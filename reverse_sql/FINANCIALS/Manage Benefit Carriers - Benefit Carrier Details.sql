/* ****************************************************************************
 * $Revision: 68493 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2018-08-29 15:56:19 +0700 (Wed, 29 Aug 2018) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Allow%20Account%20Updates%20on%20Project-Related%20Distributions%20-%20Profile%20Options.sql $:
 * $Id: Allow Account Updates on Project-Related Distributions - Profile Options.sql 68493 2018-08-29 08:56:19Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT (CASE
    WHEN EXISTS
        (SELECT NULL
        FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO2
		WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE != 'US_CARRIER'
        AND OrganizationUnitDEO.ORGANIZATION_ID = OrgUnitClassificationDEO2.ORGANIZATION_ID
        AND EXISTS
            (SELECT NULL
            FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO3
            WHERE OrgUnitClassificationDEO3.CLASSIFICATION_CODE = 'US_CARRIER'
            AND OrgUnitClassificationDEO2.ORGANIZATION_ID = OrgUnitClassificationDEO3.ORGANIZATION_ID
            AND OrgUnitClassificationDEO3.creation_date > orgUnitClassificationDEO2.creation_date
            )
        )
    THEN 'Select an existing organization to define as a'
    ELSE 'Create new'
    END) AS RES_CREATE_BY
,TO_CHAR(OrganizationUnitDEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') AS RES_EFFECTIVE_START_DATE
,OrganizationUnitTranslationD1.NAME AS RES_NAME
,(CASE
        WHEN EXISTS
            (SELECT NULL
            FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO2
			WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE != 'US_CARRIER'
            AND OrganizationUnitDEO.ORGANIZATION_ID = OrgUnitClassificationDEO2.ORGANIZATION_ID
            AND EXISTS
                (SELECT NULL
                FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO3
                WHERE OrgUnitClassificationDEO3.CLASSIFICATION_CODE = 'US_CARRIER'
                AND OrgUnitClassificationDEO2.ORGANIZATION_ID = OrgUnitClassificationDEO3.ORGANIZATION_ID
                AND OrgUnitClassificationDEO3.creation_date > orgUnitClassificationDEO2.creation_date
                )
            )
        THEN
            (SELECT CLASSIFICATION_NAME
            FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO2
            ,HR_ORG_CLASSIFICATIONS_VL OrgClassificationEO2
            WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE != 'US_CARRIER'
            AND OrgUnitClassificationDEO2.CLASSIFICATION_CODE = OrgClassificationEO2.CLASSIFICATION_CODE
            AND OrganizationUnitDEO.ORGANIZATION_ID = OrgUnitClassificationDEO2.ORGANIZATION_ID
            AND rownum <= 1
            )
        ELSE NULL
    END) AS RES_CLASSIFICATION
,OrganizationUnitDEO.INTERNAL_ADDRESS_LINE AS RES_INTERNAL_ADDRESS_LINE
,(SELECT MEANING
    FROM HR_LOOKUPS
    WHERE LOOKUP_TYPE = 'ACTIVE_INACTIVE'
    AND LOOKUP_CODE = OrgUnitClassificationDEO.STATUS
    ) AS RES_STATUS
,(SELECT ACTION_REASON
	FROM PER_ACTION_REASONS_VL
	WHERE ACTION_REASON_ID = ActionOccurrencesEO.ACTION_REASON_ID
	) RES_ACTION_REASON
,LocationDPEO.LOCATION_NAME AS RES_LOCATION
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
,HR_LOCATIONS_ALL_F_VL LocationDPEO
,HR_ORGANIZATION_UNITS_F_TL OrganizationUnitTranslationD1
,PER_ACTION_OCCURRENCES ActionOccurrencesEO
WHERE OrganizationUnitDEO.ORGANIZATION_ID = OrgUnitClassificationDEO.ORGANIZATION_ID
AND OrganizationUnitDEO.LOCATION_ID = LocationDPEO.LOCATION_ID(+)
AND OrganizationUnitDEO.ORGANIZATION_ID = OrganizationUnitTranslationD1.ORGANIZATION_ID
AND OrganizationUnitDEO.ACTION_OCCURRENCE_ID = ActionOccurrencesEO.ACTION_OCCURRENCE_ID(+)
AND OrganizationUnitTranslationD1.Language = sys_context('USERENV','LANG')
AND OrganizationUnitDEO.EFFECTIVE_START_DATE = OrganizationUnitTranslationD1.EFFECTIVE_START_DATE
AND OrganizationUnitDEO.EFFECTIVE_END_DATE = OrganizationUnitTranslationD1.EFFECTIVE_END_DATE
AND(OrganizationUnitDEO.EFFECTIVE_END_DATE BETWEEN OrgUnitClassificationDEO.EFFECTIVE_START_DATE AND OrgUnitClassificationDEO.EFFECTIVE_END_DATE)
AND(OrganizationUnitDEO.EFFECTIVE_END_DATE BETWEEN LocationDPEO.EFFECTIVE_START_DATE(+) AND LocationDPEO.EFFECTIVE_END_DATE(+))
and OrgUnitClassificationDEO.CLASSIFICATION_CODE = 'US_CARRIER'
AND SYSDATE BETWEEN OrganizationUnitDEO.EFFECTIVE_START_DATE AND OrganizationUnitDEO.EFFECTIVE_END_DATE
ORDER BY OrganizationUnitTranslationD1.NAME
,OrganizationUnitDEO.EFFECTIVE_START_DATE