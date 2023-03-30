/* ****************************************************************************
 * $Revision: 53575 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-03-16 15:30:29 +0700 (Wed, 16 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Legal%20Reporting%20Unit%20Financial%20Information%20-%20Manage%20Financials%20Information.sql $:
 * $Id: Manage Legal Reporting Unit Financial Information - Manage Financials Information.sql 53575 2016-03-16 08:30:29Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT
	(SELECT NAME
	FROM XLE_ENTITY_PROFILES
	WHERE LEGAL_ENTITY_ID = XleEtbProfiles.LEGAL_ENTITY_ID
	)                                      AS RES_LEGAL_ENTITY
,(SELECT LEGAL_ENTITY_IDENTIFIER 
	FROM XLE_ENTITY_PROFILES
	WHERE LEGAL_ENTITY_ID = XleEtbProfiles.LEGAL_ENTITY_ID
	)                               AS RES_LEGAL_ENTITY_IDENTIFIER
,XleEtbProfiles.NAME                    AS RES_LEGAL_REPORTING_UNIT
,RegistrationEO.REGISTRATION_NUMBER RES_REGISTRATION_NUMBER

,XleEtbProfiles.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,XleEtbProfiles.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,XleEtbProfiles.CREATED_BY RSC_CREATED_BY
,XleEtbProfiles.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM XLE_ETB_PROFILES XleEtbProfiles
,XLE_REGISTRATIONS RegistrationEO
,HZ_GEOGRAPHIES GeographyPEO
WHERE(XleEtbProfiles.ESTABLISHMENT_ID  = RegistrationEO.SOURCE_ID(+)
AND REGISTRATIONEO.IDENTIFYING_FLAG(+) = 'Y')
AND(XleEtbProfiles.GEOGRAPHY_ID        = GeographyPEO.GEOGRAPHY_ID)
ORDER BY RES_LEGAL_ENTITY