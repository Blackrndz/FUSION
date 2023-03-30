/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/'Manage%20Divisions%20-%20Division%20Description.sql $:
* $Id: Manage Divisions - Division.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT NAME RES_NAME
,LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CREATED_BY RSC_CREATED_BY
,CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (SELECT OrganizationUnitTranslationD1.NAME
	,ROW_NUMBER() OVER(PARTITION BY OrganizationUnitTranslationD1.NAME ORDER BY OrgInformationEFFDEO.CREATION_DATE) R1
	,OrgInformationEFFDEO.LAST_UPDATED_BY
	,OrgInformationEFFDEO.LAST_UPDATE_DATE
	,OrgInformationEFFDEO.CREATED_BY
	,OrgInformationEFFDEO.CREATION_DATE
	,OrganizationUnitDEO.BUSINESS_GROUP_ID 
	FROM HR_ALL_ORGANIZATION_UNITS_F OrganizationUnitDEO
	,HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO
	,HR_ORGANIZATION_UNITS_F_TL OrganizationUnitTranslationD1
	,HR_ORGANIZATION_INFORMATION_F OrgInformationEFFDEO
	WHERE OrganizationUnitDEO.ORGANIZATION_ID        = OrgUnitClassificationDEO.ORGANIZATION_ID
	AND OrganizationUnitDEO.ACTION_OCCURRENCE_ID     = OrgInformationEFFDEO.ACTION_OCCURRENCE_ID
	AND OrganizationUnitDEO.ORGANIZATION_ID          = OrganizationUnitTranslationD1.ORGANIZATION_ID
	AND OrganizationUnitTranslationD1.Language       = sys_context('USERENV','LANG')
	AND OrganizationUnitDEO.EFFECTIVE_START_DATE     = OrganizationUnitTranslationD1.EFFECTIVE_START_DATE
	AND OrganizationUnitDEO.EFFECTIVE_END_DATE       = OrganizationUnitTranslationD1.EFFECTIVE_END_DATE

	AND OrgUnitClassificationDEO.CLASSIFICATION_CODE      = 'HCM_DIVISION'
	AND OrgInformationEFFDEO.ORG_INFORMATION_CONTEXT = 'PER_ORG_MANAGER_INFO'
	AND OrgInformationEFFDEO.ORG_INFORMATION1       IS NOT NULL)
WHERE R1 = 1
ORDER BY NAME 