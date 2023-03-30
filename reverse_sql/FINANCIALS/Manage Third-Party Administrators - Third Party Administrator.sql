/* ****************************************************************************
* $Revision: 71621 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2019-03-15 09:40:15 +0700 (Fri, 15 Mar 2019) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Departments%20-%20Manage%20Departments.sql $:
* $Id: Manage Departments - Manage Departments.sql 71621 2019-03-15 02:40:15Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT OrganizationUnitTranslationD1.NAME  AS RES_NAME

, OrganizationUnitDEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
, OrganizationUnitDEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
, OrganizationUnitDEO.CREATED_BY RSC_CREATED_BY
, OrganizationUnitDEO.CREATION_DATE RSC_CREATION_DATE
, NULL RSC_LEDGER_ID
, NULL RSC_CHART_OF_ACCOUNTS_ID
, NULL RSC_BUSINESS_UNIT_ID
, NULL RSC_LEGAL_ENTITY_ID
, NULL RSC_ORGANIZATION_ID
, OrganizationUnitDEO.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM HR_ALL_ORGANIZATION_UNITS_F OrganizationUnitDEO
, HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO
, HR_ORG_CLASSIFICATIONS_VL OrgClassificationEO
, FND_SETID_SETS_VL SetIdSetPEO
, HR_LOCATIONS_ALL_F_VL LocationDPEO
, HR_ORGANIZATION_UNITS_F_TL OrganizationUnitTranslationD1
, PER_ADDRESSES_F AddressDPEO
, PER_ACTION_OCCURRENCES ActionOccurrencesEO
, PER_ACTION_REASONS_VL ActionReasonsPEO
WHERE OrganizationUnitDEO.ORGANIZATION_ID        = OrgUnitClassificationDEO.ORGANIZATION_ID
AND OrgUnitClassificationDEO.CLASSIFICATION_CODE = OrgClassificationEO.CLASSIFICATION_CODE
AND OrgUnitClassificationDEO.SET_ID              = SetIdSetPEO.SET_ID(+)
AND OrganizationUnitDEO.LOCATION_ID              = LocationDPEO.LOCATION_ID(+)
AND OrganizationUnitDEO.ORGANIZATION_ID          = OrganizationUnitTranslationD1.ORGANIZATION_ID
AND(OrganizationUnitDEO.ACTION_OCCURRENCE_ID     = ActionOccurrencesEO.ACTION_OCCURRENCE_ID(+)
AND ActionOccurrencesEO.ACTION_REASON_ID         = ActionReasonsPEO.ACTION_REASON_ID(+))
AND OrganizationUnitTranslationD1.Language       = sys_context('USERENV','LANG')
AND OrganizationUnitDEO.EFFECTIVE_START_DATE     = OrganizationUnitTranslationD1.EFFECTIVE_START_DATE
AND OrganizationUnitDEO.EFFECTIVE_END_DATE       = OrganizationUnitTranslationD1.EFFECTIVE_END_DATE
AND(OrganizationUnitDEO.EFFECTIVE_START_DATE BETWEEN OrgUnitClassificationDEO.EFFECTIVE_START_DATE AND
	OrgUnitClassificationDEO.EFFECTIVE_END_DATE)
AND(OrganizationUnitDEO.EFFECTIVE_START_DATE BETWEEN LocationDPEO.EFFECTIVE_START_DATE(+) AND
	LocationDPEO.EFFECTIVE_END_DATE(+))
AND LocationDPEO.Address_Id = AddressDPEO.Address_Id(+)
AND(LocationDPEO.EFFECTIVE_START_DATE BETWEEN AddressDPEO.EFFECTIVE_START_DATE(+) AND AddressDPEO.EFFECTIVE_END_DATE(+)
	)
and ORGCLASSIFICATIONEO.CLASSIFICATION_CODE = 'BEN TPA'
AND SYSDATE BETWEEN OrganizationUnitDEO.EFFECTIVE_START_DATE AND OrganizationUnitDEO.EFFECTIVE_END_DATE
ORDER BY RES_NAME
,OrganizationUnitDEO.EFFECTIVE_START_DATE