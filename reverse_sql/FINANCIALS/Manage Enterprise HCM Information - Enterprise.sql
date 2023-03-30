/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Enterprise%20HCM%20Information%20-%20Enterprise.sql $:
 * $Id: Manage Enterprise HCM Information - Enterprise.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT QRSLT.name RES_NAME


,QRSLT.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY RSC_CREATED_BY
,QRSLT.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,QRSLT.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT OrganizationUnitDEO.ORGANIZATION_ID
	,OrganizationUnitDEO.EFFECTIVE_START_DATE
	,OrganizationUnitDEO.EFFECTIVE_END_DATE
	,OrganizationUnitDEO.NAME
	,OrganizationUnitDEO.BUSINESS_GROUP_ID
	,OrganizationUnitDEO.last_updated_by
	,OrganizationUnitDEO.last_update_date
	,OrganizationUnitDEO.CREATED_BY
	,OrganizationUnitDEO.CREATION_DATE
	FROM FUSION.HR_ALL_ORGANIZATION_UNITS ORGANIZATIONUNITDEO
	,FUSION.HR_ORG_UNIT_CLASSIFICATIONS_F ORGUNITCLASSIFICATIONDEO
	WHERE ORGUNITCLASSIFICATIONDEO.CLASSIFICATION_CODE = 'ENTERPRISE'
	AND ORGANIZATIONUNITDEO.ORGANIZATION_ID            = OrgUnitClassificationDEO.ORGANIZATION_ID
	/*AND(ORGANIZATIONUNITDEO.EFFECTIVE_START_DATE BETWEEN ORGUNITCLASSIFICATIONDEO.EFFECTIVE_START_DATE AND
		OrgUnitClassificationDEO.EFFECTIVE_END_DATE)*/
	AND (SYSDATE BETWEEN OrganizationUnitDEO.EFFECTIVE_START_DATE AND OrganizationUnitDEO.EFFECTIVE_END_DATE)
	AND OrganizationUnitDEO.EFFECTIVE_START_DATE = OrgUnitClassificationDEO.EFFECTIVE_START_DATE 
	AND OrganizationUnitDEO.EFFECTIVE_END_DATE = OrgUnitClassificationDEO.EFFECTIVE_END_DATE
	) QRSLT
ORDER BY QRSLT.NAME