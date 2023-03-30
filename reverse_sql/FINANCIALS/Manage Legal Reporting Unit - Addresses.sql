/* ****************************************************************************
 * $Revision: 56510 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-07-06 09:21:36 +0700 (Wed, 06 Jul 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Locations%20(United%20States)%20-%20Manage%20Locations.sql $:
 * $Id: Manage Locations (United States) - Manage Locations.sql 56510 2016-07-06 02:21:36Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT QRSLT.NAME RES_LEGAL_ENTITY
,(SELECT LEGAL_ENTITY_IDENTIFIER
	FROM XLE_ENTITY_PROFILES
	WHERE LEGAL_ENTITY_ID = QRSLT.LEGAL_ENTITY_ID
	) RES_LEGAL_ENTITY_IDENTIFIER
,QRSLT.GEOGRAPHY_NAME RES_TERRITORY
,QRSLT.REGISTERED_NAME RES_LEGAL_REPORTING_UNIT_NAME
,QRSLT.REGISTRATION_NUMBER RES_LEGAL_REPORTING_UNIT_REGIS
,partySitesE0.PARTY_SITE_NUMBER RES_SITE_NUMBER
,TO_CHAR(partySitesE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(partySitesE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE

,partySitesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,partySitesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,partySitesE0.CREATED_BY  RSC_CREATED_BY
,partySitesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT XleEtbProfiles.PARTY_ID
	,XleEtbProfiles.LEGAL_ENTITY_ID
	,XleEtbProfiles.ENTERPRISE_ID
	,(SELECT NAME
		FROM XLE_ENTITY_PROFILES
		WHERE LEGAL_ENTITY_ID = XleEtbProfiles.LEGAL_ENTITY_ID
		) NAME
	,XleEtbProfiles.MAIN_ESTABLISHMENT_FLAG
	,XleEtbProfiles.MAIN_EFFECTIVE_FROM
	,XleEtbProfiles.MAIN_EFFECTIVE_TO
	,XleEtbProfiles.EFFECTIVE_FROM
	,XleEtbProfiles.EFFECTIVE_TO
	,XleEtbProfiles.LAST_UPDATED_BY
	,XleEtbProfiles.CREATION_DATE
	,XleEtbProfiles.LAST_UPDATE_DATE
	,XleEtbProfiles.CREATED_BY
	,XleEtbProfiles.ACTIVITY_CODE
	,XleEtbProfiles.SUB_ACTIVITY_CODE
	,XleEtbProfiles.TYPE_OF_COMPANY
	,RegistrationEO.REGISTERED_NAME
	,RegistrationEO.REGISTRATION_NUMBER
	,hz_format_pub.format_address(p_location_id => RegistrationEO.LOCATION_ID, p_line_break => ',') FORMATTED_ADDRESS
	,GeographyPEO.GEOGRAPHY_NAME
	,GeographyPEO.GEOGRAPHY_TYPE
	,GeographyPEO.GEOGRAPHY_ID
	,Jurisdictions.JURISDICTION_ID
	FROM XLE_ETB_PROFILES XleEtbProfiles
	,XLE_REGISTRATIONS RegistrationEO
	,HZ_GEOGRAPHIES GeographyPEO
	,XLE_JURISDICTIONS_VL Jurisdictions
	WHERE((XleEtbProfiles.ESTABLISHMENT_ID = RegistrationEO.SOURCE_ID(+)
	AND REGISTRATIONEO.IDENTIFYING_FLAG(+) = 'Y'))
	AND(XLEETBPROFILES.GEOGRAPHY_ID = GEOGRAPHYPEO.GEOGRAPHY_ID)
	AND XLEETBPROFILES.GEOGRAPHY_ID = Jurisdictions.GEOGRAPHY_ID
	AND RegistrationEO.JURISDICTION_ID = Jurisdictions.JURISDICTION_ID
	) QRSLT
,HZ_PARTY_SITES partySitesE0
WHERE QRSLT.PARTY_ID = partySitesE0.PARTY_ID
AND partySitesE0.STATUS = 'A'
ORDER BY QRSLT.NAME
,DECODE(partySitesE0.IDENTIFYING_ADDRESS_FLAG,'Y',1,2)